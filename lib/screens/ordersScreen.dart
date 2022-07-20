import 'package:flutter/material.dart';
import '../providers/orders.dart';
import 'package:provider/provider.dart';
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersScreen extends StatelessWidget {
  // const OrdersScreen({Key? key}) : super(key: key);
  static const routeName = '/orders_screen';

  @override
  Widget build(BuildContext context) {
    final orderedData = Provider.of<Orders>(context);
    return Scaffold(
        appBar: AppBar(title: Text('Your Orders')),
        drawer: AppDrawer(),
        body: ListView.builder(
            itemCount: orderedData.orders.length,
            itemBuilder: (_, i) => OrderedItem(orderedData.orders[i])));
  }
}
