//
//  APOpenAPIObjectX.h
//  APShareService
//
//  Created by 佳佑 on 15/6/3.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APOpenAPIObject.h"

//  股票
@interface APShareStockObject : NSObject
@property (nonatomic, strong) NSString *stockName;  //  股票名称
@property (nonatomic, strong) NSString *stockCode;  //  股票代码
@property (nonatomic, strong) NSString *stockPrice; //  股票价格
@property (nonatomic, strong) NSString *stockPriceChange;   //  盈亏
@property (nonatomic, strong) NSString *stockPriceChangeRatio;  //  盈亏率
//0 默认（停牌、退市、无数据） 灰色
//1 涨 红色
//2 跌 绿色
@property (nonatomic, assign) int increaseState;
@property (nonatomic, assign) NSTimeInterval time;  //  毫秒
@property (nonatomic, strong) NSString *wepageUrl;  //  点击跳转link
@property (nonatomic, strong) NSString *extend; //JSON串，字典，作为扩展参数使用
@end;

//  基金
@interface APShareFundObject : NSObject
@property (nonatomic, strong) NSString *fundName;   //  基金名称
@property (nonatomic, strong) NSString *fundCode;   //  基金代码
@property (nonatomic, strong) NSString *fundPrice;  //  基金价格
@property (nonatomic, strong) NSString *fundDailyDesc; //日涨幅文字
@property (nonatomic, strong) NSString *fundWeeklyDesc;    //周涨幅文字
@property (nonatomic, strong) NSString *fundDailyRatio; //日涨幅数字
@property (nonatomic, strong) NSString *fundWeeklyRatio;    //周涨幅数字
@property (nonatomic, assign) NSTimeInterval time;  //  毫秒
@property (nonatomic, strong) NSString *wepageUrl;  //  点击跳转link
//0 通用色
//1 涨 红色
//2 跌 绿色
//3 停 灰色
@property (nonatomic, assign) int fundPriceColor;   //  基金价格颜色
@property (nonatomic, assign) int fundDailyDescColor;   //  基金日涨幅文字颜色
@property (nonatomic, assign) int fundWeeklyDescColor;  //  基金周涨幅文字颜色
@property (nonatomic, assign) int fundDailyRatioColor;  //  基金日涨幅数字颜色
@property (nonatomic, assign) int fundWeeklyRatioColor; //  基金周涨幅数字颜色
@property (nonatomic, assign) int timeColor;    //  日期颜色
@property (nonatomic, strong) NSString *labelText;  //基金标签
//0 蓝色
//1 通用色
@property (nonatomic, assign) int labelColor;   //  标签背景色
@property (nonatomic, strong) NSString *extend; //JSON串，字典，作为扩展参数使用
@end;

//  淘宝商品
@interface APShareTBGoodsObject : NSObject
@property (nonatomic, strong) NSString *webpageUrl; //  点击跳转link
@property (nonatomic, strong) NSString *remarkDesc; //  当价格为空时，替换的文本
@property (nonatomic, assign) int descColor;    //  价格或描述的颜色
@property (nonatomic, assign) int priceColor;   //  现价的颜色
@property (nonatomic, strong) NSString *labelText1; //  商品标签1文字
@property (nonatomic, assign) int labelColor1;  //  商品标签1文字颜色
@property (nonatomic, strong) NSString *labelText2; //  商品标签2文字
@property (nonatomic, assign) int labelColor2;  //  商品标签2文字颜色
@property (nonatomic, strong) NSString *event;  //  商品活动信息（皮肤相关）
@property (nonatomic, strong) NSString *extend; //JSON串，字典，作为扩展参数使用
@end

//  拼团商品
@interface APSharePinGoodsObject : NSObject
@property (nonatomic, strong) NSString *webPageUrl; //  点击跳转link  
@property (nonatomic, strong) NSString *priceFormatter; //  拼团价格格式化文本
@property (nonatomic, strong) NSString *price; //  拼团价格
@property (nonatomic, strong) NSString *desc; //  拼团描述
@property (nonatomic, strong) NSString *originPrice; // 拼团原价描述
@property (nonatomic, strong) NSString *extend; //JSON串，字典，作为扩展参数使用
@end

//  AR
@interface APShareARObject : NSObject
@property (nonatomic, strong) NSString *appResourceUrl; // 应用资源id
@property (nonatomic, strong) NSString *extend; //JSON串，字典，作为扩展参数使用
@end

//  GIF
@interface APShareGIFObject : NSObject
//  缩略图数据，imageData是UIImage类型，imageUrl是远端互联网url图片地址类型，二者只有一个生效，UIImage优先级高于url
@property (nonatomic, strong) NSData *imageData;
@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, strong) NSString *emotionId; // gifMD5,表情id
@property (nonatomic, strong) NSString *firstFrameId; // 首帧图cloudId
@property (nonatomic, assign) long long gifSize;        // gif数据大小
@property (nonatomic, strong) NSString *extend; //JSON串，字典，作为扩展参数使用
@end


//  商户
@interface APShareStoreObject : NSObject
@property (nonatomic, strong) NSString *storeName;  //  商家名称
//弹框显示规则，有星级:第一行显示星级、第二行显示人均价格、没有人均价格则显示地址;没有星级:第一行显示人均价格，第二行显示地址
@property (nonatomic, strong) NSString *storeScore;   //  商家评分几颗星，取floatValue，最大5 支持.5
@property (nonatomic, strong) NSString *storePrice;   //  商家人均价格
@property (nonatomic, strong) NSString *storeAddress;   //  商家地址
@property (nonatomic, strong) NSString *wepageUrl;    //  点击跳转link
@property (nonatomic, strong) NSString *extend; //JSON串，字典，作为扩展参数使用
@end;
