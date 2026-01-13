import 'package:flutter/material.dart';

class MenuItem {
  final String nama;
  final int harga;
  final String imagePath;

  const MenuItem({
    required this.nama,
    required this.harga,
    required this.imagePath,
  });
}

class CartProvider extends ChangeNotifier {
  final Map<MenuItem, int> _items = {};

  int quantity(MenuItem item) => _items[item] ?? 0;

  int get totalItem =>
      _items.values.fold(0, (sum, qty) => sum + qty);

  void add(MenuItem item) {
    _items[item] = (_items[item] ?? 0) + 1;
    notifyListeners();
  }

  void remove(MenuItem item) {
    if (!_items.containsKey(item)) return;

    if (_items[item]! > 1) {
      _items[item] = _items[item]! - 1;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }
}
