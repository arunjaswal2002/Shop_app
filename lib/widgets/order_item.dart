import 'package:flutter/material.dart';
import '../providers/orders.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class OrderedItem extends StatefulWidget {
  // const OrderedItem({Key? key}) : super(key: key);
  final OrderItem order;
  OrderedItem(this.order);

  @override
  State<OrderedItem> createState() => _OrderedItemState();
}

class _OrderedItemState extends State<OrderedItem> {
  bool expanded = false;
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: const EdgeInsets.all(10),
        child: Column(children: <Widget>[
          ListTile(
              title: Text('\$${widget.order.amount}'),
              subtitle: Text(DateFormat('dd/mm/yyyy hh:mm')
                  .format(widget.order.dateOfOrder)),
              trailing: IconButton(
                  icon: Icon(expanded ? Icons.expand_less : Icons.expand_more),
                  onPressed: () {
                    setState(() {
                      expanded = !expanded;
                    });
                  })),
          expanded
              ? Container(
                  margin: const EdgeInsets.all(10),
                  // padding:
                  // const EdgeInsets.symmetric(horizontal: 10, vertical: ),
                  height: min(widget.order.myOrders.length * 20 + 10, 180),
                  child: ListView(
                      children: widget.order.myOrders
                          .map((pr) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(pr.title,
                                      style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold)),
                                  Text('${pr.quantity}x    \$${pr.price}',
                                      style: const TextStyle(
                                          fontSize: 18, color: Colors.grey)),
                                ],
                              ))
                          .toList()))
              : Container()
        ]));
  }
}
