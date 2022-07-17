import 'package:flutter/material.dart';

class ProductDetailScreen extends StatelessWidget {
  // const ProductDetailScreen({Key? key}) : super(key: key);
  static const routeName = '/product_detail_screen';
  // final String id, title, imageUrl;
  // ProductDetailScreen(this.id, this.title, this.imageUrl);
  @override
  Widget build(BuildContext context) {
    final String productId =
        ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(title: Text(productId)),
      body: Center(child: Text('Details')),
    );
  }
}
