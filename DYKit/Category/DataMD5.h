//
//  DataMD5.h
//  DaintyKit
//
//  Created by Dainty on 17/2/21.
//  Copyright © 2017年 Edward. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - 需要配置的参数


// 开放平台登录https://open.weixin.qq.com的开发者中心获取APPID
#define WX_APPID @"wxd21d890******"
// 开放平台登录https://open.weixin.qq.com的开发者中心获取AppSecret。
#define WX_APPSecret @"fc32dfae9******edc5eb5f77dddd4ea5"
// 微信支付商户号
#define MCH_ID  @"1353******02"
// 安全校验码（MD5）密钥，商户平台登录账户和密码登录http://pay.weixin.qq.com
// 平台设置的“API密钥”，为了安全，请设置为以数字和字母组成的32字符串。
#define WX_PartnerKey @"B6246A6D******30EEA0F78D3B461"

#pragma mark - 统一下单请求参数键值

// 应用id
#define WXAPPID @"appid"
// 商户号
#define WXMCHID @"mch_id"
// 随机字符串
#define WXNONCESTR @"nonce_str"
// 签名
#define WXSIGN @"sign"
// 商品描述
#define WXBODY @"body"
// 商户订单号
#define WXOUTTRADENO @"out_trade_no"
// 总金额
#define WXTOTALFEE @"total_fee"
// 终端IP
#define WXEQUIPMENTIP @"spbill_create_ip"
// 通知地址
#define WXNOTIFYURL @"notify_url"
// 交易类型
#define WXTRADETYPE @"trade_type"
// 预支付交易会话
#define WXPREPAYID @"prepay_id"



#pragma mark - 微信下单接口

// 微信统一下单接口连接
#define WXUNIFIEDORDERURL @"https://api.mch.weixin.qq.com/pay/unifiedorder"

@interface DataMD5 : NSObject



@property (nonatomic,strong) NSMutableDictionary *dic;

- (instancetype)initWithAppid:(NSString *)appid_key
                       mch_id:(NSString *)mch_id_key
                    nonce_str:(NSString *)noce_str_key
                   partner_id:(NSString *)partner_id
                         body:(NSString *)body_key
                out_trade_no :(NSString *)out_trade_no_key
                    total_fee:(NSString *)total_fee_key
             spbill_create_ip:(NSString *)spbill_create_ip_key
                   notify_url:(NSString *)notify_url_key
                   trade_type:(NSString *)trade_type_key;

///创建发起支付时的SIGN签名(二次签名)
- (NSString *)createMD5SingForPay:(NSString *)appid_key partnerid:(NSString *)partnerid_key prepayid:(NSString *)prepayid_key package:(NSString *)package_key noncestr:(NSString *)noncestr_key timestamp:(UInt32)timestamp_key;
/*MD5加密，传入需要加密的字符串，不可逆
 *@param str 需要加密的字符串
 *@return 加密后的字符串
 */
- (NSString*)md5:(NSString *)str;

@end
