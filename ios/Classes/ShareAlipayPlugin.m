#import "ShareAlipayPlugin.h"
#import "APOpenAPI.h"

@interface ShareAlipayPlugin ()

@end

@implementation ShareAlipayPlugin

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static ShareAlipayPlugin *instance = nil;
    dispatch_once(&onceToken, ^{
        instance = [[super allocWithZone:NULL] init];
    });
    return instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    return [self sharedInstance];
}

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
    APShareTextObject *textObj = [[APShareTextObject alloc] init];
    textObj.text = arguments[@"text"];
    [self shareWithInfo:arguments mediaObject:textObj result:result];
}

- (void)shareImageUrl:(id)arguments result:(FlutterResult)result {
    APShareImageObject *imgObj = [[APShareImageObject alloc] init];
    imgObj.imageUrl = arguments[@"imageUrl"];
    [self shareWithInfo:arguments mediaObject:imgObj result:result];
}

- (void)shareImageData:(id)arguments result:(FlutterResult)result {
    APShareImageObject *imgObj = [[APShareImageObject alloc] init];
    FlutterStandardTypedData *data = arguments[@"imageData"];
    imgObj.imageData = data.data;
    [self shareWithInfo:arguments mediaObject:imgObj result:result];
}

- (void)shareWebData:(id)arguments result:(FlutterResult)result {
    APShareWebObject *webObj = [[APShareWebObject alloc] init];
    webObj.wepageUrl = arguments[@"wepageUrl"];
    [self shareWithInfo:arguments mediaObject:webObj result:result];
}

- (void)shareWebUrl:(id)arguments result:(FlutterResult)result {
    APShareWebObject *webObj = [[APShareWebObject alloc] init];
    webObj.wepageUrl = arguments[@"wepageUrl"];
    [self shareWithInfo:arguments mediaObject:webObj result:result];
}

- (void)isAppInstalled:(id)arguments result:(FlutterResult)result {
    result(@([APOpenAPI isAPAppInstalled]));
}


#pragma private
- (void)shareWithInfo:(NSDictionary *)info mediaObject:(id)mediaObject result:(FlutterResult)result {
    APMediaMessage *message = [[APMediaMessage alloc] init];
    message.title = info[@"title"];
    message.desc = info[@"desc"];
    message.thumbUrl = info[@"thumbUrl"];
    message.mediaObject = mediaObject;
    
    FlutterStandardTypedData *data = info[@"thumbData"];
    message.thumbData = data.data;
 
    //  创建发送请求对象
    APSendMessageToAPReq *request = [[APSendMessageToAPReq alloc] init];
    request.message = message;
    //  分享场景，0为分享到好友，1为分享到生活圈；支付宝9.9.5版本至当前版本，分享入口已合并，scene参数并没有被使用，用户会在跳转进支付宝后选择分享场景（好友、动态、圈子等），但为保证老版本上无问题，建议还是照常传入。
    request.scene = (APScene)[info[@"scene"] integerValue];
    //  发送请求
    BOOL succsess = [APOpenAPI sendReq:request];
    result(@(succsess));
    
    if (!succsess) {
        //失败处理
        NSLog(@"发送失败");
    }
}

@end


