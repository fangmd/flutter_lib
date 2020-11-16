import 'dart:async';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/asymmetric/api.dart';

/// 请求id
int generageId() {
  return DateTime.now().microsecondsSinceEpoch;
}

/// 加密数据 rsa
/// [RSAPublicKey publicKey]
Future<String> encryptRSA(String pKey, Uint8List data) async {
  final parser = RSAKeyParser();
  final publicKey = parser.parse(pKey) as RSAPublicKey;

  final encrypter = Encrypter(RSA(publicKey: publicKey));

  final encrypted = encrypter.encryptBytes(data);
  return encrypted.base64;
}

/// 加密数据 rsa
/// [RSAPublicKey publicKey]
Future<String> encryptRSAStr(String pKey, String data) async {
  final parser = RSAKeyParser();
  final publicKey = parser.parse(pKey) as RSAPublicKey;

  final encrypter = Encrypter(RSA(publicKey: publicKey));

  final encrypted = encrypter.encrypt(data);
  return encrypted.base64;
}
