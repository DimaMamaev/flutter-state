import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../product/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];

  List<Product> get items {
    return [..._items];
  }

  List<Product> get favoritesItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Product findbyId(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  Future<void> fetchProductsData() async {
    const endPoint =
        'https://flutter-shop-e0ce3-default-rtdb.europe-west1.firebasedatabase.app/products.json';

    try {
      final response = await http.get(endPoint);
      final parseResponse = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> loadedList = [];
      parseResponse.forEach((prodId, prodData) {
        loadedList.add(Product(
          description: prodData['description'],
          id: prodId,
          title: prodData['title'],
          imageUrl: prodData['imageUrl'],
          price: prodData['price'],
          isFavorite: prodData['isFavorite'],
        ));
      });
      _items = loadedList;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) {
    const endPoint =
        'https://flutter-shop-e0ce3-default-rtdb.europe-west1.firebasedatabase.app/products.json';
    return http
        .post(endPoint,
            body: json.encode({
              'title': product.title,
              'description': product.description,
              'imageUrl': product.imageUrl,
              'price': product.price,
              'isFavorite': product.isFavorite,
            }))
        .then((response) {
      print(json.decode(response.body));
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );
      _items.insert(0, newProduct);
      notifyListeners();
    }).catchError((error) {
      throw error;
    });
  }

  Future<void> updateProduct(String id, Product updatedProduct) async {
    final updatedIndex = _items.indexWhere((element) => element.id == id);
    if (updatedIndex >= 0) {
      final endPoint =
          'https://flutter-shop-e0ce3-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json';
      try {
        await http.patch(endPoint,
            body: json.encode({
              'title': updatedProduct.title,
              'description': updatedProduct.description,
              'imageUrl': updatedProduct.imageUrl,
              'price': updatedProduct.price,
            }));
      } catch (error) {
        throw error;
      }
      _items[updatedIndex] = updatedProduct;
      notifyListeners();
    }
  }

  Future<void> removeProduct(String id) async {
    final endPoint =
        'https://flutter-shop-e0ce3-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json';
    try {
      await http.delete(endPoint);
    } catch (error) {
      throw error;
    }
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
