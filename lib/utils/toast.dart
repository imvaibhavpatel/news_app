import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

toast({required String message, required Color colors}) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: colors,
      textColor: Colors.white,
      fontSize: 16.0);
}