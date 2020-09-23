import 'package:flutter/material.dart';

/// 分割线
class MDivide extends StatelessWidget {
  static const Color DefaultColor = Color(0xFFF4F0FF);

  final double pad;

  /// 颜色
  final Color color;

  /// 方向
  final Axis direction;
  final double weight;

  const MDivide({
    Key key,
    this.pad,
    this.color = DefaultColor,
    this.direction = Axis.horizontal,
    this.weight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double wei = weight;
    MediaQueryData mediaQuery = MediaQuery.of(context);
    if (wei == null) {
      wei = 1 / mediaQuery.devicePixelRatio;
    }
    if (this.direction == Axis.vertical) {
      return Container(
        margin: EdgeInsets.symmetric(vertical: pad ?? 0),
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
      margin: EdgeInsets.symmetric(horizontal: pad ?? 0),
      width: double.infinity,
      height: wei,
      color: color,
    );
  }
}
