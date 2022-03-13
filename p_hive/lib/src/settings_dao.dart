import 'hive_dao.dart';

/// 设置相关数据
class SettingsDao extends HiveDao {
  @override
  String getBoxName() {
    return 'settings';
  }
}
