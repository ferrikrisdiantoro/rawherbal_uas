import 'package:flutter/material.dart';

class CategoryItem extends StatelessWidget {
  final String category;
  final String backgroundImage;

  CategoryItem({required this.category, required this.backgroundImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: AssetImage(
              backgroundImage), // Gambar transparan untuk setiap kategori
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Text(
          category,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'Poppins',
          ),
        ),
      ),
    );
  }
}
