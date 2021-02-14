import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../providers/orders/orders.dart' as orders;

class OrderItem extends StatelessWidget {
  final orders.OrderItem order;

  OrderItem(this.order);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.amount}'),
            subtitle: Text(DateFormat('dd MM yyyy').format(order.dateTime)),
            trailing: IconButton(
              icon: Icon(Icons.expand_more_rounded),
              onPressed: null,
            ),
          )
        ],
      ),
    );
  }
}
