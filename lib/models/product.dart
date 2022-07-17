class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool
      isfavorite; //Not final because after creating a product we can change this

  Product(
      {required this.id,
      required this.title,
      required this.description,
      required this.price,
      required this.imageUrl,
      this.isfavorite = false});
}
