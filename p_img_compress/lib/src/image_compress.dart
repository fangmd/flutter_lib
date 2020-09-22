import 'dart:io';
import 'package:p_widget/p_widget.dart';
import 'package:p_utils/p_utils.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompress {
  ///TODO：opt, 小图片不压缩
  static Future<File> compressImg(File img,
      {loading = true, noGreyBg = false}) async {
    if (loading) {
      if (noGreyBg) {
        GlobalLoading.showLoading(elevation: 0);
      } else {
        GlobalLoading.showLoading();
      }
    }

    try {
      Directory tempDir = await getTemporaryDirectory();
      String imgCachedPath = tempDir.path;
      var result = await FlutterImageCompress.compressAndGetFile(
        img.absolute.path,
        '$imgCachedPath/${DateTime.now().millisecondsSinceEpoch}.jpg',
        quality: 80,
      );
      return result;
    } catch (e) {
      Logger.d(msg: 'compress error: $e');
    } finally {
      if (loading) GlobalLoading.hideLoading();
    }
    return null;
  }
}
