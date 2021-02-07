import 'package:flutter/material.dart';

class CartWidgetItem extends StatelessWidget {
  final String id;
  final String title;
  final double price;
  final int quantity;

  CartWidgetItem({
    @required this.id,
    @required this.title,
    @required this.price,
    @required this.quantity,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: EdgeInsets.all(5),
        child: ListTile(
          leading: CircleAvatar(
            child: FittedBox(child: Text(price.toString())),
          ),
          title: Text(title),
          subtitle: Text('Total: \$${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
