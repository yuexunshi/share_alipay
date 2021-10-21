import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:share_alipay/share_alipay.dart';

void main() {
  const MethodChannel channel = MethodChannel('share_alipay');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await ShareAlipay.isAppInstalled, true);
  });
}
