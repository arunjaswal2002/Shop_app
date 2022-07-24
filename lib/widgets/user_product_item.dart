import 'package:flutter/material.dart';
import '../screens/edit_addScreen.dart';
import 'package:provider/provider.dart';
import '../providers/products.dart';

class UserProductItem extends StatelessWidget {
  // const USerProductItem({Key? key}) : super(key: key);
  final String id, title, imageUrl;
  UserProductItem(this.id, this.title, this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: CircleAvatar(backgroundImage: NetworkImage(imageUrl)),
        title: Text(title),
        trailing: Row(mainAxisSize: MainAxisSize.min, children: <Widget>[
          IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                Navigator.of(context)
                    .pushNamed(EditAddProductScreen.routeName, arguments: id);
              },
              color: Theme.of(context).primaryColor),
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                Provider.of<Products>(context, listen: false).deleteProduct(id);
              },
              color: Theme.of(context).errorColor),
        ]));
  }
}
