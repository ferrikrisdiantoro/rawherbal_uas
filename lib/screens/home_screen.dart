// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawherbal_uas/models/userbalance_model.dart';
import 'package:rawherbal_uas/main.dart';
import 'package:rawherbal_uas/models/product_model.dart';
import 'package:rawherbal_uas/screens/category_screen.dart';
import 'package:rawherbal_uas/screens/cart_screen.dart';
import 'package:rawherbal_uas/screens/profile_screen.dart';
import 'package:rawherbal_uas/screens/transaction_history_screen.dart';
import 'package:rawherbal_uas/screens/category_products_screen.dart';
import 'package:rawherbal_uas/widgets/category_item.dart';
import 'package:rawherbal_uas/data/product_data.dart'; // Mengimpor data produk
import 'package:rawherbal_uas/screens/product_detail_screen.dart'
    as product_screen;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _searchQuery = '';

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget bodyContent;

    switch (_selectedIndex) {
      case 1:
        bodyContent = CategoryScreen();
        break;
      case 2:
        bodyContent = CartScreen();
        break;
      case 3:
        bodyContent = TransactionHistoryScreen();
        break;
      case 4:
        bodyContent = ProfileScreen();
        break;
      default:
        bodyContent = HomeContent(searchQuery: _searchQuery);
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: _selectedIndex == 0
            ? Container(
                height: 40,
                child: TextField(
                  onChanged: _onSearchChanged, // Menambahkan callback
                  decoration: InputDecoration(
                    hintText: 'Search',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              )
            : Text(_getAppBarTitle()),
      ),
      body: bodyContent,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: 'History'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: HexColor.fromHex('67df70'),
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }

  String _getAppBarTitle() {
    switch (_selectedIndex) {
      case 1:
        return 'Categories';
      case 2:
        return 'Cart';
      case 3:
        return 'History';
      case 4:
        return 'Profile';
      default:
        return 'Home';
    }
  }
}

class HomeContent extends StatelessWidget {
  final String searchQuery; // Menerima parameter searchQuery

  HomeContent({required this.searchQuery}); // Menambahkan constructor

  final List<Map<String, String>> categories = [
    {'name': 'All', 'tag': 'all', 'image': 'assets/images/c0.png'},
    {'name': 'Leaf', 'tag': 'leaf', 'image': 'assets/images/c1.png'},
    {'name': 'Flower', 'tag': 'flower', 'image': 'assets/images/c3.png'},
    {'name': 'Root', 'tag': 'root', 'image': 'assets/images/c2.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<UserBalanceModel>(
      builder: (context, userBalanceModel, child) {
        return ListView(
          children: [
            _buildSaldoCard(userBalanceModel.balance),
            _buildPromotionalBanner(),
            _buildCategorySection(context),
            _buildProductSection(context), // Panggil dengan searchQuery
          ],
        );
      },
    );
  }

  Widget _buildSaldoCard(double saldo) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: HexColor.fromHex('67df70'), // Warna hijau muda
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: HexColor.fromHex('6c7a52'), // Warna hijau tua
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    child: Text(
                      'Total Balance',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontFamily: 'Poppins', // Font yang saya rekomendasikan
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Rp ${saldo.toStringAsFixed(0)}',
                    style: TextStyle(
                      color: HexColor.fromHex('6c7a52'),
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Poppins', // Font yang saya rekomendasikan
                    ),
                  ),
                ],
              ),
              IconButton(
                icon: Icon(Icons.add_circle,
                    color: HexColor.fromHex('6c7a52'), size: 40),
                onPressed: () {
                  // Aksi untuk menambahkan saldo
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromotionalBanner() {
    final List<String> images = [
      'assets/images/redgingertea.jpeg',
      'assets/images/butterflypeatea.jpeg',
      'assets/images/sennaleaftea.jpeg',
    ];

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        child: PageView.builder(
          itemCount: images.length,
          itemBuilder: (context, index) {
            return _buildBannerCard(images[index]);
          },
        ),
      ),
    );
  }

  Widget _buildBannerCard(String imagePath) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(imagePath, fit: BoxFit.cover),
      ),
    );
  }

  Widget _buildCategorySection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Categories',
              style: TextStyle(
                color: HexColor.fromHex('5c462e'),
                fontSize: 18,
                fontFamily: 'Poppins',
              )),
          SizedBox(height: 10),
          Container(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: categories.map((category) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CategoryProductsScreen(
                          category: category['name']!,
                          products: products
                              .where((product) =>
                                  category['tag'] ==
                                      'all' || // Jika tag adalah 'all', tampilkan semua produk
                                  product.category ==
                                      category[
                                          'tag']) // Filter produk berdasarkan tag kategori
                              .toList(),
                        ),
                      ),
                    );
                  },
                  child: CategoryItem(
                      category: category['name']!,
                      backgroundImage: category['image']!),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection(BuildContext context) {
    // Filter produk berdasarkan query pencarian
    final filteredProducts = products
        .where((product) =>
            product.name.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Featured Products',
              style: TextStyle(
                color: HexColor.fromHex('5c462e'),
                fontSize: 18,
                fontFamily: 'Poppins',
              )),
          SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            childAspectRatio: 0.7,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            children: filteredProducts.map((product) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => product_screen.ProductDetailScreen(
                          productName: product.name,
                          productImage: product.image,
                          productPrice: product.price,
                          productTag: product.category,
                          productDescription: product.description),
                    ),
                  );
                },
                child: Product(
                  name: product.name,
                  image: product.image,
                  price: product.price,
                  category: product.category,
                  description: product.description,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
