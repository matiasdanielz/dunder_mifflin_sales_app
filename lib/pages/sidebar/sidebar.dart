import 'package:flutter/material.dart';
import 'package:flutter_application_5/pages/homepage/homepage.dart';
import 'package:flutter_application_5/pages/profile/profile.dart';

class SideBarPage extends StatelessWidget {
  const SideBarPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 2.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Menu",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      IconButton(
                        onPressed: () => {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomePage(),
                            ),
                          )
                        },
                        icon: const Icon(
                          Icons.close,
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 15.0, vertical: 2.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(4.0)),
                    child: Padding(
                        padding: const EdgeInsets.all(
                          8.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Expanded(
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundImage:
                                        AssetImage("Assets/images/dwight.jpeg"),
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Dwight Schrute",
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "dwight.schrute@gmail.com",
                                        style: TextStyle(
                                          fontSize: 12,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ProfilePage(),
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                          ],
                        )),
                  ),
                ),
                ListTile(
                  iconColor: Colors.grey[600],
                  textColor: Colors.grey[600],
                  leading: const Icon(
                    Icons.settings,
                  ),
                  title: const Text("Configurações"),
                  subtitle: const Text(
                    "Configurações do aplicativo",
                  ),
                ),
                ListTile(
                  iconColor: Colors.grey[600],
                  textColor: Colors.grey[600],
                  leading: const Icon(
                    Icons.payment,
                  ),
                  title: const Text("Formas De Pagamento"),
                  subtitle: const Text(
                    "Minhas formas de pagamento",
                  ),
                ),
                ListTile(
                  iconColor: Colors.grey[600],
                  textColor: Colors.grey[600],
                  leading: const Icon(
                    Icons.confirmation_num,
                  ),
                  title: const Text("Cupons"),
                  subtitle: const Text(
                    "Meus cupons de desconto",
                  ),
                ),
                ListTile(
                  iconColor: Colors.grey[600],
                  textColor: Colors.grey[600],
                  leading: const Icon(
                    Icons.favorite,
                  ),
                  title: const Text("Favoritos"),
                  subtitle: const Text(
                    "Meus produtos favoritos",
                  ),
                ),
                ListTile(
                  iconColor: Colors.grey[600],
                  textColor: Colors.grey[600],
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: const Text("Sair da conta"),
                  subtitle: const Text(
                    "Sair da minha conta",
                  ),
                ),
              ],
            ),
          ),
          Container(
            alignment: Alignment.bottomLeft,
            padding: const EdgeInsets.only(bottom: 10.0, left: 15.0),
            child: Text(
              "Versão 1.1.0",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
