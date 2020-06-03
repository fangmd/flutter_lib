import 'package:device_info/device_info.dart';
import 'package:package_info/package_info.dart';
import 'dart:io' show Platform;

/// 获取 deviceId
/// 获取 appVersion, appVersionCode
class AppInfoUtils {
  static String appVersion = '';
  static String deviceId = '';

  static Future<String> getAppVersionName() async {
    if (appVersion.isNotEmpty) {
      return appVersion;
    }
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  static Future<String> getAppVersionCode() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  static Future<String> getId() async {
    if (deviceId.isNotEmpty) {
      return deviceId;
    }

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      deviceId = androidDeviceInfo.androidId; // unique ID on android
    } else if (Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId = iosDeviceInfo.identifierForVendor; // unique ID on iOS
    }
    return deviceId;
  }
}
