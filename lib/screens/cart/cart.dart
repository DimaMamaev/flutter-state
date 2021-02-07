import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/cart/cart.dart';

class CartScreen extends StatelessWidget {
  static const routeName = '/cartScreen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('cart'),
      ),
      body: Column(
        children: [
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total'),
                  Spacer(),
                  Chip(
                    label: Text(cart.totalAmount.toString()),
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  FlatButton(onPressed: null, child: Text('Order now'))
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
