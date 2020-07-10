import 'package:flutter/material.dart';

/// 自定义弹框
/// 无样式
Widget customDialogPure({child: Widget}) {
  return SimpleDialog(
    titlePadding: EdgeInsets.all(0),
    contentPadding: EdgeInsets.all(0),
    backgroundColor: const Color(0x00ffffff),
    children: <Widget>[
      child,
    ],
  );
}

//// 全屏幕 弹框
Future<T> showFullScreenDialog<T>(BuildContext context, Widget child,
    {bool barrierDismissible = true}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: barrierDismissible,
    barrierLabel: MaterialLocalizations
        .of(context)
        .modalBarrierDismissLabel,
    transitionDuration: const Duration(milliseconds: 150),
    transitionBuilder: _buildMaterialDialogTransitions,
    pageBuilder: (BuildContext buildContext, Animation<double> animation,
        Animation<double> secondaryAnimation) {
      return child;
    },
  );
}

Widget _buildMaterialDialogTransitions(BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child) {
  return FadeTransition(
    opacity: CurvedAnimation(
      parent: animation,
      curve: Curves.easeOut,
    ),
    child: child,
  );
}

class FullDialogBg extends StatelessWidget {
  final Widget child;
  final bool barrierDismissible;
  final Color color;

  const FullDialogBg({
    Key key,
    this.child,
    this.barrierDismissible = true,
    this.color = const Color(0x4D000000),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (barrierDismissible) {
          Navigator.of(context).pop();
        }
      },
      child: Container(
        color: color,
        alignment: Alignment.center,
        child: Material(
          child: child,
          color: Colors.transparent,
        ),
      ),
    );
  }
}
