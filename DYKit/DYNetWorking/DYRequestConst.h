
//
//  DYRequestConst.h
//  DYNetWorkingDemo
//
//  Created by Dainty on 2019/3/29.
//  Copyright © 2019年 DAINTY. All rights reserved.
//

#ifndef DYRequestConst_h
#define DYRequestConst_h
@class DYRequestConfig;
typedef NS_ENUM(NSInteger, RequestType) {
    /**重新请求，不读去缓存,*/
    DYReuestTypeRefresh,
    /**优先缓存，无缓存，重新请求*/
    DYReuestTypeCache,
    /**加载更多，不读取缓存*/
    DYReuestTypeRefreshMore,
    /**加载更多，有缓存，读取缓存，无缓存重新请求*/
    DYReuestTypeReCacheMore,
    /**详情页面：有缓存，读取缓存，无缓存，重新请求*/
    DYReuestTypeDetailCache,
    /**自定义项： 有缓存,读取缓存--无缓存，重新请求*/
    DYReuestTypeCustomCache
};


/**
 HTTP请求类型
 */
typedef NS_ENUM(NSInteger,MethodType){
    DYMethodTypeGET,
    
    DYMethodTypePOST,
    
    DYMethodTypeUpload,
    
    DYMethodTypeDownLoad,
    
    DYMethodTypePUT,

    DYMethodTypePATCH,
    
    DYMethodTypeDELETE,
   /** 可以在config里面配置使用 DYMethodTypeUploadImage 也可以直接调用 requestUploadImageWithConfig方法*/
    DYMethodTypeUploadImage
    
} ;

/**
 请求参数的格式.默认是HTTP
 */
typedef NS_ENUM(NSUInteger, RequestSerializerType) {
   /** 设置请求参数为二进制格式*/
    DYHTTPRequestSerializer,
     /** 设置请求参数为JSON格式*/
    DYJSONRequestSerializer
};



/**
 返回响应数据的格式.默认是JSON
 */
typedef NS_ENUM(NSUInteger, ResponseSerializerType) {
    /** 设置响应数据为JSON格式*/
    DYJSONResponseSerializer,
    /** 设置响应数据为二进制格式*/
    DYHTTPResponseSerializer
};



/**
 图片压缩策略 默认使用DYUploadCompressWeiChat；
 */
typedef NS_ENUM(NSUInteger, DYUploadCompressType) {
    
    DYUploadCompressWeiChat = 40000,        //  仿照微信压缩      （仿照微信的压缩比例）
    DYUploadCompressEqualProportion,        //  图像等比例缩小压缩 （宽度参照 1242 进行等比例缩小）
    DYUploadCompressTwoPoints               //  采用二分法压缩    （最接近压缩比例）
};




/**请求配置的block*/
typedef void(^requestConfig)(DYRequestConfig *config);
/**请求成功的block*/
typedef void(^requestSuccess)(id responseObject,RequestType type ,BOOL isCache);
/**请求失败的Block*/
typedef void (^requestFailure)(NSError *error);
/**请求进度block*/
typedef void(^progressBlock)(NSProgress *progress);
/**请求取消的block*/
typedef void(^cancelBlock)(BOOL result ,NSString *urlString);


#endif /* DYRequestConst_h */
