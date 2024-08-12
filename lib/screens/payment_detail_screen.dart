import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawherbal_uas/models/address_model.dart';
import 'package:rawherbal_uas/models/userbalance_model.dart';
import 'package:rawherbal_uas/models/transaction_model.dart';
import '../main.dart';
import 'package:rawherbal_uas/screens/transaction_success_screen.dart';

class PaymentDetailScreen extends StatefulWidget {
  final List<Map<String, dynamic>> selectedProducts;
  final String productName;
  final double totalPrice;
  final String productImage;
  final double productPrice;
  final double userBalance;
  final Address alamat;

  PaymentDetailScreen({
    required this.selectedProducts,
    required this.totalPrice,
    required this.productName,
    required this.productImage,
    required this.productPrice,
    required this.userBalance,
    required this.alamat,
  });

  @override
  _PaymentDetailScreenState createState() => _PaymentDetailScreenState();
}

class _PaymentDetailScreenState extends State<PaymentDetailScreen> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    double totalHarga = widget.productPrice * _quantity;
    double sisaSaldo = widget.userBalance - totalHarga;

    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Details',
            style: TextStyle(
                color: HexColor.fromHex('5c462e'),
                fontSize: 18,
                fontFamily: 'Poppins')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Alamat
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 0.0),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Address:',
                        style: TextStyle(
                            color: HexColor.fromHex('5c462e'),
                            fontSize: 18,
                            fontFamily: 'Poppins'),
                      ),
                      SizedBox(height: 10),
                      Text(
                        widget.alamat.toString(),
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 20),

            // Card Produk
            ...widget.selectedProducts.map((product) {
              return Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        product['image'],
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name'],
                              style: TextStyle(
                                  color: HexColor.fromHex('5c462e'),
                                  fontSize: 18,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Price: ${product['price']}',
                              style: TextStyle(
                                  color: HexColor.fromHex('5c462e'),
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Poppins'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Quantity: ${product['quantity']}',
                              style: TextStyle(
                                  color: HexColor.fromHex('5c462e'),
                                  fontSize: 16,
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
            SizedBox(height: 20),

            // Card Total Harga
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total payment:',
                      style: TextStyle(
                          color: HexColor.fromHex('5c462e'),
                          fontSize: 18,
                          fontFamily: 'Poppins'),
                    ),
                    Text(
                      'Rp ${totalHarga.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: HexColor.fromHex('5c462e'),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Card Sisa Saldo
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Remaining Balance:',
                      style: TextStyle(
                          color: HexColor.fromHex('5c462e'),
                          fontSize: 18,
                          fontFamily: 'Poppins'),
                    ),
                    Text(
                      'Rp ${sisaSaldo.toStringAsFixed(0)}',
                      style: TextStyle(
                          color: HexColor.fromHex('5c462e'),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: sisaSaldo >= 0
              ? () {
                  // Reduce balance and navigate to payment success screen
                  Provider.of<UserBalanceModel>(context, listen: false)
                      .updateBalance(sisaSaldo);

                  Provider.of<TransactionModel>(context, listen: false)
                      .addTransaction(
                    widget.selectedProducts, // Menambahkan semua produk
                    widget.totalPrice,
                    DateTime.now(),
                  );

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TransactionSuccessScreen(),
                    ),
                  );
                }
              : null,
          child: Text('Pay Now',
              style: TextStyle(
                  color: HexColor.fromHex('5c462e'),
                  fontSize: 18,
                  fontFamily: 'Poppins')),
        ),
      ),
    );
  }
}
