import 'package:flutter/cupertino.dart';

import '../models/product.dart';

class ProductProvider extends ChangeNotifier {
  final List<Product> _products = [];

  List<Product> get products => List.from(_products);

  void add(Product product) {
    print("ADD PRODUCT");
    _products.add(product);
    print(_products.toString());
    notifyListeners();
  }

  void reset() {
    _products.clear();
    notifyListeners();
  }

  void setFavorite(Product product) {
    final filteredProduct =
        _products.firstWhere((element) => element.id == product.id);
    filteredProduct.isFavorite = !filteredProduct.isFavorite;
    notifyListeners();
  }
}
