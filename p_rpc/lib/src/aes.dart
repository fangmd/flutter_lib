import 'dart:typed_data';

import 'package:encrypt/encrypt.dart';

class AESUtils {
  AESUtils._();
  static final instance = AESUtils._();

  ///TODO: pk 随机生成
  String pk = '}?%s.zJCW-46{5X{Ld({tz52ukLYHk5P';

  String encryptBytes(Uint8List bytes) {
    final key = Key.fromUtf8(pk);
    final iv = IV.fromUtf8('}?%s.zJCW-46{5X{');

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = encrypter.encryptBytes(bytes, iv: iv);
    return encrypted.base64;
  }

  String encryptStr(String content) {
    final key = Key.fromUtf8(pk);
    final iv = IV.fromUtf8('}?%s.zJCW-46{5X{');

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = encrypter.encrypt(content, iv: iv);
    return encrypted.base64;
  }

  String decryptStr(String content) {
    final key = Key.fromUtf8(pk);
    final iv = IV.fromUtf8('}?%s.zJCW-46{5X{');

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = Encrypted.fromBase64(content);

    final decrypted = encrypter.decrypt(encrypted, iv: iv);
    return decrypted;
  }

  List<int> decryptBytes(String content) {
    final key = Key.fromUtf8(pk);
    final iv = IV.fromUtf8('}?%s.zJCW-46{5X{');

    final encrypter = Encrypter(AES(key, mode: AESMode.cbc));

    final encrypted = Encrypted.fromBase64(content);

    final decrypted = encrypter.decryptBytes(encrypted, iv: iv);
    return decrypted;
  }
}
