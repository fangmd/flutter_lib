import 'package:meta/meta.dart';
import 'common_function.dart';

class Logger {
  static void d({tag: '', @required Object msg}) {
    if (isDebug()) {
      print('ChiCha:$tag ==> $msg');
    }
  }
}
