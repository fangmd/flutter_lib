import 'package:dio/dio.dart';
import 'package:p_widget/p_widget.dart';

/// 1. 网络请求添加 loading 动画
class LoadingInterceptor extends InterceptorsWrapper {
  @override
  Future onRequest(RequestOptions options) {
    GlobalLoading.showLoading();
    return super.onRequest(options);
  }

  @override
  Future onResponse(Response response) async {
    GlobalLoading.hideLoading();
    return super.onResponse(response);
  }

  @override
  Future onError(DioError err) {
    GlobalLoading.hideLoading();
    return super.onError(err);
  }
}
