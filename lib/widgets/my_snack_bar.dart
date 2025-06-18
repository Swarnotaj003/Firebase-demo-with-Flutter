import 'package:flutter/material.dart';

void showMySnackBar(BuildContext context, String message, Color? color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message, style: TextStyle(color: Colors.white),),

      backgroundColor: color ?? Colors.blue[800],
      duration: Duration(seconds: 2),
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(12),

      // Must be set for margin & shape
      behavior: SnackBarBehavior.floating, 
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
    )
  );
}