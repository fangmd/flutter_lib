import 'package:fluttertoast/fluttertoast.dart';

class ToastUtils {
  static void show(String msg) {
    if (msg == null) return;
    Fluttertoast.showToast(
      msg: msg,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      fontSize: 16.0,
    );
  }
}
