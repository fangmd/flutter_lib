import 'package:dio/dio.dart';

/// 管理 gas
/// 实时获取
class Gas {
  Gas._();
  static final instance = Gas._();

  /// 限制 Gas 最大费用
  static double limit;

  // static double safeLow;
  // static double standard;
  // static double fast;
  // static double fastest;

  /// 实时获取
  /// rapid: 15s, fast 1min, standard 3min, slow >10min
  /// ```
  ///  {
  ///   "code": 200,
  ///   "data": {
  ///     "rapid": 180132000000, wei
  ///     "fast": 177000000000,
  ///     "slow": 150000000000,
  ///     "standard": 109000001459,
  ///     "timestamp": 1598434638872,
  ///   }
  /// }
  /// ```
  static Future<Map<String, dynamic>> getGas() async {
    final dio = Dio();
    final ret = await dio.get(
        'https://gasnow.sparkpool.com/api/v3/gas/price?utm_source=peth');
    print(ret.data);
    return ret.data as Map<String, dynamic>;
  }
}
