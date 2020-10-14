// import 'dart:io' show Platform;
// import 'package:dio/dio.dart';
// import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
// import 'package:p_net/src/toast_interceptor.dart';
// import 'package:p_utils/p_utils.dart';
// import 'loading_interceptor.dart';
// import 'net_config.dart';

// class Http {
//   static final Http _singleton = Http._internal();

//   static Http get instance {
//     return _singleton;
//   }

//   factory Http() {
//     return _singleton;
//   }

//   Http._internal();

//   /// 普通请求
//   Map<String, Dio> _dioMap = {};
//   Map<String, Dio> _dioEncryptMap = {};

//   String token;
//   String deviceUUID;

//   /// 带有 Loading 的请求
//   Dio _loadingDio;

//   /// 带有 Loading 的请求
//   Dio _loadingEncryptDio;

//   Dio _noErrorDio;

//   Dio _downloadDio;

//   Map<String, String> headers = {};

//   ///dio 配置
//   BaseOptions getCommonOptions(Map<String, dynamic> header, {String url}) {
//     if (url == null) {
//       url = NetConfig.baseURL;
//     }
//     var options = BaseOptions(
//       connectTimeout: 5000,
//       baseUrl: url,
//       contentType: Headers.formUrlEncodedContentType,
//     );
//     options.headers.addAll(headers);
//     if (header != null) {
//       options.headers.addAll(header);
//     }
//     return options;
//   }

//   Future<Dio> createRefreshTokenDio(
//       {String url, Map<String, String> header}) async {
//     if (url == null) {
//       url = NetConfig.baseURL;
//     }

//     await initCommonHeader();
//     final dio = new Dio(getCommonOptions(header, url: url));
//     if (isDebug()) {
//       dio.interceptors.add(LogInterceptor(
//         requestHeader: true,
//         requestBody: true,
//         responseHeader: false,
//         responseBody: true,
//       ));
//     }

//     dio.transformer = FlutterTransformer();

//     dio.interceptors.add(TokenInterceptor());
//     dio.interceptors.add(RefreshTokenInterceptor());
//     return dio;
//   }

//   Future<Dio> getDio({String url, Map<String, String> header}) async {
//     if (url == null) {
//       url = NetConfig.baseURL;
//     }

//     Dio dio = _dioMap[url];
//     if (dio == null) {
//       await initCommonHeader();
//       dio = new Dio(getCommonOptions(header, url: url));
//       if (isDebug()) {
//         dio.interceptors.add(LogInterceptor(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: false,
//           responseBody: true,
//         ));
//       }

//       dio.transformer = FlutterTransformer();

//       dio.interceptors.add(TokenInterceptor());
//       dio.interceptors.add(RefreshTokenInterceptor());
//       dio.interceptors.add(ErrorToastInterceptor());
//       _dioMap[url] = dio;
//     }
//     return dio;
//   }

//   Future<Dio> getDioNoError({String url, Map<String, String> header}) async {
//     if (url == null) {
//       url = NetConfig.baseURL;
//     }

//     if (_noErrorDio != null) {
//       return _noErrorDio;
//     }
//     await initCommonHeader();
//     _noErrorDio = new Dio(getCommonOptions(header, url: url));
//     if (isDebug()) {
//       _noErrorDio.interceptors.add(LogInterceptor(
//         requestHeader: true,
//         requestBody: true,
//         responseHeader: false,
//         responseBody: true,
//       ));
//     }

//     _noErrorDio.transformer = FlutterTransformer();

//     _noErrorDio.interceptors.add(TokenInterceptor());
//     _noErrorDio.interceptors.add(RefreshTokenInterceptor());

//     addProxy(_noErrorDio);
//     return _noErrorDio;
//   }

//   Future<Dio> getDioEcropty(
//       {String url = C.BASE_URL, Map<String, String> header}) async {
//     Dio dioEcropty = _dioEncryptMap[url];
//     if (dioEcropty == null) {
//       await initCommonHeader();
//       dioEcropty = new Dio(getCommonOptions(header, url: url));
//       if (isDebug()) {
//         dioEcropty.interceptors.add(LogInterceptor(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: false,
//           responseBody: true,
//         ));
//       }

//       dioEcropty.transformer = FlutterTransformer();

//       dioEcropty.interceptors.add(TokenInterceptor());
//       dioEcropty.interceptors.add(EncryptInterceptor());
//       dioEcropty.interceptors.add(RefreshTokenInterceptor());
//       dioEcropty.interceptors.add(ErrorToastInterceptor());

//       _dioEncryptMap[url] = dioEcropty;

//     }
//     return dioEcropty;
//   }

//   Future<Dio> getGoogleDio(
//       {String url = C.GOOGLE_MAP_BASE_URL, Map<String, String> header}) async {
//     Dio dio = _dioMap[url];
//     if (dio == null) {
// //      await initCommonHeader();
//       dio = new Dio(getCommonOptions(null, url: url));
//       if (isDebug()) {
//         dio.interceptors.add(LogInterceptor(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: false,
//           responseBody: true,
//         ));
//       }
//       dio.transformer = FlutterTransformer();
//       _dioMap[url] = dio;
//     }
//     return dio;
//   }

