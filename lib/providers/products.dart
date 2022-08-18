import 'package:flutter/material.dart';
import 'dart:convert';
import 'product.dart';
import 'package:http/http.dart' as http;

class Products with ChangeNotifier {
  // ignore: prefer_final_fields
  List<Product> _items = [
    // Product(
    //   id: 'p1',
    //   title: 'Red Shirt',
    //   description: 'A red shirt - it is pretty red!',
    //   price: 29.99,
    //   imageUrl:
    //       'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    // ),
    // Product(
    //   id: 'p2',
    //   title: 'Trousers',
    //   description: 'A nice pair of trousers.',
    //   price: 59.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    // ),
    // Product(
    //   id: 'p3',
    //   title: 'Yellow Scarf',
    //   description: 'Warm and cozy - exactly what you need for the winter.',
    //   price: 19.99,
    //   imageUrl:
    //       'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    // ),
    // Product(
    //   id: 'p4',
    //   title: 'A Pan',
    //   description: 'Prepare any meal you want.',
    //   price: 49.99,
    //   imageUrl:
    //       'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    // ),
  ];

  // var showFavoritesOnly = false;

  List<Product> get items {
    // if (showFavoritesOnly) {
    //   return _items.where((item) => item.isFavorite).toList();
    // }
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((prod) => prod.id == id);
  }

  // void showFavorites() {
  //   showFavoritesOnly = true;
  //   notifyListeners();
  // }
  //  void showAll() {
  //   showFavoritesOnly = false;
  //   notifyListeners();
  // }
  List<Product> get showFavoritesOnly {
    return _items.where((prod) => prod.isFavorite).toList();
  }

  Future<void> fetchAndSetProduct() async {
    final url = Uri.parse(
        'https://myshopproject-65c79-default-rtdb.firebaseio.com/products.json');
    try {
      final response = await http.get(url);
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      final List<Product> tempStoring = [];
      extractedData.forEach((prodId, prodData) {
        tempStoring.add(Product(
            id: prodId,
            title: prodData['title'],
            description: prodData['description'],
            price: prodData['price'],
            isFavorite: prodData['isFavorite'],
            imageUrl: prodData['imageUrl']));
      });

      _items = tempStoring;
      notifyListeners();
    } catch (error) {
      throw error;
    }
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.parse(
        'https://myshopproject-65c79-default-rtdb.firebaseio.com/products.json');
    try {
      final postResponse = await http.post(
          url, //await just put the after code in a then block and wait for the current function to complete.
          body: json.encode({
            'title': product.title,
            'price': product.price,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'isFavorite': product.isFavorite
          }));

      //it will execute after the post request comes back
      final _pr = Product(
          id: json.decode(postResponse.body)['name'],
          price: product.price,
          description: product.description,
          title: product.title,
          imageUrl: product.imageUrl);

      _items.add(_pr);
      notifyListeners();
    } catch (error) {
      throw error;
    }
    // print(error);
    // // return Future.error(error);
    // throw error;
    //this will generate a new error and forward it to the editAddProfuctSCREEN

    // _items.add(value);
  }

  void editProduct(String id, Product newProduct) {
    final productIndex = _items.indexWhere((item) => item.id == id);
    if (productIndex < 0) {
      return;
    }
    _items[productIndex] = newProduct;
    notifyListeners();
  }

  void deleteProduct(String id) {
    _items.removeWhere((element) => element.id == id);
    notifyListeners();
  }
}
