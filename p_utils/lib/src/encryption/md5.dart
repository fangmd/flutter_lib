import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hex/hex.dart';

class MD5Utils {
  /// md5 摘要算法
  static String generateMd5(String data) {
    var content = new Utf8Encoder().convert(data);
    var digest = md5.convert(content);
    return HEX.encode(digest.bytes);
  }
}
