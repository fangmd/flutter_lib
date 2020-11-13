import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// 加载本地图片
/// SVG & PNG & File & Uint8List
/// 附带添加点击事件功能
class LocalImg extends StatelessWidget {
  /// 图片路径
  final String name;
  final File file;
  final Uint8List thumbBytes;

  /// 图片宽度
  final double width;

  /// 图片高度
  final double height;

  final VoidCallback onTap;

  final BoxFit fit;

  /// 控件实际宽高 = height/width + padding
  final EdgeInsetsGeometry padding;

  final double radius;

  final double containerWidth;
  final double containerHeight;
  final BoxDecoration decoration;
  final AlignmentGeometry alignment;

  const LocalImg(
    this.name, {
    Key key,
    this.thumbBytes,
    this.file,
    this.width,
    this.height,
    this.padding,
    this.onTap,
    this.fit = BoxFit.contain,
    this.containerWidth,
    this.containerHeight,
    this.decoration,
    this.alignment,
    this.radius,
  }) : super(key: key);

  LocalImg.file(this.file,
      {this.thumbBytes,
      this.name,
      this.width,
      this.height,
      this.onTap,
      this.fit,
      this.padding,
      this.containerWidth,
      this.containerHeight,
      this.decoration,
      this.radius,
      this.alignment});

  LocalImg.memory(this.thumbBytes,
      {this.file,
      this.width,
      this.name,
      this.height,
      this.onTap,
      this.fit,
      this.padding,
      this.containerWidth,
      this.containerHeight,
      this.decoration,
      this.radius,
      this.alignment});

  @override
  Widget build(BuildContext context) {
    Widget ret = _getImg();

    if (this.padding != null ||
        containerWidth != null ||
        containerHeight != null) {
      // add container
      ret = Container(
        height: containerHeight,
        width: containerWidth,
        decoration: decoration,
        alignment: alignment ?? Alignment.center,
        padding: padding ?? EdgeInsets.zero,
        child: ret,
      );
    }

    if (this.onTap != null) {
      ret = GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          this.onTap?.call();
        },
        child: ret,
      );
    }

    if (this.radius != null && this.radius > 0) {
      ret = ClipRRect(
        borderRadius: BorderRadius.circular(this.radius),
        child: ret,
      );
    }
    return ret;
  }

  Widget _getImg() {
    Widget img;
    if (name != null) {
      if (name.endsWith('svg')) {
        img = SvgPicture.asset(name,
            width: width, height: height, fit: fit ?? BoxFit.contain);
      } else {
        img = Image.asset(name, width: width, height: height, fit: fit);
      }
    }
    if (file != null) {
      img = Image.file(file, width: width, height: height, fit: fit);
    }

    if (thumbBytes != null) {
      img = Image.memory(thumbBytes, width: width, height: height, fit: fit);
    }
    return img;
  }
}
