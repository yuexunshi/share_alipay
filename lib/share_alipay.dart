import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class ShareAlipay {
  static const MethodChannel _channel = MethodChannel('share_alipay');

  // register ApOpen
  static Future<bool?> registerApi(String oppenId) async {
    final bool? result = await _channel.invokeMethod('registerApi', {'appId':oppenId});
    return result;
  }

  static Future<bool?> get isAppInstalled async {
    final bool? result = await _channel.invokeMethod('isAppInstalled');
    return result;
  }

  // ShareText to AliPay
  static Future<bool?> shareText(String text) async {
    final Map<String, dynamic> params = <String, dynamic>{
      'text': text,
    };
    final bool? result = await _channel.invokeMethod('shareText', params);
    return result;
  }

// Share Image
  static Future<bool?> shareImageData(Uint8List data) async {
    return await _channel.invokeMethod("shareImageData", {"imageData": data});
  }

  static Future<bool?> shareImageUrl(String url) async {
    return await _channel.invokeMethod("shareImageUrl", {"imageUrl": url});
  }

// Share Web with imageData
  static Future<bool?> shareWebWithImgData(
      {String title = '',
      String desc = '',
      required String webpageUrl,
      required Uint8List imageData}) async {
    return await _channel.invokeMethod("shareWebData", {
      "title": title,
      "desc": desc,
      "webpageUrl": webpageUrl,
      "thumbData": imageData
    });
  }

// Share Web with imageUrl
  static Future<bool?> shareWebWithImgUrl(
      {String title = '',
      String desc = '',
      required String webpageUrl,
      required String imageUrl}) async {
    return await _channel.invokeMethod("shareWebUrl", {
      "title": title,
      "desc": desc,
      "webpageUrl": webpageUrl,
      "imageUrl": imageUrl
    });
  }

}
