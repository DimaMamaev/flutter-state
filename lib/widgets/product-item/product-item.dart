import 'package:flutter/material.dart';
import 'package:shop/screens/product-details/product-details.dart';

class ProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  ProductItem({
    @required this.id,
    @required this.title,
    @required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          onTap: () => Navigator.of(context)
              .pushNamed(ProductDetailsScreen.routeName, arguments: id),
          child: Image.network(
            imageUrl,
            fit: BoxFit.fill,
          ),
        ),
        footer: GridTileBar(
          leading: IconButton(
            icon: Icon(
              Icons.favorite_rounded,
              color: Colors.red,
            ),
            onPressed: null,
          ),
          backgroundColor: Colors.black87,
          title: Text(
            title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart,
              color: Colors.green,
            ),
            onPressed: null,
          ),
        ),
      ),
    );
  }
}
