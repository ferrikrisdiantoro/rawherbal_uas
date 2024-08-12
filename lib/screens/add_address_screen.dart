import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import 'package:rawherbal_uas/models/address_model.dart';

class AddAddressScreen extends StatefulWidget {
  final Address? editAddress;
  final int? addressIndex;

  const AddAddressScreen({Key? key, this.editAddress, this.addressIndex})
      : super(key: key);

  @override
  _AddAddressScreenState createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _nameController = TextEditingController();
  final _streetController = TextEditingController();
  final _villageController = TextEditingController();
  final _districtController = TextEditingController();
  final _regencyController = TextEditingController();
  final _provinceController = TextEditingController();
  final _postalCodeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.editAddress != null) {
      final address = widget.editAddress!;
      _nameController.text = address.name;
      _streetController.text = address.street;
      _villageController.text = address.village;
      _districtController.text = address.district;
      _regencyController.text = address.regency;
      _provinceController.text = address.province;
      _postalCodeController.text = address.postalCode;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            Text(widget.editAddress != null ? 'Edit Address' : 'Add Address'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField(_nameController, 'Nama'),
            _buildTextField(_streetController, 'Jalan'),
            _buildTextField(_villageController, 'Desa'),
            _buildTextField(_districtController, 'Kecamatan'),
            _buildTextField(_regencyController, 'Kabupaten'),
            _buildTextField(_provinceController, 'Provinsi'),
            _buildTextField(_postalCodeController, 'Kode Pos'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newAddress = Address(
                  name: _nameController.text.trim(),
                  street: _streetController.text.trim(),
                  village: _villageController.text.trim(),
                  district: _districtController.text.trim(),
                  regency: _regencyController.text.trim(),
                  province: _provinceController.text.trim(),
                  postalCode: _postalCodeController.text.trim(),
                );
                if (widget.editAddress != null && widget.addressIndex != null) {
                  Provider.of<AddressModel>(context, listen: false)
                      .editAddress(widget.addressIndex!, newAddress);
                } else {
                  Provider.of<AddressModel>(context, listen: false)
                      .addAddress(newAddress);
                }
                Navigator.pop(context);
              },
              child: Text(
                  widget.editAddress != null ? 'Save Changes' : 'Add Address',
                  style: TextStyle(
                      color: HexColor.fromHex('5c462e'),
                      fontSize: 18,
                      fontFamily: 'Poppins')),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
