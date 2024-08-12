import 'package:flutter/material.dart';

class Address {
  final String name;
  final String street;
  final String village;
  final String district;
  final String regency;
  final String province;
  final String postalCode;

  Address({
    required this.name,
    required this.street,
    required this.village,
    required this.district,
    required this.regency,
    required this.province,
    required this.postalCode,
  });

  @override
  String toString() {
    return '$name\n$street, $village, $district\n$regency, $province\n$postalCode';
  }
}

class AddressModel extends ChangeNotifier {
  List<Address> _addresses = [];
  Address? _selectedAddress;

  List<Address> get addresses => _addresses;
  Address? get selectedAddress => _selectedAddress;

  void addAddress(Address address) {
    _addresses.add(address);
    notifyListeners();
  }

  void editAddress(int index, Address newAddress) {
    if (index >= 0 && index < _addresses.length) {
      _addresses[index] = newAddress;
      notifyListeners();
    }
  }

  void removeAddress(int index) {
    if (index >= 0 && index < _addresses.length) {
      _addresses.removeAt(index);
      notifyListeners();
    }
  }

  void selectAddress(Address address) {
    _selectedAddress = address;
    notifyListeners();
    print(
        'Selected Address in Model: $_selectedAddress'); // Debugging statement
  }
}
