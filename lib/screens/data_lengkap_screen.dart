import 'package:flutter/material.dart';
import '../main.dart';

class DataLengkapScreen extends StatefulWidget {
  @override
  _DataLengkapScreenState createState() => _DataLengkapScreenState();
}

class _DataLengkapScreenState extends State<DataLengkapScreen> {
  bool isEditing = false;
  TextEditingController nameController =
      TextEditingController(text: 'Golden Cheeze');
  TextEditingController birthDateController =
      TextEditingController(text: '03 Januari 2003');
  TextEditingController genderController =
      TextEditingController(text: 'Laki-laki');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Data Detail'),
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width:
                double.infinity, // Menyesuaikan lebar card dengan lebar layar
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildEditableField(
                  'Full Name',
                  nameController,
                  isEditing,
                ),
                SizedBox(height: 16),
                _buildEditableField(
                  'Date birth',
                  birthDateController,
                  isEditing,
                ),
                SizedBox(height: 16),
                _buildEditableField(
                  'Gender',
                  genderController,
                  isEditing,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEditableField(
    String label,
    TextEditingController controller,
    bool isEditable,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: HexColor.fromHex('5c462e'),
          ),
        ),
        SizedBox(height: 8),
        isEditable
            ? TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                ),
              )
            : Text(
                controller.text,
                style: TextStyle(fontSize: 18),
              ),
      ],
    );
  }
}
