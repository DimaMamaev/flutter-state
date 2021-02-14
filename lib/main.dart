import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/orders/orders.dart';
import './providers/orders/orders.dart';
import './screens/cart/cart.dart';
import './providers/products/products.dart';
import './providers/cart/cart.dart';
import './screens/product-details/product-details.dart';
import './screens/products-list/products-list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => ProductsProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => OrdersProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Shop app',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: ProductsListScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => CartScreen(),
          OrdersScreen.routeName: (ctx) => OrdersScreen(),
        },
      ),
    );
  }
}
