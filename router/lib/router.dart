library router;

import 'package:flutter/material.dart';

/// 路由工具类
class RouterUtils {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 不需要 context 直接跳转
  static Future<T> pushNamedWithoutContext<T>(String name, {Object arguments}) {
    return navigatorKey.currentState.pushNamed<T>(name, arguments: arguments);
  }

  static Future<T> pushNamed<T>(
    BuildContext context,
    String routeName, {
    Object arguments,
  }) {
    return Navigator.pushNamed<T>(context, routeName, arguments: arguments);
  }

  static void push(BuildContext context, Widget page) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => page),
    );
  }

  static Future<T> push2<T>(Widget page) {
    return navigatorKey.currentState
        .push<T>(MaterialPageRoute(builder: (_) => page));
  }

  /// 自定义跳转效果
  static void pushWithRoute(BuildContext context, Route route) {
    Navigator.push(context, route);
  }

  static void pop<T>(BuildContext context, [T arguments]) {
    Navigator.pop<T>(context, arguments);
  }

  static void pop2({BuildContext context}) {
    if (context == null) {
      navigatorKey.currentState.pop();
    } else {
      Navigator.pop(context);
    }
  }

  /// 启动一个新的页面，并清理所有历史栈
  static void pushNamedAndRemoveAll(BuildContext context, String newRouteName) {
    Navigator.pushNamedAndRemoveUntil(context, newRouteName, (_) => false);
  }

  /// 启动一个新的页面，并清理所有历史栈
  static void pushNamedAndRemoveAll2(String newRouteName) {
    navigatorKey.currentState.pushNamedAndRemoveUntil(
      newRouteName,
      (_) => false,
    );
  }
}
