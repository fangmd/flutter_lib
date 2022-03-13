import 'package:shared_preferences/shared_preferences.dart';

///SharedPreferences 本地存储
class SPUtils {
  static late SPUtils _instance;

  static SharedPreferences? _spf;

  SPUtils._();

  Future _init() async {
    _spf = await SharedPreferences.getInstance();
  }

  static Future<SPUtils> getInstance() async {
    if (_instance == null) {
      _instance = new SPUtils._();
    }
    if (_spf == null) {
      await _instance._init();
    }
    return _instance;
  }

  // 判断是否存在数据
  bool hasKey(String key) {
    Set keys = getKeys();
    return keys.contains(key);
  }

  Set<String> getKeys() {
    return _spf!.getKeys();
  }

  get(String key) {
    return _spf!.get(key);
  }

  String? getString(String key) {
    return _spf!.getString(key);
  }

  Future<bool> putString(String key, String value) {
    return _spf!.setString(key, value);
  }

  bool? getBool(String key) {
    return _spf!.getBool(key);
  }

  Future<bool> putBool(String key, bool value) {
    return _spf!.setBool(key, value);
  }

  int? getInt(String key) {
    return _spf!.getInt(key);
  }

  Future<bool> putInt(String key, int value) {
    return _spf!.setInt(key, value);
  }

  double? getDouble(String key) {
    return _spf!.getDouble(key);
  }

  Future<bool> putDouble(String key, double value) {
    return _spf!.setDouble(key, value);
  }

  List<String>? getStringList(String key) {
    return _spf!.getStringList(key);
  }

  Future<bool> putStringList(String key, List<String> value) {
    return _spf!.setStringList(key, value);
  }

  dynamic getDynamic(String key) {
    return _spf!.get(key);
  }

  Future<bool> remove(String key) {
    return _spf!.remove(key);
  }

  Future<bool> clear() {
    return _spf!.clear();
  }
}
