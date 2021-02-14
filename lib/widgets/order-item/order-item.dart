import 'package:flutter/material.dart';
import 'dart:math';
import 'package:intl/intl.dart';

import '../../providers/orders/orders.dart' as orders;

class OrderItem extends StatefulWidget {
  final orders.OrderItem order;

  OrderItem(this.order);

  @override
  _OrderItemState createState() => _OrderItemState();
}

class _OrderItemState extends State<OrderItem> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${widget.order.amount}'),
            subtitle:
                Text(DateFormat('dd MM yyyy').format(widget.order.dateTime)),
            trailing: IconButton(
              icon: Icon(_expanded
                  ? Icons.expand_less_rounded
                  : Icons.expand_more_rounded),
              onPressed: () => setState(() {
                _expanded = !_expanded;
              }),
            ),
          ),
          if (_expanded)
            Container(
              height: min(widget.order.products.length * 20.0 + 15, 180),
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (ctx, i) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(widget.order.products[i].title),
                      Text(
                          '${widget.order.products[i].quantity}x \$${widget.order.products[i].price}')
                    ],
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
