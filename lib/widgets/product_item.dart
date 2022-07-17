import 'package:flutter/material.dart';
import 'package:shop_app/screens/product_detail_screen.dart';

class ProductItem extends StatelessWidget {
  // const ProductItem({Key? key}) : super(key: key);

  final String id;
  final String title;
  final String imageUrl;
  ProductItem(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
          child: GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .pushNamed(ProductDetailScreen.routeName, arguments: id);
              },
              child:  Image.network(imageUrl, fit: BoxFit.cover)),
          footer: GridTileBar(
            leading: IconButton(
              icon: const Icon(Icons.favorite),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
            backgroundColor: Colors.black87,
            title: Text(title,
                textAlign: TextAlign.center, style: const TextStyle(fontSize: 7)),
            trailing: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {},
              color: Theme.of(context).accentColor,
            ),
          )),
    );
  }
}