//   Future<Dio> getLoadingDio({Map<String, String> header}) async {
//     if (_loadingDio == null) {
//       await initCommonHeader();
//       _loadingDio = new Dio(getCommonOptions(header));
//       if (isDebug()) {
//         _loadingDio.interceptors.add(LogInterceptor(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: false,
//           responseBody: true,
//         ));
//       }

//       _loadingDio.transformer = FlutterTransformer();

//       _loadingDio.interceptors.add(TokenInterceptor());
//       _loadingDio.interceptors.add(EncryptInterceptor());
//       _loadingDio.interceptors.add(RefreshTokenInterceptor());
//       _loadingDio.interceptors.add(LoadingInterceptor());
//       _loadingDio.interceptors.add(ErrorToastInterceptor());
//     }
//     return _loadingDio;
//   }

//   Future<Dio> createNoEncropyLoadingDio({Map<String, String> header}) async {
//     await initCommonHeader();
//     final _loadingDio = new Dio(getCommonOptions(header));
//     if (isDebug()) {
//       _loadingDio.interceptors.add(LogInterceptor(
//         requestHeader: true,
//         requestBody: true,
//         responseHeader: false,
//         responseBody: true,
//       ));
//     }

//     _loadingDio.transformer = FlutterTransformer();

//     _loadingDio.interceptors.add(LoadingInterceptor());
//     return _loadingDio;
//   }

//   Future<Dio> getLoadingEcroptyDio({Map<String, String> header}) async {
//     if (_loadingEncryptDio == null) {
//       await initCommonHeader();
//       _loadingEncryptDio = new Dio(getCommonOptions(header));
//       if (isDebug()) {
//         _loadingEncryptDio.interceptors.add(LogInterceptor(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: false,
//           responseBody: true,
//         ));
//       }

//       _loadingEncryptDio.transformer = FlutterTransformer();

//       _loadingEncryptDio.interceptors.add(TokenInterceptor());
//       _loadingEncryptDio.interceptors.add(EncryptInterceptor());
//       _loadingEncryptDio.interceptors.add(RefreshTokenInterceptor());
//       _loadingEncryptDio.interceptors.add(LoadingInterceptor());
//       _loadingEncryptDio.interceptors.add(ErrorToastInterceptor());
//     }
//     return _loadingEncryptDio;
//   }

//   Future<Dio> getDownloadDio({Map<String, String> header}) async {
//     if (_downloadDio == null) {
//       await initCommonHeader();
//       _downloadDio = new Dio(getCommonOptions(header));
//       if (isDebug()) {
//         _downloadDio.interceptors.add(LogInterceptor(
//           requestHeader: true,
//           requestBody: true,
//           responseHeader: false,
//           responseBody: true,
//         ));
//       }
//     }
//     return _downloadDio;
//   }

//   Future<Dio> getFileUploadDio({bool isNeedLoading = true}) async {
//     await initCommonHeader();
//     String time = '${DateTime.now().millisecondsSinceEpoch}';
//     String lang = headers['Lang'];
//     String auth = headers['Authorization'];
//     List<String> list = [time, lang, auth, 'taurus future NB'];
//     list.sort();
//     String combian = '';
//     for (var i in list) {
//       combian = combian + i;
//     }
//     String api = MD5Utils.generateMd5(combian);
//     final options = getCommonOptions(
//       {'Timestamp': time, 'Api': api},
//     );
//     // options.baseUrl = C.IMG_UPLOAD_BASE_URL;
//     options.contentType = 'multipart/form-data';
//     options.connectTimeout = 8000;
//     final _fileDio = new Dio(options);
//     _fileDio.interceptors.add(LogInterceptor(
//       requestHeader: true,
//       requestBody: true,
//       responseHeader: false,
//       responseBody: true,
//     ));

//     _fileDio.transformer = FlutterTransformer();
//     if (isNeedLoading) {
//       _fileDio.interceptors.add(LoadingInterceptor());
//     } else {
//       _fileDio.interceptors.add(LogInterceptor());
//     }
//     _fileDio.interceptors.add(ErrorToastInterceptor());

//     return _fileDio;
//   }

//   void changeHeader(String key, String value) {
//     if (key == 'Authorization') {
//       token = value;
//     }
//     headers[key] = value;
//     _dioMap.clear();
//     _dioEncryptMap.clear();
//     _loadingEncryptDio = null;
//     _loadingDio = null;
//     _noErrorDio = null;
//     _downloadDio = null;
//   }

//   Future initCommonHeader() async {
//     headers['Version'] = await AppInfoUtils.getAppVersionName();
//     if (Platform.isAndroid) {
//       headers['User-Agent'] = 'android';
//     } else if (Platform.isIOS) {
//       headers['User-Agent'] = 'ios';
//     }
//     headers['Device-Uuid'] = await AppInfoUtils.getId();
//     deviceUUID = headers['Device-Uuid'];
//   }
// }
