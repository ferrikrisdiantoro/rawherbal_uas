import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawherbal_uas/models/cart_model.dart';
import 'package:rawherbal_uas/main.dart';
import 'package:rawherbal_uas/models/address_model.dart';
import 'package:rawherbal_uas/models/userbalance_model.dart';
import 'package:rawherbal_uas/screens/payment_detail_screen.dart';

class Product extends StatelessWidget {
  final String name;
  final String image;
  final String price;
  final String category;
  final String description;

  Product({
    required this.name,
    required this.image,
    required this.price,
    required this.category,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Expanded(
            child: Image.asset(image, fit: BoxFit.cover),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  name,
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 18,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 5),
                Text(
                  price,
                  style: TextStyle(
                      color: HexColor.fromHex('505330'),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins'),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          final product = {
                            'name': name,
                            'image': image,
                            'price': price,
                            'category': category,
                            'description': description,
                            'quantity': 1,
                          };
                          Provider.of<CartModel>(context, listen: false)
                              .addItem(product);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Added to cart')),
                          );
                        },
                        child: Text(
                          'Add to Cart',
                          style: TextStyle(
                              color: HexColor.fromHex('5c462e'),
                              fontSize: 9,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                    SizedBox(width: 5),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          _showAddressPicker(context, name, image, price);
                        },
                        child: Text(
                          'Buy Now',
                          style: TextStyle(
                              color: HexColor.fromHex('5c462e'),
                              fontSize: 9,
                              fontFamily: 'Poppins'),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showAddressPicker(BuildContext context, String productName,
      String productImage, String productPrice) {
    final addressModel = Provider.of<AddressModel>(context, listen: false);
    final addresses = addressModel.addresses;

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: HexColor.fromHex('5c462e'), // Warna ungu
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      'Select Address',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Poppins',
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: addresses.map((address) {
                        return ListTile(
                          title: Text(
                            address.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop();
                            _navigateToPaymentDetail(context, productName,
                                productImage, productPrice, address);
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _navigateToPaymentDetail(BuildContext context, String productName,
      String productImage, String productPrice, Address address) {
    String cleanPrice = productPrice.replaceAll(RegExp(r'[^0-9]'), '');
    double parsedPrice = double.parse(cleanPrice);

    final selectedProduct = {
      'name': productName,
      'image': productImage,
      'price': parsedPrice,
      'quantity': 1,
    };

    double userBalance =
        Provider.of<UserBalanceModel>(context, listen: false).balance;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentDetailScreen(
          alamat: address,
          selectedProducts: [selectedProduct],
          productName: productName,
          productImage: productImage,
          productPrice: parsedPrice,
          totalPrice: parsedPrice,
          userBalance: userBalance,
        ),
      ),
    );
  }
}
