import 'dart:async';
import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';
import 'package:flutter/services.dart';
import 'package:pointycastle/asymmetric/api.dart';

/// 请求id
int generageId() {
  return DateTime.now().microsecondsSinceEpoch;
}

/// 加密数据 rsa
/// [RSAPublicKey publicKey]
Future<String> encryptRSA(Uint8List data) async {
  final key = await rootBundle.loadString('assets/public.pem');

  final parser = RSAKeyParser();
  final publicKey = parser.parse(key) as RSAPublicKey;

  final encrypter = Encrypter(RSA(publicKey: publicKey));

  final encrypted = encrypter.encryptBytes(data);
  return encrypted.base64;
}

/// 加密数据 rsa
/// [RSAPublicKey publicKey]
Future<String> encryptRSAStr(String data) async {
  final key = await rootBundle.loadString('assets/public.pem');

  final parser = RSAKeyParser();
  final publicKey = parser.parse(key) as RSAPublicKey;

  final encrypter = Encrypter(RSA(publicKey: publicKey));

  final encrypted = encrypter.encrypt(data);
  return encrypted.base64;
}
