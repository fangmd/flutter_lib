import 'dart:collection';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:messagepack/messagepack.dart';

import 'aes.dart';
import 'utils.dart';

/// TCP + MsgPack
class RPCHttp {
  RPCHttp._();
  static final instance = RPCHttp._();

  Socket _sockClient;

  Socket get sockClient => _sockClient;

  Map<int, Function(Map<String, dynamic>)> _callback = HashMap();

  /// 公钥加载到内存
  String publicKey;

  // token
  String token = 'init';

  /// 初始化函数
  Future<void> init(String ip, int port) async {
    publicKey = await rootBundle.loadString('assets/public.pem');

    _sockClient = await Socket.connect(ip, port);
    print('socket client init success');

    _sockClient.listen((event) {
      _onEvent(event);
    });
  }

  _onEvent(Uint8List event) {
    final u = Unpacker(event);
    final map = u.unpackMap();
    // print(map);
    final data = AESUtils.instance.decryptBytes(map['data']);
    map['data'] = unpack(Uint8List.fromList(data));
    print(map);
    _callback[map['id']].call(Map<String, dynamic>.from(map));
  }

  Map<String, dynamic> unpack(Uint8List list) {
    final u = Unpacker(list);
    return Map<String, dynamic>.from(u.unpackMap());
  }

  /// pack data
  /// 1. 使用 msgpack 序列化 map
  /// 2. 对序列化后的数据加密
  String packData(Map<String, dynamic> params) {
    final it = params.keys;
    final body = Packer();
    body.packMapLength(params.length);
    for (final i in it) {
      body.packString(i);
      final value = params[i];
      if (value is int) {
        body.packInt(value);
      } else if (params[i] is String) {
        body.packString(value);
      } else if (value is bool) {
        body.packBool(value);
      } else if (value is double) {
        body.packDouble(value);
      }
    }
    Uint8List bytes = body.takeBytes();
    return AESUtils.instance.encryptBytes(bytes);
  }

  /// 发送请求
  /// [api] 接口地址
  /// [params] 请求参数
  /// [onData] 请求结果回调
  void send(String api, Map<String, dynamic> params,
      Function(Map<String, dynamic>) onData) async {
    int id = generageId();
    final body = Packer();
    body.packMapLength(5);
    body.packString('id');
    body.packInt(id);
    body.packString('auth');
    body.packString(await encryptRSAStr(publicKey, AESUtils.instance.pk));
    body.packString('api');
    body.packString(AESUtils.instance.encryptStr(api));
    body.packString('token');
    body.packString(AESUtils.instance.encryptStr(token));
    body.packString('data');
    body.packString(packData(params));

    Uint8List bytes = body.takeBytes(); // Uint8List
    _sockClient.add(bytes);
    _callback[id] = onData;
  }
}
