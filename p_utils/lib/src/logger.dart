import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'common_function.dart';

class Logger {
  static void d({tag: '', @required Object msg}) {
    if (isDebug()) {
      debugPrint('ChiCha:$tag ==> $msg');
    }
  }
}
