import 'package:launch_review/launch_review.dart';
import 'package:url_launcher/url_launcher.dart';

/// 判断 app 是否是 debug 版本
bool isDebug() {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

/// make a phone call
void call(String phone) {
  if (!phone.startsWith('tel:')) {
    phone = 'tel:$phone';
  }
  launch(phone);
}

/// 外部游览起打开 url 地址
void openUrlOutSide(String url) {
  launch(url);
}

/// open app store for app
void openMarket() {
  LaunchReview.launch();
}
