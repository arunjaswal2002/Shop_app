import 'package:flutter/material.dart';
import '../providers/cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> myOrders;
  final DateTime dateOfOrder;

  OrderItem(
      {required this.id,
      required this.amount,
      required this.dateOfOrder,
      required this.myOrders});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  

  void addOrder(List<CartItem> cartProducts, double total) {
    _orders.insert(
        0,
        OrderItem(
            id: DateTime.now().toString(),
            amount: total,
            dateOfOrder: DateTime.now(),
            myOrders: cartProducts));


            notifyListeners();
  }
}
