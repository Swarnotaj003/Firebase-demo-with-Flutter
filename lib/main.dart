import 'package:firebase_demo/model/item.dart';
import 'package:firebase_demo/screens/login_page.dart';
import 'package:firebase_demo/services/database_service.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';

/*
  STATE MANAGEMENT DOCS
  https://docs.flutter.dev/data-and-backend/state-mgmt/simple
*/

void main() async {
  // Ensure proper initialization of flutter engine
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase app
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Item>>.value(
      initialData: [],
      value: DatabaseService().itemList,
      child: MaterialApp(
        debugShowCheckedModeBanner: false, 
        home: LoginPage(),
      ),
    );
  }
}