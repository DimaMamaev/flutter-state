import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/products/products.dart';
import '../product-item/product-item.dart';

class ProductsListWidget extends StatelessWidget {
  final bool displayFavorites;
  ProductsListWidget(this.displayFavorites);
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);
    final productsList =
        displayFavorites ? productsData.favoritesItems : productsData.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 2 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 15,
      ),
      itemBuilder: (ctx, index) => ChangeNotifierProvider.value(
        value: productsList[index],
        child: ProductItem(),
      ),
      itemCount: productsList.length,
    );
  }
}
