import 'package:flutter/material.dart';
import '../../widgets/product-list/product-list.dart';

class ProductsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: ProductsListWidget(),
    );
    return scaffold;
  }
}
