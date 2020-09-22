import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:screen_adaptation/screen_extension.dart';
import 'package:p_image_loader/p_image_loader.dart';

import 'js_manager.dart';
import 'webview_utils.dart';

class WebViewPageArg {
  final String webUrl;
  final String title;

  WebViewPageArg(this.webUrl, {this.title});
}

/// 网页游览器 官方插件
class WebViewPage extends StatefulWidget {
  WebViewPage({Key key}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  String _title;
  String _url;

  bool onceFlag = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  StreamSubscription<String> _onUrlChanged;

  // share
  bool showShareIc = false;
  Map shareData;
  String shareTitle;
  // share end

  @override
  void dispose() {
    _onUrlChanged?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (onceFlag) {
      onceFlag = false;
      WebViewPageArg info =
          ModalRoute.of(context).settings.arguments as WebViewPageArg;
      _title = info.title;
      _url = info.webUrl;
      _url = WebViewUtils.dealUrl(_url);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Color(0xffffffff),
        elevation: 0.0,
        leading: IconButton(
          onPressed: () {
            Navigator.maybePop(context);
          },
          icon: Image.asset('assets/common/ic_arrow_left.svg',
              width: 30.dp, height: 30.dp),
        ),
        title: Text(
          _title ?? '',
          style: TextStyle(
            color: Color(0xFF6D3EFF),
            fontSize: 34.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          if (showShareIc)
            LocalImg(
              "assets/common/ic_share_white.png",
              width: 40.dp,
              height: 40.dp,
              padding: EdgeInsets.only(right: 32.dp),
              onTap: () {
                showShareDialog();
              },
            ),
        ],
        brightness: Brightness.light,
      ),
      body: Builder(builder: (BuildContext context) {
        return WebView(
          initialUrl: _url,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _controller.complete(webViewController);
          },
          // ignore: prefer_collection_literals
          javascriptChannels:
              JSManager.getJSChannel(context, addShare: addShare),
          navigationDelegate: (NavigationRequest request) {
            // if (request.url.startsWith('https://www.youtube.com/')) {
            //   print('blocking navigation to $request}');
            //   return NavigationDecision.prevent;
            // }
            // print('allowing navigation to $request');
            return NavigationDecision.navigate;
          },
          onPageStarted: (String url) {
            // Logger.d(tag: Tag.WEB, msg: 'start load: $url');
            setState(() {
              showShareIc = false;
            });
          },
          onPageFinished: (String url) {
            print('Page finished loading: $url');
          },
          gestureNavigationEnabled: true,
        );
      }),
    );
  }

  showShareDialog() {}

  addShare(String title, dynamic data) {
    setState(() {
      showShareIc = true;
    });
    shareTitle = title;
    shareData = data;
  }
}
