import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_application_5/models/productItem.dart';
import 'package:flutter_application_5/requests/requests.dart';

class ProductsPage extends StatefulWidget {
  @override
  _ProductsPage createState() => _ProductsPage();
}

class _ProductsPage extends State<ProductsPage> {
  final Requests requests = Requests();
  late Future<List<ProductItem>> productsFuture;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    productsFuture = _loadProducts();
  }

  Future<List<ProductItem>> _loadProducts() async {
    try {
      return await requests.getProducts();
    } catch (error) {
      print('Error fetching products: $error');
      throw error;
    }
  }

  List<ProductItem> _filterProducts(
      List<ProductItem> allProducts, String query) {
    if (query.isEmpty) {
      return allProducts;
    } else {
      return allProducts.where((product) {
        return product.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20.0,
        left: 20.0,
        right: 20.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              labelText: 'Pesquisar',
              hintStyle: TextStyle(
                color: Colors.grey,
                fontFamily: 'Segoe',
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
              ),
            ),
            controller: searchController,
            onChanged: (query) {
              setState(
                () {
                  productsFuture = _loadProducts().then(
                    (allProducts) {
                      return _filterProducts(allProducts, query);
                    },
                  );
                },
              );
            },
          ),
          SizedBox(height: 20.0),
          FutureBuilder<List<ProductItem>>(
            future: productsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, index) {
                      return Skelton(
                        width: 175,
                        height: 250,
                      );
                    },
                  ),
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                List<ProductItem> productItems = snapshot.data ?? [];
                return Expanded(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 18.0,
                      mainAxisSpacing: 8.0,
                      childAspectRatio: 0.6,
                    ),
                    itemCount: productItems.length,
                    itemBuilder: (context, index) {
                      return ProductItemCard(item: productItems[index]);
                    },
                  ),
                );
              }
            },
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
      child: SizedBox.shrink(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.memory(
              base64Decode(
                item.image,
              ),
              height: 100,
              width: double.infinity,
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
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              runSpacing: 5,
              spacing: 4.0,
              children: item.tags.map((tag) {
                return Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18.0),
                      color: Colors.grey),
                  child: Text(tag),
                );
              }).toList(),
            ),
            Spacer(),
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
