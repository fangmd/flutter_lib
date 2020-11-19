import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/services.dart';
import 'package:messagepack/messagepack.dart';
import 'package:p_utils/p_utils.dart';

import 'aes.dart';
import 'callback_manager.dart';
import 'utils.dart';

/// TCP + MsgPack
class RPCHttp {
  RPCHttp._();
  static final instance = RPCHttp._();

  Socket _sockClient;

  Socket get sockClient => _sockClient;

  /// 回调管理
  CallbackManager callbackManager = CallbackManager();

  /// 公钥加载到内存
  String publicKey;

  // token
  String token = 'init';

  /// 初始化函数
  Future<void> init(String ip, int port, String publicPath) async {
    publicKey = await rootBundle.loadString(publicPath);

    _sockClient = await Socket.connect(ip, port);
    print('socket client init success');

    _sockClient.listen((event) {
      _onEvent(event);
    });
  }

  /// 处理 tcp 返回的参数
  _onEvent(Uint8List event) {
    try {
      final u = Unpacker(event);
      final map = u.unpackMap();
      // print(map);
      final data = AESUtils.instance.decryptBytes(map['data']);

      // msgpack
      // map['data'] = unpackMap(Uint8List.fromList(data));

      // json data
      map['data'] = json.decode(utf8.decode(Uint8List.fromList(data)));
      Logger.d(msg: map);
      callbackManager.useCallback(map['id'], Map<String, dynamic>.from(map));
    } catch (e) {
      Logger.d(msg: e);
    }
  }

  /// msgpack 反序列化
  Map<String, dynamic> unpackMap(Uint8List list) {
    final u = Unpacker(list);
    return Map<String, dynamic>.from(u.unpackMap());
  }

  /// msgpack 反序列化
  List<Object> unpackList(Uint8List list) {
    final u = Unpacker(list);
    return u.unpackList();
  }

  /// pack data
  /// 1. 使用 msgpack 序列化 map
  /// 2. 对序列化后的数据加密
  String packData(Map<String, dynamic> params) {
    // final it = params.keys;
    // final body = Packer();
    // body.packMapLength(params.length);
    // for (final i in it) {
    //   body.packString(i);
    //   final value = params[i];
    //   if (value is int) {
    //     body.packInt(value);
    //   } else if (params[i] is String) {
    //     body.packString(value);
    //   } else if (value is bool) {
    //     body.packBool(value);
    //   } else if (value is double) {
    //     body.packDouble(value);
    //   }
    // }
    // Uint8List bytes = body.takeBytes();

    // json
    final jsonStr = json.encode(params);
    return AESUtils.instance.encryptStr(jsonStr);
  }

  /// 发送请求
  /// [api] 接口地址
  /// [params] 请求参数
  /// [onData] 请求结果回调
  void send(String api, Map<String, dynamic> params,
      Function(Map<String, dynamic>) onData) async {
    Logger.d(msg: 'Send: $api, $params');
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
    callbackManager.addCallback(id, onData);
  }
}
