import 'dart:async';
import 'dart:collection';

/// 回调管理
/// 1. 添加回调，使用回调
/// 2. 请求超时处理 5s
class CallbackManager {
  /// 请求结果回调 id-Callback
  Map<int, Function(Map<String, dynamic>)> _callback =
      HashMap<int, Function(Map<String, dynamic>)>();

  /// 请求结果回调 id-addTime
  Map<int, int> _callbackTime = HashMap<int, int>();

  /// 轮询
  Timer _timer;

  /// 添加回调
  addCallback(int id, Function(Map<String, dynamic>) callback) {
    _callback[id] = callback;
    _callbackTime[id] = DateTime.now().millisecondsSinceEpoch;
    _detectOutTime();
  }

  /// 使用回调并删除
  useCallback(int id, Map<String, dynamic> params) {
    _callback[id]?.call(params);
    _removeCallback(id: id);
  }

  /// 移除回调
  _removeCallback({int id, List<int> ids}) {
    if (id != null) {
      _callbackTime.remove(id);
      _callback.remove(id);
    }
    if (ids != null && ids.length > 0) {
      for (final i in ids) {
        _callbackTime.remove(i);
        _callback.remove(i);
      }
    }
  }

  /// 检测超时回调 5s
  _detectOutTime() {
    if (_timer != null) return;
    _timer = Timer.periodic(Duration(seconds: 1), (_) {
      List<int> _tmpRemoves = [];
      final nowMill = DateTime.now().millisecondsSinceEpoch;
      _callbackTime.forEach((key, value) {
        if (nowMill - nowMill >= 5 * 60 * 1000) {
          _tmpRemoves.add(value);
        }
      });

      //TOOD:opt, onError
      if (_tmpRemoves.length > 0) {
        for (final i in _tmpRemoves) {
          useCallback(i, null);
        }
      }

      // 没有 callback 时，关闭轮询
      if (_callback.length == 0) {
        _cancelTimer();
      }
    });
  }

  _cancelTimer() {
    _timer.cancel();
    _timer = null;
  }
}
