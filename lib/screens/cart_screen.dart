import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart.dart' show Cart;
import '../widgets/cart_item.dart';
import '../providers/orders.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  static const routeName = '/cart-Screen';

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('My Cart')),
        body: Column(children: <Widget>[
          Card(
              margin: EdgeInsets.all(10),
              child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const Text('Total :',
                          style: TextStyle(
                            fontSize: 20,
                          )),
                      const Spacer(),
                      Chip(
                          label: Text('\$${cart.totalAmount}',
                              style: const TextStyle(color: Colors.white)),
                          backgroundColor: Theme.of(context).accentColor),
                      FlatButton(
                        child: const Text('Place Order'),
                        onPressed: () {
                          Provider.of<Orders>(context,listen: false).addOrder(
                              cart.items.values.toList(), cart.totalAmount);

                            cart.clear();
                        },
                        textColor: Theme.of(context).accentColor,
                      )
                    ],
                  ))),
          Expanded(
              child: ListView.builder(
            itemBuilder: (ctx, i) => CartItem(
                cart.items.values.toList()[i].id,
                cart.items.keys.toList()[i],
                cart.items.values.toList()[i].title,
                cart.items.values.toList()[i].price,
                cart.items.values.toList()[i].quantity),
            itemCount: cart.cartItems,
          ))
        ]));
  }
}
