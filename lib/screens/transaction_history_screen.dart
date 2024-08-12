import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawherbal_uas/models/transaction_model.dart';
import '../main.dart';

class TransactionHistoryScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final transactionModel = Provider.of<TransactionModel>(context);

    return Scaffold(
      body: transactionModel.transactions.isEmpty
          ? Center(
              child: Text('No Transaction yet.',
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 18,
                      fontFamily: 'Poppins')))
          : ListView.builder(
              itemCount: transactionModel.transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactionModel.transactions[index];
                final List<Map<String, dynamic>> products =
                    transaction['products'] ?? [];

                return ExpansionTile(
                  title: Text('Transaction no.${index + 1}',
                      style: TextStyle(
                          color: HexColor.fromHex('5c462e'),
                          fontSize: 18,
                          fontFamily: 'Poppins')),
                  subtitle: Text(
                      'Total: Rp ${_formatPrice(transaction['totalPrice'])}',
                      style: TextStyle(
                          color: HexColor.fromHex('5c462e'),
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins')),
                  children: products.map((product) {
                    return ListTile(
                      leading: Image.asset(
                        product['image'] ?? 'assets/placeholder.png',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                      title: Text(product['name'] ?? 'No Name',
                          style: TextStyle(
                              color: HexColor.fromHex('5c462e'),
                              fontSize: 18,
                              fontFamily: 'Poppins')),
                      subtitle: Text(
                          'Quantity: ${product['quantity'] ?? 0}, Price: Rp ${_formatPrice(product['price'])}',
                          style: TextStyle(
                              color: HexColor.fromHex('5c462e'),
                              fontSize: 18,
                              fontFamily: 'Poppins')),
                    );
                  }).toList(),
                );
              },
            ),
    );
  }

  String _formatPrice(dynamic price) {
    if (price == null) return '0';
    try {
      // Remove 'Rp' and thousand separators ('.')
      String priceString = price.toString().replaceAll(RegExp(r'[^0-9]'), '');
      double priceValue = double.parse(priceString);
      return priceValue.toStringAsFixed(0);
    } catch (e) {
      print('Error formatting price: $e');
      return '0';
    }
  }
}
