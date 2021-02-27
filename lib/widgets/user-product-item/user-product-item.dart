import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/providers/products/products.dart';

import '../../screens/edit-product/edit-product.dart';

class UserProductItem extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String id;

  UserProductItem({this.imageUrl, this.title, this.id});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: CircleAvatar(
        backgroundImage: NetworkImage(imageUrl),
      ),
      trailing: Container(
        width: 100,
        child: Row(
          children: [
            IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    EditProductScreen.routeName,
                    arguments: id,
                  );
                }),
            IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  Provider.of<ProductsProvider>(context, listen: false)
                      .removeProduct(id);
                }),
          ],
        ),
      ),
    );
  }
}
