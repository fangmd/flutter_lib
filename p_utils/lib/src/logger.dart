import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'common_function.dart';

class Logger {
  static void d({tag: '', @required Object msg}) {
    if (isDebug()) {
      if (msg is String) {
        final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
        pattern.allMatches(msg).forEach((match) => debugPrint('$tag==>${match.group(0)}'));
      } else if (msg is Map) {
        final text = json.encode(msg);
        final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
        pattern.allMatches(text).forEach((match) => debugPrint('$tag==>${match.group(0)}'));
      } else {
        debugPrint('PUtils:$tag ==> $msg');
      }
    }
  }
}
