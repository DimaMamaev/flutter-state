import 'package:flutter/material.dart';
import 'package:shop/models/products.dart';
import 'package:shop/widgets/product-item/product-item.dart';

class ProductsListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 15,
        ),
        itemBuilder: (ctx, index) => ProductItem(
          id: productsList[index].id,
          title: productsList[index].title,
          imageUrl: productsList[index].imageUrl,
        ),
        itemCount: productsList.length,
      ),
    );
  }
}
