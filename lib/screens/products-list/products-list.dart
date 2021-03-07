import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../screens/cart/cart.dart';
import '../../widgets/drawer/drawer.dart';
import '../../providers/cart/cart.dart';
import '../../widgets/badge/badge.dart';
import '../../widgets/product-list/product-list.dart';
import '../../providers/products/products.dart';

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
  bool _isInit = true;
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<ProductsProvider>(context).fetchProductsData().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;

    super.didChangeDependencies();
  }

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
          ),
          Consumer<CartProvider>(
            builder: (_, cartData, child) => Padding(
              padding: EdgeInsets.only(right: 10),
              child: Badge(
                color: Colors.red,
                child: IconButton(
                    icon: Icon(
                      Icons.shopping_cart,
                      color: Colors.white,
                    ),
                    onPressed: () =>
                        Navigator.of(context).pushNamed(CartScreen.routeName)),
                value: cartData.itemsCount.toString(),
              ),
            ),
          ),
        ],
      ),
      drawer: AppDrawer(),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ProductsListWidget(_displayFavorites),
    );
    return scaffold;
  }
}
