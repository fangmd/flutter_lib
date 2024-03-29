library p_router;

import 'package:flutter/material.dart';

/// 路由工具类
class RouterUtils {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 不需要 context 直接跳转
  static Future<T?>? pushNamedWithoutContext<T extends Object?>(String name,
      {Object? arguments}) {
    return navigatorKey.currentState?.pushNamed<T>(name, arguments: arguments);
  }

  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  static Future<T?> push<T>(BuildContext context, Widget page) {
    return Navigator.push<T?>(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<T?>? push2<T>(Widget page) {
    return navigatorKey.currentState
        ?.push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// 自定义跳转效果
  static Future<T?> pushWithRoute<T>(BuildContext context, Route<T> route) {
    return Navigator.push(context, route);
  }

  static Future<T?>? pushWithRoute2<T extends Object?>(Route<T> route) {
    return navigatorKey.currentState?.push<T>(route);
  }

  static void pop<T>(BuildContext context, [T? arguments]) {
    Navigator.pop<T>(context, arguments);
  }

  static void pop2({BuildContext? context}) {
    if (context == null) {
      navigatorKey.currentState?.pop();
    } else {
      Navigator.pop(context);
    }
  }

  /// 回退到某个页面
  static void popUntil({BuildContext? context, required String name}) {
    if (context == null) {
      navigatorKey.currentState?.popUntil(ModalRoute.withName(name));
    } else {
      Navigator.popUntil(context, ModalRoute.withName(name));
    }
  }

  /// 启动一个新的页面，并清理所有历史栈
  static void pushNamedAndRemoveAll(BuildContext context, String newRouteName) {
    Navigator.pushNamedAndRemoveUntil(context, newRouteName, (_) => false);
  }

  /// 启动一个新的页面，并清理所有历史栈
  static void pushNamedAndRemoveAll2<T>(String newRouteName, [T? arguments]) {
    navigatorKey.currentState?.pushNamedAndRemoveUntil<T>(
        newRouteName, (_) => false,
        arguments: arguments);
  }
}
