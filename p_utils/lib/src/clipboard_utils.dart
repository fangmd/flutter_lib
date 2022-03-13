import 'package:clipboard/clipboard.dart';

class ClipboardUtils {
  /// 复制内容到剪贴板
  static Future copy(String content) async {
    return await FlutterClipboard.copy(content);
  }
}
