import 'package:flutter/material.dart';
import 'home_screen.dart';
import '../main.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  void initState() {
    super.initState();
    print("LoginScreen initState");
  }

  @override
  Widget build(BuildContext context) {
    print("Building LoginScreen");
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/logo.png',
          height: 80,
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegisterScreen()),
                  );
                },
                child: Text(
                  "Don't have a Raw Tisane Herbal account yet? Register Now!",
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 16,
                      fontFamily: 'Poppins'),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                  suffixIcon: Icon(Icons.visibility_off),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Checkbox(
                        value: _rememberMe,
                        onChanged: (bool? newValue) {
                          setState(() {
                            _rememberMe = newValue ?? false;
                          });
                        },
                      ),
                      Text('Remember me',
                          style: TextStyle(
                              color: HexColor.fromHex('5c462e'),
                              fontSize: 16,
                              fontFamily: 'Poppins')),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ForgotPasswordScreen()),
                      );
                    },
                    child: Text('Forgot Password?',
                        style: TextStyle(
                            color: HexColor.fromHex('5c462e'),
                            fontSize: 16,
                            fontFamily: 'Poppins')),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => HomeScreen(),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50), // full width
                  backgroundColor: HexColor.fromHex('67df70'),
                ),
                child: Text('Login',
                    style: TextStyle(
                        color: HexColor.fromHex('5c462e'),
                        fontSize: 16,
                        fontFamily: 'Poppins')),
              ),
              const SizedBox(height: 20),
              Text('or sign in with',
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 16,
                      fontFamily: 'Poppins')),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildSocialLoginButton('Nomor Ponsel', Icons.phone),
                  _buildSocialLoginButton('Facebook', Icons.facebook),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  _buildSocialLoginButton('Google', Icons.email),
                  _buildSocialLoginButton('Twitter', Icons.alternate_email),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLoginButton(String text, IconData icon) {
    return ElevatedButton.icon(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(),
          ),
        );
      },
      icon: Icon(icon),
      label: Text(text),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(140, 50), // size of the button
        backgroundColor: Colors.grey[200], // button color
        foregroundColor: Colors.black, // text color
      ),
    );
  }
}
