import 'package:flutter/foundation.dart';

class UserBalanceModel extends ChangeNotifier {
  double _balance = 150000.0;

  double get balance => _balance;

  void updateBalance(double newBalance) {
    _balance = newBalance;
    notifyListeners();
  }
}
