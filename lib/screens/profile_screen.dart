import 'package:flutter/material.dart';
import 'package:rawherbal_uas/screens/address_screen.dart';
import 'data_lengkap_screen.dart';
import 'login_screen.dart';
import '../main.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Profil
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage(
                  'assets/images/profile_icon.png'), // Sesuaikan path gambar profil
            ),
            SizedBox(height: 16),

            // Nama Lengkap
            Text(
              'Kelompok Raw Herbal Tisane',
              style: TextStyle(
                  color: HexColor.fromHex('5c462e'),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Poppins'),
            ),
            SizedBox(height: 32),

            // Kolom Data Lengkap
            ListTile(
              leading: Icon(Icons.info),
              title: Text('My Data',
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 18,
                      fontFamily: 'Poppins')),
              subtitle: Text('Your personal information is here.',
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 18,
                      fontFamily: 'Poppins')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DataLengkapScreen()),
                );
              },
            ),
            Divider(),

            // Kolom Alamat
            ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Address',
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 18,
                      fontFamily: 'Poppins')),
              subtitle: Text('Your Full Address here.',
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 18,
                      fontFamily: 'Poppins')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddressScreen()),
                );
              },
            ),
            Divider(),

            // Tombol Logout
            Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: HexColor.fromHex('67df70'),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(
                    color: Colors.white, fontSize: 18, fontFamily: 'Poppins'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
