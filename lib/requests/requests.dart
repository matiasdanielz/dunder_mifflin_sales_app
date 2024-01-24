import 'dart:convert';
import 'package:flutter_application_5/models/productItem.dart';
import 'package:http/http.dart' as http;

class Requests {
  final String baseUrl =
      'https://api-keyway-app.azurewebsites.net/api/services/app';

  Future<Map<String, dynamic>> getUserDetails() async {
    String credentials = base64.encode(utf8.encode('admin:123qwe'));

    final response = await http.get(
      Uri.parse('$baseUrl/Session/GetCurrentLoginInformations'),
      headers: {
        'Authorization': 'Basic $credentials',
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      final Map<String, dynamic> userData =
          json.decode(response.body)['result']['user'];
      return userData;
    } else {
      throw Exception('Failed to get user details');
    }
  }

  Future<List<ProductItem>> getProducts() async {
    String credentials = base64.encode(utf8.encode('admin:123qwe'));

    final response = await http.get(
      Uri.parse('$baseUrl/Produto/GetAll'),
      headers: {
        'Authorization': 'Basic $credentials',
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> productsData = data['result']['items'];

      List<ProductItem> products = productsData.map((productData) {
        return ProductItem(
          title: productData['nome'],
          image: productData['file']['imagem'],
          tags: [productData['categoriaNome'], productData['subcategoriaNome']],
          price: productData['precoAtual'],
        );
      }).toList();

      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
