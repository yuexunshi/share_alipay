#import "ShareAlipayPlugin.h"
#import "APOpenAPI.h"

@interface ShareAlipayPlugin ()

@end

@implementation ShareAlipayPlugin


+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    FlutterMethodChannel *channel = [FlutterMethodChannel methodChannelWithName:@"share_alipay" binaryMessenger:registrar.messenger];
    ShareAlipayPlugin *plugin = [[ShareAlipayPlugin alloc] init];
    [registrar addMethodCallDelegate:plugin channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result {
    NSLog(@"share ap plugin call:%@ arguments:%@",call.method,call.arguments);
    if ([call.method isEqualToString:@"registerApi"]) {
        [self registerApi:call.arguments result:result];
    }else if ([call.method isEqualToString:@"shareText"]) {
        [self shareText:call.arguments result:result];
    }else if ([call.method isEqualToString:@"shareImageUrl"]) {
        [self shareImageUrl:call.arguments result:result];
    }else if ([call.method isEqualToString:@"shareImageData"]) {
        [self shareImageData:call.arguments result:result];
    }else if ([call.method isEqualToString:@"shareWebData"]) {
        [self shareWebData:call.arguments result:result];
    }else if ([call.method isEqualToString:@"shareWebUrl"]) {
        [self shareWebUrl:call.arguments result:result];
    }else if ([call.method isEqualToString:@"isAppInstalled"]) {
        [self isAppInstalled:call.arguments result:result];
    }
}

- (void)registerApi:(id)arguments result:(FlutterResult)result {
    NSDictionary *info = arguments;
    BOOL success = [APOpenAPI registerApp:info[@"appId"] withDescription:info[@"appDescription"]];
    result(@(success));
}

- (void)shareText:(id)arguments result:(FlutterResult)result {

    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    //  创建文本类型的消息对象
    APShareTextObject *textObj = [[APShareTextObject alloc] init];
        textObj.text = arguments[@"text"];
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = textObj;
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至当前版本，分享入口已合并，scene参数并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题，建议还是照常传入。
    request.scene = 0;
    //  发送请求
    BOOL succsess = [APOpenAPI sendReq:request];
    result(@(succsess));

    if (!succsess) {
        //失败处理
        NSLog(@"发送失败");
    }
}

- (void)shareImageUrl:(id)arguments result:(FlutterResult)result {

    //  创建消息载体 APMediaMessage 对象
       APMediaMessage *message = [[APMediaMessage alloc] init];
       //  创建图片类型的消息对象
       APShareImageObject *imgObj = [[APShareImageObject alloc] init];

    imgObj.imageUrl = arguments[@"imageUrl"];

    //  回填 APMediaMessage 的消息对象
       message.mediaObject = imgObj;
       //  创建发送请求对象
       APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
       //  填充消息载体对象
       request.message = message;
       //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至当前版本，分享入口已合并，scene参数并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题，建议还是照常传入。
       request.scene = 0;
       //  发送请求
       BOOL succsess = [APOpenAPI sendReq:request];
    result(@(succsess));

       if (!succsess) {
           //失败处理
           NSLog(@"发送失败");
       }
}

- (void)shareImageData:(id)arguments result:(FlutterResult)result {
    //  创建消息载体 APMediaMessage 对象
       APMediaMessage *message = [[APMediaMessage alloc] init];
       //  创建图片类型的消息对象
       APShareImageObject *imgObj = [[APShareImageObject alloc] init];

        FlutterStandardTypedData *data = arguments[@"imageData"];

       //图片也可使用imageData字段分享本地UIImage类型图片，必须填充有效的image NSData类型数据，否则无法正常分享
    imgObj.imageData = data.data;
    //  回填 APMediaMessage 的消息对象
       message.mediaObject = imgObj;
       //  创建发送请求对象
       APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
       //  填充消息载体对象
       request.message = message;
       //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至当前版本，分享入口已合并，scene参数并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题，建议还是照常传入。
       request.scene = 0;
       //  发送请求
       BOOL succsess = [APOpenAPI sendReq:request];
    result(@(succsess));

       if (!succsess) {
           //失败处理
           NSLog(@"发送失败");
       }
}

- (void)shareWebData:(id)arguments result:(FlutterResult)result {
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    message.title = arguments[@"title"];
    message.desc = arguments[@"desc"];
    FlutterStandardTypedData *data = arguments[@"thumbData"];

    //缩略图也可使用thumbData字段分享本地UIImage类型图片，必须填充有效的image NSData类型数据，否则无法正常分享
    message.thumbData = data.data;
    //  创建网页类型的消息对象
    APShareWebObject *webObj = [[APShareWebObject alloc] init];
    webObj.wepageUrl =arguments[@"webpageUrl"];
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = webObj;
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至当前版本，分享入口已合并，scene参数并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题，建议还是照常传入。
    request.scene = 1;
    //  发送请求
    BOOL succsess = [APOpenAPI sendReq:request];
    if (!succsess) {
        //失败处理
        NSLog(@"发送失败");
    }
}

- (void)shareWebUrl:(id)arguments result:(FlutterResult)result {
    //  创建消息载体 APMediaMessage 对象
    APMediaMessage *message = [[APMediaMessage alloc] init];
    message.title = arguments[@"title"];
    message.desc = arguments[@"desc"];
    message.thumbUrl = arguments[@"thumbUrl"];
    //缩略图也可使用thumbData字段分享本地UIImage类型图片，必须填充有效的image NSData类型数据，否则无法正常分享
    //例如 message.thumbData = UIImagePNGRepresentation(Your UIImage Obj);
    //  创建网页类型的消息对象
    APShareWebObject *webObj = [[APShareWebObject alloc] init];
    webObj.wepageUrl =arguments[@"webpageUrl"];
    //  回填 APMediaMessage 的消息对象
    message.mediaObject = webObj;
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    //  填充消息载体对象
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至当前版本，分享入口已合并，scene参数并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题，建议还是照常传入。
    request.scene = 1;
    //  发送请求
    BOOL succsess = [APOpenAPI sendReq:request];
    if (!succsess) {
        //失败处理
        NSLog(@"发送失败");
    }
}

- (void)isAppInstalled:(id)arguments result:(FlutterResult)result {
    result(@([APOpenAPI isAPAppInstalled]));
}


@end


