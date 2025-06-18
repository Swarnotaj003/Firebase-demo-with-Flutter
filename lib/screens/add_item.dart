import 'package:firebase_demo/services/database_service.dart';
import 'package:firebase_demo/widgets/my_snack_bar.dart';
import 'package:flutter/material.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  DatabaseService db = DatabaseService();

  // text controllers
  final _idController = TextEditingController();
  final _nameController = TextEditingController();
  final _categoryController = TextEditingController();

  // clear text controllers
  void clearControllers() {
    _idController.clear();
    _nameController.clear();
    _categoryController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[300],

      title: Text(
        'Add new item',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        textAlign: TextAlign.center,
      ),

      content: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _idController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Id',
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Name',
                    ),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 20),
            
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: TextField(
                    controller: _categoryController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Category',
                    ),
                  ),
                ),
              ),
            ),
            
            SizedBox(height: 30),
            // Submit BTN
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () {
                  if (_idController.text.isNotEmpty && _nameController.text.isNotEmpty && _categoryController.text.isNotEmpty) {
                    db.addItem(
                      _idController.text.trim(), 
                      _nameController.text.trim(), 
                      _categoryController.text.trim()
                    );
                    clearControllers();
                    Navigator.of(context).pop();
                    showMySnackBar(context, "Item added successfully!", Colors.green);
                  }
                },
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'Add Item',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
