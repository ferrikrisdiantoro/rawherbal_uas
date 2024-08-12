import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:rawherbal_uas/models/cart_model.dart';
import 'package:rawherbal_uas/models/address_model.dart';
import 'package:rawherbal_uas/models/userbalance_model.dart';
import 'package:rawherbal_uas/screens/payment_detail_screen.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Menyimpan status checkbox untuk setiap item
  Map<String, bool> selectedItems = {};

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartModel>(context);
    final userBalance = Provider.of<UserBalanceModel>(context).balance;

    return Scaffold(
      body: cart.items.isEmpty
          ? Center(
              child: Text('Cart is empty',
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 18,
                      fontFamily: 'Poppins')))
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cart.items.length,
                    itemBuilder: (context, index) {
                      final item = cart.items[index];

                      // Pastikan setiap item memiliki status checkbox
                      if (!selectedItems.containsKey(item['name'])) {
                        selectedItems[item['name']!] = false;
                      }

                      final isSelected = selectedItems[item['name']] ?? false;
                      final image = item['image'] ?? '';
                      final name = item['name'] ?? 'Unnamed Product';
                      final price = item['price'] ?? 'Rp 0';
                      final quantity = item['quantity'] ?? 1;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          elevation: 4,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: image.isNotEmpty
                                    ? Image.asset(image)
                                    : null,
                                title: Text(name,
                                    style: TextStyle(
                                        color: HexColor.fromHex('5c462e'),
                                        fontSize: 16,
                                        fontFamily: 'Poppins')),
                                subtitle: Text(price,
                                    style: TextStyle(
                                        color: HexColor.fromHex('5c462e'),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Poppins')),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.remove),
                                          onPressed: () {
                                            cart.decreaseQuantity(item['name']);
                                          },
                                        ),
                                        Text(quantity.toString()),
                                        IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {
                                            cart.increaseQuantity(item['name']);
                                          },
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Checkbox(
                                          value: isSelected,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedItems[item['name']!] =
                                                  value!;
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            setState(() {
                                              selectedItems
                                                  .remove(item['name']!);
                                            });
                                            cart.removeItem(item['name']);
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      onPressed: () async {
                        final selectedProducts = cart.items
                            .where(
                                (item) => selectedItems[item['name']] == true)
                            .toList();
                        double totalPrice = selectedProducts.fold(
                          0.0,
                          (sum, item) {
                            String cleanPrice = item['price']!
                                .replaceAll(RegExp(r'[^0-9]'), '');
                            double parsedPrice =
                                double.tryParse(cleanPrice) ?? 0;
                            return sum + parsedPrice * (item['quantity'] ?? 1);
                          },
                        );

                        if (selectedProducts.isNotEmpty) {
                          final selectedAddress = await showDialog<Address>(
                            context: context,
                            builder: (context) => AddressSelectionDialog(),
                          );

                          if (selectedAddress != null) {
                            for (var product in selectedProducts) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PaymentDetailScreen(
                                    alamat: selectedAddress,
                                    selectedProducts: selectedProducts,
                                    productName: product['name']!,
                                    productImage: product['image']!,
                                    productPrice: totalPrice,
                                    totalPrice: totalPrice,
                                    userBalance: userBalance,
                                  ),
                                ),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text('Please select an address',
                                      style: TextStyle(
                                          color: Color(0x0000000),
                                          fontSize: 18,
                                          fontFamily: 'Poppins'))),
                            );
                          }
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text('No items selected',
                                    style: TextStyle(
                                        color: HexColor.fromHex('5c462e'),
                                        fontSize: 18,
                                        fontFamily: 'Poppins'))),
                          );
                        }
                      },
                      child: Text('Buy Now'),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15),
                        textStyle: TextStyle(
                            color: HexColor.fromHex('5c462e'),
                            fontSize: 18,
                            fontFamily: 'Poppins'),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}

class AddressSelectionDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final addressModel = Provider.of<AddressModel>(context);
    final addresses = addressModel.addresses;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: HexColor.fromHex('5c462e'), // Warna ungu
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: Center(
                child: Text(
                  'Select Address',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10.0),
              child: SingleChildScrollView(
                child: Column(
                  children: addresses.map((address) {
                    return ListTile(
                      title: Text(
                        address.toString(),
                        style: TextStyle(
                          fontFamily: 'Poppins',
                        ),
                      ),
                      onTap: () {
                        Navigator.of(context).pop(address);
                      },
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
