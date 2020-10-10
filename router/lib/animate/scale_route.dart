import 'package:flutter/material.dart';

class ScaleAnimationRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  ScaleAnimationRoute({
    @required this.child,
  }) : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return child;
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return ScaleTransition(scale: animation, child: child);
          },
        );
}
