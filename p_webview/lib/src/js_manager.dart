import 'package:flutter/material.dart';
import 'package:p_utils/p_utils.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'data/js_data.dart';

class JSManager {
  static Set<JavascriptChannel> getJSChannel(BuildContext context,
      {Function(String shareTitle, dynamic data) addShare}) {
    return [
      JavascriptChannel(
        name: 'CCBridge',
        onMessageReceived: (JavascriptMessage message) {
          Logger.d(msg: message.message);
          try {
            final jsData = JSData.fromJson(message.message);
            if (jsData.method == 'joinActivity') {
            }

            if (jsData.method == 'addShare') {
              Logger.d(msg: 'addShare');
              final type = jsData.data['type'];
              // if (type == 'Activity') {
              //   final activityId = int.parse(jsData.data['activityId']);
              //   final kolImg = jsData.data['kolImg'];
              //   final activityTitle = jsData.data['activityTitle'];
              //   final data =
              //       WebShareActivityData(activityId, kolImg, activityTitle);
              //   addShare(activityTitle, data);
              // }
            }
          } catch (e) {
            Logger.d(msg: e);
          }
        },
      ),
    ].toSet();
  }
}
