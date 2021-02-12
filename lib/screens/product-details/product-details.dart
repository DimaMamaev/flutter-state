import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products/products.dart';

class ProductDetailsScreen extends StatelessWidget {
  static const String routeName = '/product-details';
  @override
  Widget build(BuildContext context) {
    final currentOrderId = ModalRoute.of(context).settings.arguments as String;
    final order =
        Provider.of<ProductsProvider>(context).findbyId(currentOrderId);
    return Scaffold(
      appBar: AppBar(
        title: Text(order.title),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Container(
            height: 300,
            width: double.infinity,
            child: Image.network(
              order.imageUrl,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text('\$${order.price}'),
          SizedBox(
            height: 10,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                order.description,
                softWrap: true,
              ))
        ]),
      ),
    );
  }
}
