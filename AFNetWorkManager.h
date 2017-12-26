//
//  WPRequestModule.h
//  WhitePeony
//
//  Created by jhon.sun on 15/6/23.
//  Copyright (c) 2015年 iOSTeam. All rights reserved.
//
#define WPUploadFileDataKey @"fileData"
#define WPUploadNameKey @"name"
#define WPUploadFileNameKey @"fileName"
#define WPUploadMimeTypeKey @"mimeType"

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import "NetWorkConfiguration.h"

typedef void (^SuccessHandlerBlock)(NSDictionary *resultDic);
typedef void (^SuccessHandlerArrayBlcok)(NSArray *resultArray);
typedef void (^SuccessHandlerStringBlcok)(NSString *reslutString);
typedef void (^SuccessHandlerUrlBlock)(NSURL *filePath);
typedef void (^SuccessHandlerIdBlcok)(id object);
typedef void (^ErrorHandlerBlock)(NSString *errorString);
typedef void (^ProgressChangeBlock)(NSProgress *progress);

@interface AFNetWorkManager : NSObject

@property (nonatomic, assign) NSTimeInterval timeOut;//请求超时时间,默认是30s

- (instancetype)initWithPath:(NSString *)path;

/**
 *  get 请求
 *
 *  @param host           主机地址
 *  @param path           请求路径
 *  @param param          请求参数
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
- (void)getWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  get 请求, 使用默认主机
 *
 *  @param path           请求路径
 *  @param param          请求参数
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
-(void)getWithPath:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;


/**
 get请求, 默认主机，默认路径

 @param param 参数
 @param successHandler 请求成功回调
 @param errorHandler 请求失败回调
 */
- (void)getWithParams:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  post 请求
 *
 *  @param host           主机地址
 *  @param path           请求路径
 *  @param param          请求参数
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
- (void)postWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  post 请求, 使用默认主机
 *
 *  @param path           请求路径
 *  @param param          请求参数
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
- (void)postWithPath:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 post请求
 
 @param param 参数
 @param successHandler 请求成功回调
 @param errorHandler 请求失败回调
 */
- (void)postWithParams:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  put 请求
 *
 *  @param host           主机地址
 *  @param path           请求路径
 *  @param param          请求参数
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
-(void)putWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  put 请求, 使用默认主机
 *
 *  @param path           请求路径
 *  @param param          请求参数
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
- (void)putWithPath:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 put请求
 
 @param param 参数
 @param successHandler 请求成功回调
 @param errorHandler 请求失败回调
 */
- (void)putWithParams:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;


/**
 *  上传文件
 *
 *  @param param          请求参数
 *  @param fileData       文件数据
 *  @param fileName       文件名
 *  @param mimeType       文件类型
 *  @param successHandler  请求成功回调方法
 *  @param errorHandler    请求失败回调方法
 */
- (void)uploadFileWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  上传文件，使用默认主机
 *
 *  @param param          请求参数
 *  @param fileData       文件数据
 *  @param fileName       文件名
 *  @param mimeType       文件类型
 *  @param successHandler  请求成功回调方法
 *  @param errorHandler    请求失败回调方法
 */
- (void)uploadFileWithPath:(NSString *)path params:(NSDictionary *)param fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  上传文件，使用默认主机,默认路径
 *
 *  @param param          请求参数
 *  @param fileData       文件数据
 *  @param fileName       文件名
 *  @param mimeType       文件类型
 *  @param successHandler  请求成功回调方法
 *  @param errorHandler    请求失败回调方法
 */
- (void)uploadFileWithParams:(NSDictionary *)param fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  多文件上传
 *
 *  @param host           主机地址
 *  @param path           请求路径
 *  @param param          请求参数
 *  @param fileDataDicArray    文件数据字典数组
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
- (void)uploadFileWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param fileDataDicArray:(NSArray *)fileDataDicArray successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  多文件上传，使用默认主机
 *
 *  @param path           请求路径
 *  @param param          请求参数
 *  @param fileDataDicArray    文件数据字典数组
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
- (void)uploadFileWithPath:(NSString *)path params:(NSDictionary *)param fileDataDicArray:(NSArray *)fileDataDicArray successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  多文件上传，使用默认主机，默认路径
 *
 *  @param param          请求参数
 *  @param fileDataDicArray    文件数据字典数组
 *  @param successHandler 请求成功回调
 *  @param errorHandler   请求失败回调
 */
- (void)uploadFileWithParams:(NSDictionary *)param fileDataDicArray:(NSArray *)fileDataDicArray successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 文件下载

 @param downloadUrlString 下载路径
 @param successHandler 成功回调
 @param progressHandler 进度回调
 @param errorHandler 失败回调
 */
- (void)downloadFileWithDownloadUrlString:(NSString *)downloadUrlString successHandler:(SuccessHandlerUrlBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/**
 *  取消请求
 */
- (void)cancelRequest;

@end
