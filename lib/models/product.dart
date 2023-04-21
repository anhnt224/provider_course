import 'package:uuid/uuid.dart';

class Product {
  final String id;
  final String name;
  final double price;
  bool isFavorite = false;

  Product({
    required this.name,
    required this.price,
  }) : id = const Uuid().v4();
}
