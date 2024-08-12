import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rawherbal_uas/models/address_model.dart';
import 'package:rawherbal_uas/screens/add_address_screen.dart';
import '../main.dart';

class AddressScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Address list',
            style: TextStyle(
                color: HexColor.fromHex('5c462e'),
                fontSize: 18,
                fontFamily: 'Poppins')),
      ),
      body: Consumer<AddressModel>(
        builder: (context, addressModel, child) {
          return addressModel.addresses.isEmpty
              ? Center(
                  child: Text('No address saved yet.',
                      style: TextStyle(
                          color: HexColor.fromHex('5c462e'),
                          fontSize: 18,
                          fontFamily: 'Poppins')))
              : ListView.builder(
                  itemCount: addressModel.addresses.length,
                  itemBuilder: (context, index) {
                    final address = addressModel.addresses[index];
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        elevation: 4,
                        child: ListTile(
                          title: Text(address.toString()),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: Icon(Icons.edit),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddAddressScreen(
                                        editAddress: address,
                                        addressIndex: index,
                                      ),
                                    ),
                                  );
                                },
                              ),
                              IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {
                                  addressModel.removeAddress(index);
                                },
                              ),
                            ],
                          ),
                          onTap: () {
                            addressModel.selectAddress(address);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Address is selected by default',
                                    style: TextStyle(
                                        color: HexColor.fromHex('5c462e'),
                                        fontSize: 18,
                                        fontFamily: 'Poppins')),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddAddressScreen()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
