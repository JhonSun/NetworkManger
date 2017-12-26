//
//  MKNetWorkManager.h
//  SZComprehensiveExercise
//
//  Created by drision on 16/6/24.
//  Copyright © 2016年 drision. All rights reserved.
//


#define hostNameKey @"hostName"

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>

typedef void (^SuccessHandlerBlock)(NSDictionary *);
typedef void (^ErrorHandlerBlock)(NSError *);
typedef void (^progressChangeBlock)(CGFloat *);

@interface MKNetWorkManager : NSObject

@property (nonatomic, copy) NSDictionary *headers;

- (instancetype)initWithPath:(NSString *)path;

/* get请求
 * parms 请求参数
 * successHandler 请求成功回调
 * errorHandler 请求错误回调
 */
- (void)getWithParams:(NSDictionary *)params successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/* post请求
 * parms 请求参数
 * successHandler 请求成功回调
 * errorHandler 请求错误回调
 */
- (void)postWithParams:(NSDictionary *)params successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/* 下载文件
 * remoteUrlString 下载路径
 * progressChangeHanler 下载进度
 * successHandler 请求成功回调
 * errorHandler 请求错误回调
 */
- (void)downloadFileFrom:(NSString *)remoteUrlString to:(NSString *)filePath downloadProgress:(progressChangeBlock)progressChangeHanler successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;

/* 上传文件
 * fileData 文件二级制数据
 * parms 请求参数
 * filename 文件名
 * mimeType 文件类型
 * progressChangeHanler 上传进度
 * successHandler 请求成功回调
 * errorHandler 请求错误回调
 */
- (void)uploadFileFromFileData:(NSData *)fileData params:(NSDictionary *)params filename:(NSString *)filename mimeType:(NSString *)fileType downloadPrecess:(progressChangeBlock)progressChangeHanler successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler;
@end
