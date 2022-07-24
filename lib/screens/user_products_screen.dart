import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';
import '../widgets/user_product_item.dart';
import '../widgets/app_drawer.dart';
import '../screens/edit_addScreen.dart';

class UserProductsScreen extends StatelessWidget {
  // const UserProductsScreen({Key? key}) : super(key: key);

  static const routename = '/userProductScreen';
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(context);
    return Scaffold(
        appBar: AppBar(title: const Text('Your Products'), 
        actions: <Widget>[  
          IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(EditAddProductScreen.routeName);
              })
        ]),
        drawer: AppDrawer(),
        body: Padding(
            padding: const EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: (ctx, i) => Column(
                children: [
                  UserProductItem(productData.items[i].id,productData.items[i].title,
                      productData.items[i].imageUrl),
                  const Divider(),
                ],
              ),
            )));
  }
}
