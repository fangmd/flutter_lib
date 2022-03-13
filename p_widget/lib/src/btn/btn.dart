import 'package:flutter/material.dart';

/// 按钮
class MFlatButton extends StatelessWidget {
  /// 点击事件
  final VoidCallback? onPressed;

  /// 设置按钮是否可用
  final bool enable;

  /// 文本
  final String content;
  final Color? bgColor;

  /// 不可用 背景色
  final Color? disableBgColor;

  /// 长按按钮颜色
  final Color? highlightColor;

  /// 不可用 文字颜色
  final Color? disabledTextColor;

  /// 文本样式
  final TextStyle? textStyle;

  /// 按钮宽度
  final double? width;

  /// 按钮高度
  final double? height;

  /// 圆角
  final double? radius;

  final EdgeInsetsGeometry? margin;

  const MFlatButton({
    Key? key,
    this.onPressed,
    this.enable = true,
    this.content = '',
    this.bgColor,
    this.disableBgColor,
    this.highlightColor,
    this.disabledTextColor,
    this.textStyle,
    this.width,
    this.height,
    this.margin,
    this.radius = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final btn = FlatButton(
      color: bgColor,
      // textColor: Colors.white, // 正常 文字颜色
      disabledTextColor: disabledTextColor, // 不可用 文字颜色
      disabledColor: disableBgColor, // 不可用 背景色
      highlightColor: highlightColor, // 长按颜色
      splashColor: highlightColor, // 波纹颜色
      onPressed: enable ? onPressed : null,
      child: Text(content, style: textStyle),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius ?? 0),
      ),
    );
    if (width == null && height == null) {
      return btn;
    } else {
      return Container(
        height: height,
        width: width,
        margin: margin ?? EdgeInsets.zero,
        child: btn,
      );
    }
  }
}
