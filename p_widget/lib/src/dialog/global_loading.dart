import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'spinkit/circle.dart';

const int _windowPopupDuration = 300;
const double _kWindowCloseIntervalEnd = 2.0 / 3.0;
const Duration _kWindowDuration = Duration(milliseconds: _windowPopupDuration);

/// 全局 Loading
/// ```dart
/// GlobalLoading.navigatorKey = RouterUtils.navigatorKey
/// 
/// GlobalLoading.showLoading();
///
/// GlobalLoading.hideLoading();
/// ```
class GlobalLoading {
  static int showCnt = 0;

  static GlobalKey<NavigatorState> navigatorKey;

  /// [forceLoading]: true: Android 下物理按钮无效， false: Android 下物理返回有效
  static void showLoading({
    double elevation = 10.0,
    int duration = 200,
    bool forceLoading = true,
  }) {
    showCnt++;

    final RelativeRect position = RelativeRect.fromLTRB(0, 0, 0, 0);

    navigatorKey.currentState.push(_PopupWindowRoute(
      position: position,
      mbarrierDismissible: false,
      color: Color(0x00ffffff),
      child: WillPopScope(
        child: _buildCore(),
        onWillPop: () {
          print('onWillPop $showCnt $forceLoading');
          if (forceLoading) {
            return Future.value(false);
          } else {
            showCnt--;
            return Future.value(true);
          }
        },
      ),
      elevation: elevation,
      duration: duration,
    ));
  }

  static Stack _buildCore() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0x00ffffff),
        ),
        Align(
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: SpinKitCircle(
              color: Color(0xFF333333),
              size: 40.0,
            ),
          ),
        )
      ],
    );
  }

  static void hideLoading() {
    if (showCnt > 0) {
      showCnt--;
      if (showCnt <= 0) {
        navigatorKey.currentState.pop();
      }
    }
  }
}

class _PopupWindowRoute extends PopupRoute {
  _PopupWindowRoute({
    this.position,
    this.child,
    this.elevation,
    this.barrierLabel,
    this.semanticLabel,
    this.duration,
    this.mbarrierDismissible = true,
    this.color = Colors.white,
    this.type = MaterialType.card,
  });

  @override
  Animation<double> createAnimation() {
    return CurvedAnimation(
      parent: super.createAnimation(),
      curve: Curves.linear,
      reverseCurve: const Interval(0.0, _kWindowCloseIntervalEnd),
    );
  }

  final RelativeRect position;
  final Widget child;
  final double elevation;
  final String semanticLabel;
  @override
  final String barrierLabel;
  final int duration;
  final MaterialType type;

  @override
  Duration get transitionDuration =>
      duration == 0 ? _kWindowDuration : Duration(milliseconds: duration);

  bool mbarrierDismissible;

  @override
  bool get barrierDismissible => mbarrierDismissible;

  @override
  Color get barrierColor => null;

  Color color;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    final CurveTween opacity =
        CurveTween(curve: const Interval(0.0, 1.0 / 3.0));

    return Builder(
      builder: (BuildContext context) {
        return CustomSingleChildLayout(
          delegate: _PopupWindowLayout(position),
          child: AnimatedBuilder(
            child: child,
            animation: animation,
            builder: (BuildContext context, Widget child) {
              return Opacity(
                opacity: opacity.evaluate(animation),
                child: Material(
                  color: color,
                  type: type,
                  elevation: elevation,
                  child: child,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _PopupWindowLayout extends SingleChildLayoutDelegate {
  _PopupWindowLayout(this.position);

  // Rectangle of underlying button, relative to the overlay's dimensions.
  final RelativeRect position;

  // We put the child wherever position specifies, so long as it will fit within
  // the specified parent size padded (inset) by 8. If necessary, we adjust the
  // child's position so that it fits.

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    // The menu can be at most the size of the overlay minus 8.0 pixels in each
    // direction.
    return BoxConstraints.loose(constraints.biggest);
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: The size of the overlay.
    // childSize: The size of the menu, when fully open, as determined by
    // getConstraintsForChild.

    // Find the ideal vertical position.
    double y = position.top;

    // Find the ideal horizontal position.
    double x = 0;
    if (position.left > position.right) {
      // Menu button is closer to the right edge, so grow to the left, aligned to the right edge.
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // Menu button is closer to the left edge, so grow to the right, aligned to the left edge.
      x = position.left;
    }
    return Offset(x, y);
  }

  @override
  bool shouldRelayout(_PopupWindowLayout oldDelegate) {
    return position != oldDelegate.position;
  }
}
