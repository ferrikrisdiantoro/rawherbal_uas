import 'package:flutter/material.dart';

class TransactionModel extends ChangeNotifier {
  final List<Map<String, dynamic>> _transactions = [];

  List<Map<String, dynamic>> get transactions => _transactions;

  void addTransaction(
      List<Map<String, dynamic>> products, double totalPrice, DateTime date) {
    _transactions.add({
      'products': products,
      'totalPrice': totalPrice,
      'date': date,
    });
    notifyListeners();
  }

  void removeTransaction(int index) {
    if (index >= 0 && index < _transactions.length) {
      _transactions.removeAt(index);
      notifyListeners();
    }
  }
}
