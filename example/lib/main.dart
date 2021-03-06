import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:share_alipay/share_alipay.dart';
// import 'package:share_plus/share_plus.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _result = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _registerApi() async {
    try {
      _result = await ShareAlipay.registerApi("2021002188675468") ?? false;
      debugPrint('_MyAppState:_registerApi: ');
    } on PlatformException {
      _result = false;
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _sharePlusText() async {
    try {
      // await Share.share("text");
      debugPrint('_MyAppState:_shareText: ');
    } on PlatformException {
      _result = false;
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _isAppInstalled() async {
    try {
      _result = await ShareAlipay.isAppInstalled ?? false;
      debugPrint('_MyAppState:_isAppInstalled: ');
    } on PlatformException {
      _result = false;
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _shareText() async {
    try {
      _result = await ShareAlipay.shareText("oppenId") ?? false;
      debugPrint('_MyAppState:_shareText: ');
    } on PlatformException {
      _result = false;
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _shareImageData() async {
    try {
      var byteData = await rootBundle.load("assets/images/share.png");
      var asUint8List = byteData.buffer.asUint8List();
      _result = await ShareAlipay.shareImageData(asUint8List) ?? false;
      debugPrint('_MyAppState:_shareImageData: ');
    } on PlatformException {
      _result = false;
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _shareImageUrl() async {
    try {
      _result = await ShareAlipay.shareImageUrl(
            'http://img.jj20.com/up/allimg/1114/060421091316/210604091316-2-1200.jpg',
          ) ??
          false;
      debugPrint('_MyAppState:_shareImageUrl: ');
    } on PlatformException {
      _result = false;
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _shareWebWIthImgData() async {
    try {
      var byteData = await rootBundle.load("assets/images/share.png");
      var asUint8List = byteData.buffer.asUint8List();
      _result = await ShareAlipay.shareWebWithImgData(
              title: '??????',
              desc: '?????????',
              webpageUrl: "www.baidu.com",
              thumbData: asUint8List) ??
          false;
      debugPrint('_MyAppState:_shareWebWIthImgData: ');
    } on PlatformException {
      _result = false;
    }

    if (!mounted) return;
    setState(() {});
  }

  Future<void> _shareWebWithImgUrl() async {
    try {
      _result = await ShareAlipay.shareWebWithImgUrl(
              title: '??????',
              desc: '?????????',
              webpageUrl: "www.baidu.com",
              thumbUrl:
                  'https://img2.woyaogexing.com/2021/10/04/233e3a6cf733477c9adcfc1fb66de760!400x400.jpeg') ??
          false;
      debugPrint('_MyAppState:_shareWebWithImgUrl: ');
    } on PlatformException {
      _result = false;
    }

    if (!mounted) return;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Column(
          children: <Widget>[
            Text('???????????????$_result'),
            // TextButton(onPressed: _sharePlusText, child: const Text('????????????')),
            TextButton(onPressed: _registerApi, child: const Text('??????')),
            TextButton(onPressed: _isAppInstalled, child: const Text('????????????')),
            TextButton(onPressed: _shareText, child: const Text('????????????')),
            TextButton(onPressed: _shareImageUrl, child: const Text('??????????????????')),
            TextButton(
                onPressed: _shareImageData, child: const Text('????????????data')),
            TextButton(
                onPressed: _shareWebWithImgUrl, child: const Text('??????web??????')),
            TextButton(
                onPressed: _shareWebWIthImgData,
                child: const Text('??????webdata')),
          ],
        ),
      ),
    );
  }
}
