import 'package:devicelocale/devicelocale.dart';
import 'dart:io' show Platform;

class DeviceInfoUtils {
  static getLocalization() async {
    return await Devicelocale.currentLocale;
  }

  static bool isAndroid() {
    return Platform.isAndroid;
  }

  static bool isIOS() {
    return Platform.isIOS;
  }
}
