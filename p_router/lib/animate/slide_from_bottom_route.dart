import 'package:flutter/material.dart';

/// [https://flutter.dev/docs/cookbook/animation/page-route-animation]
class SlideFromBottomRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  SlideFromBottomRoute({
    required this.child,
    RoutePageBuilder? builder,
    RouteSettings? settings,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return child;
          },
          settings: settings,
        );

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    var begin = Offset(0.0, 1.0);
    var end = Offset.zero;
    var tween = Tween(begin: begin, end: end);
    var offsetAnimation = animation.drive(tween);
    return SlideTransition(
      position: offsetAnimation,
      child: child,
    );
  }
}
