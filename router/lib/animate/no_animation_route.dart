import 'package:flutter/material.dart';

class NoAnimationRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  NoAnimationRoute({
    @required this.child,
    RoutePageBuilder builder,
    RouteSettings settings,
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
    return child;
  }
}
