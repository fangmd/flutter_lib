# router

router utils

## Setup

定义路由 Map: `router/router_config.dart`

```Dart
Map<String, WidgetBuilder> route = {
  HomePage.routeName: (_) => HomePage(),
  MainPage.routeName: (_) => MainPage(),
  MinePage.routeName: (_) => MinePage(),
};
```

在 MaterialApp 中设置 `navigatorKey`

```Dart
MaterialApp(
    navigatorKey: RouterUtils.navigatorKey,
    routes: route,
    home: Builder(
        builder: (context) {
            return SplashPage();
        },
    ),
    ...
}
```

