import 'package:flutter/material.dart';
import '../../widgets/product-list/product-list.dart';

enum SelectedOptions {
  Favorites,
  All,
}

class ProductsListScreen extends StatefulWidget {
  @override
  _ProductsListScreenState createState() => _ProductsListScreenState();
}

class _ProductsListScreenState extends State<ProductsListScreen> {
  bool _displayFavorites = false;

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
      appBar: AppBar(
        title: const Text('Shop'),
        actions: [
          PopupMenuButton(
            onSelected: (SelectedOptions selectedValue) => {
              setState(() {
                if (selectedValue == SelectedOptions.Favorites) {
                  _displayFavorites = true;
                } else {
                  _displayFavorites = false;
                }
              })
            },
            icon: Icon(Icons.more_vert_outlined),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Favorites'),
                value: SelectedOptions.Favorites,
              ),
              PopupMenuItem(
                child: Text('All products'),
                value: SelectedOptions.All,
              ),
            ],
          )
        ],
      ),
      body: ProductsListWidget(_displayFavorites),
    );
    return scaffold;
  }
}
