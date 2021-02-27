import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/edit-product/edit-product.dart';
import '../../widgets/drawer/drawer.dart';
import '../../widgets/user-product-item/user-product-item.dart';
import '../../providers/products/products.dart';

class UserProductsScreen extends StatelessWidget {
  static const routeName = '/user-products-items';
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<ProductsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your products'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () =>
                Navigator.of(context).pushNamed(EditProductScreen.routeName),
          )
        ],
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (ctx, i) => Column(
            children: [
              UserProductItem(
                title: productsData.items[i].title,
                imageUrl: productsData.items[i].imageUrl,
                id: productsData.items[i].id,
              ),
              Divider(),
            ],
          ),
          itemCount: productsData.items.length,
        ),
      ),
    );
  }
}
