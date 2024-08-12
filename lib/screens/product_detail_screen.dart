import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawherbal_uas/main.dart';
import 'package:rawherbal_uas/models/cart_model.dart';
import 'package:rawherbal_uas/models/userbalance_model.dart';
import 'package:rawherbal_uas/models/address_model.dart';
import 'package:rawherbal_uas/screens/payment_detail_screen.dart';

class ProductDetailScreen extends StatelessWidget {
  final String productName;
  final String productImage;
  final String productPrice;
  final String productTag;
  final String productDescription;

  ProductDetailScreen({
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.productTag,
    required this.productDescription,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productName),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    width: double.infinity,
                    child: Image.asset(
                      productImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                productName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Text(
                  '$productTag',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Text(
                productPrice,
                style: TextStyle(fontSize: 20, color: Colors.grey),
              ),
              SizedBox(height: 20),
              Text(
                'Description',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                productDescription,
                style: TextStyle(fontSize: 14),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        final product = {
                          'name': productName,
                          'image': productImage,
                          'price': productPrice,
                          'category': productTag,
                          'quantity': 1,
                        };
                        Provider.of<CartModel>(context, listen: false)
                            .addItem(product);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Added to cart')),
                        );
                      },
                      child: Text('Add to Cart'),
                    ),
                  ),
                  SizedBox(width: 5),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () async {
                        final addressModel =
                            Provider.of<AddressModel>(context, listen: false);
                        final selectedAddress = await showDialog<Address>(
                          context: context,
                          builder: (BuildContext context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Container(
                                padding: EdgeInsets.all(16.0),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      padding: EdgeInsets.all(16.0),
                                      decoration: BoxDecoration(
                                        color: HexColor.fromHex('5c462e'),
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
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SingleChildScrollView(
                                      child: Column(
                                        children: addressModel.addresses
                                            .map((address) {
                                          return ListTile(
                                            title: Text(address.toString()),
                                            onTap: () {
                                              Navigator.of(context)
                                                  .pop(address);
                                            },
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );

                        if (selectedAddress != null) {
                          String cleanPrice =
                              productPrice.replaceAll(RegExp(r'[^0-9]'), '');
                          double parsedPrice = double.parse(cleanPrice);

                          final selectedProduct = {
                            'name': productName,
                            'image': productImage,
                            'price': parsedPrice,
                            'quantity': 1,
                          };

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PaymentDetailScreen(
                                alamat: selectedAddress,
                                selectedProducts: [selectedProduct],
                                productName: productName,
                                productImage: productImage,
                                productPrice: parsedPrice,
                                totalPrice: parsedPrice,
                                userBalance: Provider.of<UserBalanceModel>(
                                        context,
                                        listen: false)
                                    .balance,
                              ),
                            ),
                          );
                        }
                      },
                      child: Text('Buy Now'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
