import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../product/product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Shirt',
      description: 'Just a shirt',
      price: 29.99,
      imageUrl:
          'https://www.all4o.com/image/cache/data/brand/TrueStory/TRUE-STORY-Elite-orienteering-shirt-Men-Deep-BLUE-800x800.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl: 'https://content.moss.co.uk/images/original/966353577_01.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://images-na.ssl-images-amazon.com/images/I/8105zBthh7L._AC_UL1500_.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://www.schneider-gmbh.com/assets/produktbilder/531076-9f4e44ef315e685e75f59a6a251843f05b28d46ce7e281a295a7e2e29a8577e3.jpg',
    ),
  ];

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

  void updateProduct(String id, Product updatedProduct) {
    final updatedIndex = _items.indexWhere((element) => element.id == id);
    if (updatedIndex >= 0) {
      _items[updatedIndex] = updatedProduct;
      notifyListeners();
    }
  }

  void removeProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
