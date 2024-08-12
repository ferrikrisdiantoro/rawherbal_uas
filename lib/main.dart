import 'package:flutter/material.dart';
import 'package:rawherbal_uas/screens/login_screen.dart';
import 'package:rawherbal_uas/screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'package:rawherbal_uas/models/cart_model.dart';
import 'package:rawherbal_uas/models/address_model.dart';
import 'package:rawherbal_uas/models/transaction_model.dart';
import 'package:rawherbal_uas/models/userbalance_model.dart';
import 'package:rawherbal_uas/screens/transaction_success_screen.dart';

extension HexColor on Color {
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('FF');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        ChangeNotifierProvider(create: (context) => AddressModel()),
        ChangeNotifierProvider(create: (_) => UserBalanceModel()),
        ChangeNotifierProvider(create: (_) => TransactionModel()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("Building MyApp");
    return MaterialApp(
      title: 'Raw Tisane Herbal',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(), // Halaman awal
        '/home': (context) => HomeScreen(), // Rute untuk HomeScreen
        '/transaction-success': (context) =>
            TransactionSuccessScreen(), // Rute untuk TransactionSuccessScreen
        // Daftarkan rute lain di sini jika ada
      },
    );
  }
}
