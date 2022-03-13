import 'package:hive/hive.dart';

abstract class HiveDao<T> {
  String getBoxName();

  init() async {
    await Hive.openBox<T>(getBoxName());
  }

  Box<T> getBox() {
    return Hive.box<T>(getBoxName());
  }

  void set(String key, dynamic value) {
    getBox().put(key, value);
  }

  dynamic get(String key) {
    return getBox().get(key);
  }

  dynamic getAt(int index) {
    return getBox().getAt(index);
  }

  Future<int> add(T data) {
    return getBox().add(data);
  }

  String? getString(String key) {
    if (getBox().get(key) is String?) {
      return getBox().get(key) as String?;
    }
  }

  void delete(String key) {
    getBox().delete(key);
  }

  int? getInt(String key) {
    if (getBox().get(key) is int?) {
      return getBox().get(key) as int?;
    }
  }

  double? getDouble(String key) {
    if (getBox().get(key) is double?) {
      return getBox().get(key) as double?;
    }
  }

  Future<int?> clear() {
    return getBox().clear();
  }
}
