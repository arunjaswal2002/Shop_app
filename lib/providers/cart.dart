import 'package:flutter/material.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem(
      {required this.id, // this id is different from the product item id
      required this.title,
      required this.price,
      required this.quantity});
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get cartItems {
    return _items == null ? 0 : _items.length;
  }

  void addCartItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      //increment thr quantity
      _items.update(
          productId,
          (existingCartItem) => CartItem(
              id: productId,
              title: title,
              quantity: existingCartItem.quantity + 1,
              price: price));
    } else {
      _items.putIfAbsent(
          productId,
          () => CartItem(
              id: DateTime.now().toString(),
              title: title,
              price: price,
              quantity: 1));
    }
  }
}
