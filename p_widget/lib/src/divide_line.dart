import 'package:flutter/material.dart';

/// 分割线
class MDivide extends StatelessWidget {
  static const Color DefaultColor = Color(0xFFEDEDED);

  final double pad;

  /// 颜色
  final Color color;

  /// 方向
  final Axis direction;
  final double? weight;

  const MDivide({
    Key? key,
    this.pad = 0,
    this.color = DefaultColor,
    this.direction = Axis.horizontal,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double? wei = weight;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    if (wei == null) {
      wei = 1 / mediaQuery.devicePixelRatio;
    }
    if (direction == Axis.vertical) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: pad),
        height: double.infinity,
        decoration: BoxDecoration(
          color: color,
          boxShadow: [
            BoxShadow(
              offset: Offset(1, 6),
              color: Color.fromARGB(10, 0, 0, 0),
              blurRadius: 5,
            ),
          ],
        ),
        width: wei,
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(horizontal: pad),
      width: double.infinity,
      height: wei,
      color: color,
    );
  }
}
