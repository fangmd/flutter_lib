import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../p_image_loader.dart';

/// 网络图片加载控件
/// 支持点击 & 圆角
class CachedNetImg extends StatelessWidget {
  static const Color greyF2 = Color(0xFFF2F2F2);

  final String imgUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final Color placeHolderColor;
  final String placeHolderAssets;

  /// 设置点击事件
  final VoidCallback onTap;

  /// 设置圆角
  final double radius;
  final File file;
  final EdgeInsetsGeometry padding;

  const CachedNetImg(
      {Key key,
      this.imgUrl,
      this.file,
      this.width,
      this.height,
      this.fit,
      this.placeHolderColor = greyF2,
      this.placeHolderAssets,
      this.onTap,
      this.radius,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (file != null) {
      return LocalImg.file(
        file,
        height: height,
        width: width,
        fit: fit,
        radius: radius,
        padding: padding,
        onTap: onTap,
      );
    }

    Widget ret;
    if (radius != null && radius > 0) {
      ret = _buildRoundCore();
    } else {
      ret = _buildCore();
    }

    if (onTap != null) {
      ret = GestureDetector(
        behavior: HitTestBehavior.opaque,
        child: ret,
        onTap: onTap,
      );
    }
    return ret;
  }

  Widget _buildCore() {
    return Container(
      width: width,
      height: height,
      child: CachedNetworkImage(
        imageUrl: imgUrl ?? '',
        width: width,
        height: height,
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        fit: fit,
        placeholder: placeholder,
      ),
    );
  }

  Widget _buildRoundCore() {
    return Container(
      height: height,
      width: width,
      child: CachedNetworkImage(
        imageUrl: imgUrl ?? '',
        placeholder: placeholder,
        fadeInDuration: Duration.zero,
        fadeOutDuration: Duration.zero,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(radius)),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget placeholder(BuildContext context, _) {
    if (placeHolderAssets != null && placeHolderAssets.isNotEmpty) {
      return LocalImg(
        placeHolderAssets,
        radius: radius,
        width: width,
        height: height,
        fit: fit,
      );
    }

    if (radius != null && radius > 0) {
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          color: placeHolderColor,
        ),
      );
    } else {
      return Container(color: placeHolderColor);
    }
  }
}
