import 'package:flutter/material.dart';
import 'view_state.dart';

abstract class BaseVM extends ChangeNotifier {
  /// 防止页面销毁后,异步任务才完成,导致报错
  bool _disposed = false;

  bool get disposed => _disposed;

  ViewState _viewState = ViewState.Idle;

  ViewState get viewState => _viewState;

  void showViewState(ViewState viewState) {
    _viewState = viewState;
    notifyListeners();
  }

  // 加载数据
  loadData();

  @override
  void notifyListeners() {
    if (!_disposed) {
      super.notifyListeners();
    }
  }

  @override
  void dispose() {
    // release res
    _disposed = true;
    super.dispose();
  }
}
