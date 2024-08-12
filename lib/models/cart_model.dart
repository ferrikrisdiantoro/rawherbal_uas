import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _items = [];

  List<Map<String, dynamic>> get items => _items;

  void addItem(Map<String, dynamic> product) {
    // Mencari item berdasarkan nama
    int index = _items.indexWhere((item) => item['name'] == product['name']);

    if (index != -1) {
      // Jika item sudah ada, tambahkan quantity-nya
      _items[index]['quantity']++;
    } else {
      // Jika item belum ada, tambahkan ke dalam cart
      _items.add({...product, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeItem(String name) {
    _items.removeWhere((item) => item['name'] == name);
    notifyListeners();
  }

  void increaseQuantity(String name) {
    final item = _items.firstWhere((item) => item['name'] == name);
    item['quantity']++;
    notifyListeners();
  }

  void decreaseQuantity(String name) {
    final item = _items.firstWhere((item) => item['name'] == name);
    if (item['quantity'] > 1) {
      item['quantity']--;
    } else {
      _items.remove(item);
    }
    notifyListeners();
  }
}
