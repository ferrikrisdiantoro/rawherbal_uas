import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawherbal_uas/main.dart';
import 'package:rawherbal_uas/models/cart_model.dart';
import 'package:rawherbal_uas/models/address_model.dart';
import 'package:rawherbal_uas/models/product_model.dart';
import 'package:rawherbal_uas/models/userbalance_model.dart';
import 'package:rawherbal_uas/screens/payment_detail_screen.dart';
import 'package:rawherbal_uas/screens/product_detail_screen.dart';

class CategoryProductsScreen extends StatelessWidget {
  final String category;
  final List<Product> products;

  CategoryProductsScreen({required this.category, required this.products});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final userBalance = Provider.of<UserBalanceModel>(context).balance;

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        childAspectRatio: 0.7,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        padding: const EdgeInsets.all(8),
        children: products.map((product) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(
                    productName: product.name,
                    productImage: product.image,
                    productPrice: product.price,
                    productTag: product.category,
                    productDescription: product.description,
                  ),
                ),
              );
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(10),
                      ),
                      child: Image.asset(
                        product.image,
                        fit: BoxFit.cover,
                        width: double.infinity,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          product.name,
                          style: TextStyle(
                              color: HexColor.fromHex('5c462e'),
                              fontSize: 18,
                              fontFamily: 'Poppins'),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 5),
                        Text(
                          product.price,
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
                                  cart.addItem({
                                    'name': product.name,
                                    'image': product.image,
                                    'price': product.price,
                                    'category': product.category,
                                    'quantity': 1,
                                  });
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
                                onPressed: () async {
                                  final selectedAddress =
                                      await showDialog<Address>(
                                    context: context,
                                    builder: (context) =>
                                        AddressSelectionDialog(),
                                  );

                                  if (selectedAddress != null) {
                                    final selectedProduct = {
                                      'name': product.name,
                                      'image': product.image,
                                      'price': product.price,
                                      'category': product.category,
                                      'quantity': 1,
                                    };

                                    String cleanPrice = product.price
                                        .replaceAll(RegExp(r'[^0-9]'), '');
                                    double parsedPrice =
                                        double.tryParse(cleanPrice) ?? 0;

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            PaymentDetailScreen(
                                          alamat: selectedAddress,
                                          selectedProducts: [selectedProduct],
                                          productName: product.name,
                                          productImage: product.image,
                                          productPrice: parsedPrice,
                                          totalPrice: parsedPrice,
                                          userBalance: userBalance,
                                        ),
                                      ),
                                    );
                                  } else {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Please select an address',
                                          style: TextStyle(
                                              color: HexColor.fromHex('5c462e'),
                                              fontSize: 16,
                                              fontFamily: 'Poppins')),
                                    ));
                                  }
                                },
                                child: Text('Buy Now',
                                    style: TextStyle(
                                        color: HexColor.fromHex('5c462e'),
                                        fontSize: 9,
                                        fontFamily: 'Poppins')),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class AddressSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addressModel = Provider.of<AddressModel>(context);
    final addresses = addressModel.addresses;

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
                        Navigator.of(context).pop(address);
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
  }
}
