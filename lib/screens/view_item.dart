import 'package:firebase_demo/model/item.dart';
import 'package:firebase_demo/screens/add_item.dart';
import 'package:firebase_demo/screens/login_page.dart';
import 'package:firebase_demo/services/auth_service.dart';
import 'package:firebase_demo/services/database_service.dart';
import 'package:firebase_demo/widgets/my_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ViewItem extends StatefulWidget {
  const ViewItem({super.key});

  @override
  State<ViewItem> createState() => _ViewItemState();
}

class _ViewItemState extends State<ViewItem> {
  // open form for adding items
  _showAddItemForm() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => AddItem(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // fetch item list from stream provider
    final List<Item> itemList = Provider.of<List<Item>>(context);

    // service class to access methods
    final DatabaseService db = DatabaseService();

    // service class for authentication
    AuthService auth = AuthService();

    return Scaffold(
      backgroundColor: Colors.grey[300],
    
      appBar: AppBar(
        title: Text(
          'Your Collections',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
            onPressed: () async {
              await auth.logout();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            }, 
            icon: Icon(Icons.logout, color: Colors.black,),
          ),
        ],
      ),
    
      body: Column(
        children: [
          SizedBox(height: 20),
          
          // Statistics
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: Row( 
              children: [
                // ITEM COUNT
                Expanded(
                  child: Card(
                    color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Item count', style: TextStyle(fontSize: 18),),
                          FutureBuilder<int>(
                            future: db.countItems(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("Loading...", style: TextStyle(fontSize: 32));
                              } else if (snapshot.hasError) {
                                return Text("Error!", style: TextStyle(fontSize: 32, color: Colors.red));
                              } else {
                                return Text(
                                  '${snapshot.data}',
                                  style: TextStyle(fontSize: 32),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            
                // REVENUE
                Expanded(
                  child: Card(
                    color: Colors.blue[800],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Text('Revenue', style: TextStyle(fontSize: 18, color: Colors.white,),),
                          FutureBuilder<int>(
                            future: db.countItems(),
                            builder: (context, snapshot) {
                              if (snapshot.connectionState == ConnectionState.waiting) {
                                return Text("Loading...", style: TextStyle(fontSize: 32, color: Colors.white,));
                              } else if (snapshot.hasError) {
                                return Text("Error!", style: TextStyle(fontSize: 32, color: Colors.red));
                              } else {
                                return Text(
                                  '₹ ${snapshot.data! * 100}',
                                  style: TextStyle(fontSize: 32, color: Colors.white,),
                                );
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: itemList.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(
                      itemList[index].name.isNotEmpty ? itemList[index].name : "Dummy item",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue[800],
                      ),
                    ),
                    subtitle: Text(
                      itemList[index].category.isNotEmpty ? itemList[index].category : "None",
                      style: TextStyle(fontSize: 16),
                    ),
                    leading: Text(
                      itemList[index].id.isNotEmpty ? itemList[index].id : "000",
                      style: TextStyle(fontSize: 20),
                    ),
                    // delete action
                    trailing: IconButton(
                      onPressed: () async {                      
                        // Ask for confirmation
                        bool? confirm = await showDialog<bool>(
                          context: context, 
                          barrierDismissible: false,
                          builder: (context) => AlertDialog(
                            backgroundColor: Colors.grey[300],                            
                            title: Text('Delete this item!'),
                            content: Text('Are you sure you want to delete ${
                              itemList[index].name.isNotEmpty ? itemList[index].name : "Dummy item"
                            }?'),
                            actions: [
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context, false);
                                    },
                                    elevation: 0,
                                    color: Colors.grey[300],
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Colors.blue[800]),
                                    ),
                                  ),
                                  MaterialButton(
                                    onPressed: () {
                                      Navigator.pop(context, true);                                      
                                    },
                                    elevation: 0,
                                    color: Colors.blue[800],
                                    child: Text(
                                      'Delete',
                                      style: TextStyle(color: Colors.grey[300]),
                                    ),
                                  ),
                                ],
                          ),
                        );

                        // delete if the user confirms
                        if (confirm ?? false) {
                          await db.deleteItem(itemList[index].docId);   
                          showMySnackBar(
                            context,
                            "Removed ${itemList[index].name.isNotEmpty ? itemList[index].name : "Dummy item"}!",
                            Colors.green,
                          );                       
                        }
                      }, 
                      icon: Icon(Icons.delete, color: Colors.grey,)
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddItemForm();
        },
        backgroundColor: Colors.blue[800],
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
