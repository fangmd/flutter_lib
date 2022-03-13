import 'package:flutter/material.dart';

/// 圆形 色块
class CircleWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const CircleWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
      ),
    );
  }
}

/// 矩形 色块
class RectangleWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final Color? color;

  const RectangleWidget({
    Key? key,
    this.height,
    this.width,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      color: color,
    );
  }
}

/// 空白填充组件
/// 在 Row&Column 中使用
class EmptyExpanded extends StatelessWidget {
  const EmptyExpanded({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: SizedBox());
  }
}
