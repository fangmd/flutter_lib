# p_rpc

TCP + MsgPack

# Usage

```Dart
// 初始化 Splash 页面阻塞初始化
await RPCHttp.instance.init('172.16.20.89', 8880, 'assets/public.pem');

// 发起请求
Map<String, dynamic> data = HashMap();
data['time'] = 121212121;
data['timeStr'] = '121212121';

RPCHttp.instance.send('qrcode_proxy_add_qrcode', data, (ret) {
    print(ret);
});
```