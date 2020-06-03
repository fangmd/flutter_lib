import './screen_utils.dart';

extension ScreenExtension on num {
  num get dp => px2dp(this.toDouble());

  num get sp => px2sp(this.toDouble());
}
