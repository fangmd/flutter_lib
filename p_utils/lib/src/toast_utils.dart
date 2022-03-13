import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static bool isShowing = false;

  static void show(String msg) async {
    if (msg == '') return;
    if (!isShowing) {
      isShowing = true;
      Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 16.0,
      );

      Future.delayed(const Duration(milliseconds: 1000), () {
        isShowing = false;
      });
    }
  }
}
