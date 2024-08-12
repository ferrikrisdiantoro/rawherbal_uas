import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../main.dart';

class ForgotPasswordScreen extends StatefulWidget {
  @override
  _ForgotPasswordScreenState createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _reenterPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password',
            style: TextStyle(
                color: HexColor.fromHex('5c462e'),
                fontSize: 18,
                fontFamily: 'Poppins')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Enter Email',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _verificationCodeController,
                decoration: InputDecoration(
                  labelText: 'Verification Code',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: _newPasswordController,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20),
              TextField(
                controller: _reenterPasswordController,
                decoration: InputDecoration(
                  labelText: 'Re-enter New Password',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              SizedBox(height: 40),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Logika untuk verifikasi dan update password

                    // Setelah berhasil, pindah ke halaman HomeScreen
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    backgroundColor: HexColor.fromHex('67df70'),
                  ),
                  child: Text('Save',
                      style: TextStyle(
                          color: HexColor.fromHex('5c462e'),
                          fontSize: 18,
                          fontFamily: 'Poppins')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
