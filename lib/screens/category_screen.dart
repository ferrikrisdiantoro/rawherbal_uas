import 'package:flutter/material.dart';
import 'package:rawherbal_uas/screens/category_products_screen.dart';
import 'package:rawherbal_uas/data/product_data.dart';
import '../main.dart';
import 'package:rawherbal_uas/models/product_model.dart';

class CategoryScreen extends StatelessWidget {
  final List<Map<String, String>> categories = [
    {'name': 'All', 'tag': 'all', 'image': 'assets/images/c0.png'},
    {'name': 'Leaf', 'tag': 'leaf', 'image': 'assets/images/c1.png'},
    {'name': 'Root', 'tag': 'root', 'image': 'assets/images/c2.png'},
    {'name': 'Flower', 'tag': 'flower', 'image': 'assets/images/c3.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: categories.map((category) {
            return Expanded(
              child: InkWell(
                onTap: () {
                  List<Product> filteredProducts;

                  if (category['tag'] == 'all') {
                    filteredProducts = products;
                  } else {
                    filteredProducts = products
                        .where((product) => product.category == category['tag'])
                        .toList();
                  }

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CategoryProductsScreen(
                        category: category['name']!,
                        products: filteredProducts,
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Stack(
                    children: [
                      // Background image with transparency
                      Opacity(
                        opacity: 0.5, // Control the transparency level
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.asset(
                            category['image']!,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                      ),
                      Center(
                        child: Transform.rotate(
                          angle: -0.1, // Adjust this value for the desired tilt
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              category['name']!,
                              style: TextStyle(
                                fontSize: 24,
                                color: HexColor.fromHex('5c462e'),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
