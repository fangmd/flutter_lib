import 'package:flutter/material.dart';
import 'package:p_utils/p_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'data/js_data.dart';

class JSManager {
  static Set<JavascriptChannel> getJSChannel(BuildContext context,
      {Function(String shareTitle, dynamic data) addShare}) {
    return [
      JavascriptChannel(
        name: 'PApp',
        onMessageReceived: (JavascriptMessage message) {
          Logger.d(msg: message.message);
          try {
            final jsData = JSData.fromJson(message.message);
            
          } catch (e) {
            Logger.d(msg: e);
          }
        },
      ),
    ].toSet();
  }
}
