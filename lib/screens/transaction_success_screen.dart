import 'package:flutter/material.dart';
import '../main.dart';

class TransactionSuccessScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment Information',
            style: TextStyle(
                color: HexColor.fromHex('5c462e'),
                fontSize: 18,
                fontFamily: 'Poppins')),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 100, color: Colors.green),
              SizedBox(height: 20),
              Text(
                'Payment Successful!',
                style: TextStyle(
                    color: HexColor.fromHex('5c462e'),
                    fontSize: 18,
                    fontFamily: 'Poppins'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Kembali ke halaman HomeScreen
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/home', // Halaman tujuan HomeScreen
                    (route) => false, // Hapus semua route sebelumnya
                  );
                },
                child: Text('Return to Home',
                    style: TextStyle(
                        color: HexColor.fromHex('5c462e'),
                        fontSize: 18,
                        fontFamily: 'Poppins')),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
