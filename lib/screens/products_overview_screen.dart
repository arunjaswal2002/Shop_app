import 'package:flutter/material.dart';
import 'package:shop_app/screens/cart_screen.dart';

import '../widgets/products_grid.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/badge.dart';
import '../providers/cart.dart';
import '../widgets/app_drawer.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var flag = true;
  var showLoadingSpinner = false;

  @override
  void didChangeDependencies() { // Both init state and didChangeDependencies are called before the build and if we want to use context outside our build method then we use didChangeDependencies.
  //Did changedependencies are called after the state loads its dependencies.
  //But initState is called before the state call its dependencies.
    // TODO: implement didChangeDependencies
    if (flag) {
      setState(() {
        showLoadingSpinner = true;
      });
      Provider.of<Products>(context).fetchAndSetProduct().then((_) {
        setState(() {
          showLoadingSpinner = false;
        });
      });
      flag = false;
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('MyShop'),
       actions: <Widget>[
        PopupMenuButton(
            onSelected: (FilterOptions selectedvalue) {
              setState(() {
                if (selectedvalue == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
            itemBuilder: (_) => [
                  const PopupMenuItem(
                      // ignore: sort_child_properties_last
                      child: Text('Only Favorites'),
                      value: FilterOptions.favorites),
                  const PopupMenuItem(
                      // ignore: sort_child_properties_last
                      child: Text('Show All'),
                      value: FilterOptions.all),
                ],
            child: const Icon(Icons.more_vert)),
        Consumer<Cart>(
          builder: (_, cart, ch) => Badge(
            child: ch as Widget, //this thing will not change
            value: cart.cartItems.toString(),
          ),
          child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              }),
        ),
      ]),
      drawer: AppDrawer(),
      body: showLoadingSpinner
          ? const Center(child: CircularProgressIndicator())
          : ProductsGrid(_showOnlyFavorites),
    );
  }
}
