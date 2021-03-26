class WebViewUtils {
  static const officialWebUrl = [
    '172.16.21.249:3000',
  ];

  /// 是否是官方的 WebUrl
  static bool isOfficialUrl(String url) {
    if (url.isEmpty || url == null) return false;
    for (final i in officialWebUrl) {
      if (url.indexOf(i) != -1) {
        return true;
      }
    }
    return false;
  }

  /// 处理 URL
  static String dealUrl(String url) {
    if (url.isEmpty || url == null) return url;
    return addUserAuth(url);
  }

  /// Url 添加用户认证信息
  static String addUserAuth(String url) {
    if (url.isEmpty || url == null) return url;
    if (isOfficialUrl(url)) {
      final uri = Uri.parse(url);
      Map<String, dynamic> q = {};
      q.addAll(uri.queryParameters);
      // q['t'] = Http.instance.token;
      // q['deviceUUID'] = Http.instance.deviceUUID;
      return uri.replace(queryParameters: q).toString();
    }
    return url;
  }
}
