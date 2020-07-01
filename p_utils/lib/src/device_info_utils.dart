import 'package:device_info/device_info.dart';
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

  /// Get Device Name
  static Future<String> getDeviceName() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (isAndroid()) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      return androidInfo.model;
    } else if (isIOS()) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      return iosInfo.utsname.machine;
    }
    return '';
  }
}
