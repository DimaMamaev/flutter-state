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
        title: Text('title'),
      ),
      body: Center(),
    );
  }
}
