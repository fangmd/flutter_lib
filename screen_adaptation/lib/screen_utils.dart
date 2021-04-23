import 'package:flutter_screenutil/flutter_screenutil.dart';

const bool sUseScreenAdoption = true;

/// 按照宽度比例，缩放设计稿，还原到屏幕
double px2dp(double value) {
  if (sUseScreenAdoption) {
    value = ScreenUtil().setWidth(value);
  } else {
    value = value / 2;
  }
  return value;
}

/// 字体适配
double px2sp(double value) {
  if (sUseScreenAdoption) {
    value = ScreenUtil().setSp(value);
  } else {
    value = value / 2;
  }
  return value;
}

/// 屏幕适配
/// 目前设计稿：iphone6 1334/750 16/9
class MScreenUtils {
  // static init(BuildContext context,
  //     {double width = 750.0, double height = 1334.0}) {
  //   ScreenUtilInit(context, width: width, height: height);
  // }

  /// 一个物理像素
  static double onePx() {
    return 1 / ScreenUtil().pixelRatio;
  }

  static double getWidth(double width) {
    if (sUseScreenAdoption) {
      width = ScreenUtil().setWidth(width);
    } else {
      width = width / 2;
    }
    return width;
  }

  static double getHeight(double height) {
    if (sUseScreenAdoption) {
      height = ScreenUtil().setHeight(height);
    } else {
      height = height / 2;
    }
    return height;
  }

  static double getWindowHeight() {
    return ScreenUtil().screenHeight;
  }

  static double getScreenWidth() {
    return ScreenUtil().screenWidth;
  }

  static double getScreenHeight() {
    return ScreenUtil().screenHeight;
  }
}
