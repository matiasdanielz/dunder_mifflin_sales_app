import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_5/models/productItem.dart';
import 'package:flutter_application_5/pages/products/products.dart';
import 'package:flutter_application_5/pages/serviceRequest/serviceRequest.dart';
import 'package:flutter_application_5/pages/sidebar/sidebar.dart';
import 'package:flutter_application_5/requests/requests.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final List<String> _pageTitles = ["Tela Inicial", "Produtos", "Notificações"];

  late Future<List<ProductItem>> productsFuture;

  @override
  void initState() {
    super.initState();
    productsFuture = _loadProducts();
  }

  Future<List<ProductItem>> _loadProducts() async {
    try {
      final List<ProductItem> products = await Requests().getProducts();
      return products;
    } catch (error) {
      print('Error fetching products: $error');
      throw error;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SideBarPage(),
              ),
            );
          },
          icon: const Icon(
            Icons.menu,
          ),
        ),
        centerTitle: true,
        title: Text(
          _pageTitles[_selectedIndex],
        ),
      ),
      body: _selectedIndex == 0
          ? HomeContent(productsFuture: productsFuture)
          : ProductsPage(),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_sharp,
            ),
            label: "Tela Inicial",
            backgroundColor: Colors.blueAccent,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.receipt,
            ),
            label: "Produtos",
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.notifications,
            ),
            label: "Notificações",
            backgroundColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class HomeContent extends StatelessWidget {
  final Future<List<ProductItem>> productsFuture;

  HomeContent({required this.productsFuture});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 18.0,
        vertical: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Produtos",
            style: TextStyle(
              fontSize: 18,
              color: Colors.blue[800],
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: FutureBuilder<List<ProductItem>>(
              future: productsFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: 200,
                    color: Colors.transparent,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 12,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Skelton(
                            height: 200,
                            width: 150,
                          ),
                        );
                      },
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<ProductItem> productItems = snapshot.data ?? [];
                  return Container(
                    height: 250,
                    child: ListView.builder(
                      itemCount: productItems.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return ProductItemCard(
                          item: productItems[index],
                        );
                      },
                    ),
                  );
                }
              },
            ),
          ),
          ElevatedButton(
            style: TextButton.styleFrom(
              minimumSize: const Size(
                double.infinity,
                50,
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ServiceRequest(),
                ),
              );
            },
            child: Container(
              decoration: const BoxDecoration(),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.call,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Nova Solicitação",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProductItemCard extends StatelessWidget {
  final ProductItem item;

  ProductItemCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.memory(
            base64Decode(
              item.image,
            ),
            height: 150,
            width: 150,
          ),
          Text(
            item.title,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14.0,
            ),
          ),
          SizedBox(height: 8.0),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              'R\$${item.price}',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Skelton extends StatelessWidget {
  const Skelton({Key? key, this.height, this.width}) : super(key: key);

  final double? height, width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
    );
  }
}
