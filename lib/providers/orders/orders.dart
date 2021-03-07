import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../../providers/cart/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    @required this.id,
    @required this.amount,
    @required this.products,
    @required this.dateTime,
  });
}

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];
  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> cartProducts, double total) async {
    const endPoint =
        'https://flutter-shop-e0ce3-default-rtdb.europe-west1.firebasedatabase.app/orders.json';
    try {
      final response = await http.post(endPoint,
          body: json.encode({
            'amount': total,
            'dateTime': DateTime.now().toIso8601String(),
            'products': [
              cartProducts
                  .map((cartProd) => {
                        'id': cartProd.id,
                        'title': cartProd.title,
                        'quantity': cartProd.quantity,
                        'price': cartProd.price,
                      })
                  .toList(),
            ]
          }));
      _orders.insert(
          0,
          OrderItem(
            id: json.decode(response.body)['name'],
            amount: total,
            products: cartProducts,
            dateTime: DateTime.now(),
          ));
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }
}
