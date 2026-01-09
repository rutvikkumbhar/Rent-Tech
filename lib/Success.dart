import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Success {
  void toastMessage(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      backgroundColor: const Color(0xff3A7D44),
      textColor: Colors.white,
      fontSize: 14,
    );
  }
}