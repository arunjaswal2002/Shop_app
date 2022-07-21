import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/screens/cart_screen.dart';
import '/screens/user_products_screen.dart';

import './screens/products_overview_screen.dart';
import './screens/product_detail_screen.dart';
import './providers/products.dart';
import 'providers/cart.dart';
import 'providers/orders.dart';
import './screens/ordersScreen.dart';
import '/screens/edit_addScreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Products()),
        ChangeNotifierProvider(create: (_) => Cart()),
        ChangeNotifierProvider(create: (_) => Orders()),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'MyShop',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.deepOrange,
            fontFamily: 'Lato',
          ),
          // home: ProductsOverviewScreen(),
          routes: {
            '/': (_) => ProductsOverviewScreen(),
            ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
            CartScreen.routeName: (ctx) => CartScreen(),
            OrdersScreen.routeName: (ctx) => OrdersScreen(),
            UserProductsScreen.routename: (ctx) => UserProductsScreen(),
            EditAddProductScreen.routeName: (ctx) => EditAddProductScreen(),
          }),
    );
  }
}
