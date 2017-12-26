//
//  WPRequestModule.m
//  WhitePeony
//
//  Created by jhon.sun on 15/6/23.
//  Copyright (c) 2015年 iOSTeam. All rights reserved.
//

#import "AFNetWorkManager.h"
#import "AFHTTPSessionManager.h"

@interface AFNetWorkManager()

@property (nonatomic, strong) AFHTTPSessionManager *requestManager;
@property (nonatomic, copy) NSString *host;
@property (nonatomic, copy) NSString *path;
@property (nonatomic, strong) NSURLSessionTask *task;

@end

@implementation AFNetWorkManager

- (AFHTTPSessionManager *)shareRequestManager {
    static AFHTTPSessionManager *requestManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        requestManager = [AFHTTPSessionManager manager];
    });
    return requestManager;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.requestManager = [self shareRequestManager];
    }
    return self;
}

- (instancetype)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        self.requestManager = [self shareRequestManager];
        self.host = hostName;
        self.path = path;
        [self.requestManager setRequestSerializer:[AFHTTPRequestSerializer serializer]];
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        [self.requestManager setResponseSerializer:response];
        self.timeOut = 30;
    }
    
    return self;
}

#pragma mark - set
- (void)setTimeOut:(NSTimeInterval)timeOut {
    _timeOut = timeOut;
    self.requestManager.requestSerializer.timeoutInterval = _timeOut;
}

#pragma mark - public
- (void)getWithParams:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self getWithPath:self.path params:param successHandler:successHandler errorHandler:errorHandler];
}

- (void)getWithPath:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self getWithHost:self.host path:path params:param successHandler:successHandler errorHandler:errorHandler];
}

- (void)getWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",host, path];
    NSLog(@"get %@", urlString);
    NSLog(@"param %@", param);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    self.task = [self.requestManager GET:urlString parameters:param progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求成功：%@", responseObject);
        if (successHandler) successHandler(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求失败：%@", [error localizedDescription]);
        if (errorHandler) errorHandler(@"网络连接异常，请稍后再试");
    }];
}

- (void)postWithParams:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self postWithPath:self.path params:param successHandler:successHandler errorHandler:errorHandler];
}

- (void)postWithPath:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self postWithHost:self.host path:path params:param successHandler:successHandler errorHandler:errorHandler];
}

- (void)postWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",host, path];
    NSLog(@"post %@", urlString);
    NSLog(@"param %@", param);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
//    NSArray *keyArray = [param allKeys];
//    NSString *paramsString = @"?";
//    for (NSString *key in keyArray) {
//        NSString *paramString = [NSString stringWithFormat:@"%@=%@", key, param[key]];
//        paramsString = [paramsString stringByAppendingString:paramString];
//        NSInteger i = [keyArray indexOfObject:key];
//        if (i < keyArray.count - 1) {
//            paramsString = [paramsString stringByAppendingString:@"&"];
//        }
//    }
//    urlString = [urlString stringByAppendingString:paramsString];
//    NSLog(@"post请求get传参：%@", urlString);
    self.task = [self.requestManager POST:urlString parameters:param progress:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求成功：%@", responseObject);
        if (successHandler) successHandler(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求失败：%@", [error localizedDescription]);
        if (errorHandler) errorHandler(@"网络连接异常，请稍后再试");
    }];
}

- (void)putWithParams:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self putWithPath:self.path params:param successHandler:successHandler errorHandler:errorHandler];
}

- (void)putWithPath:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self putWithHost:self.host path:path params:param successHandler:successHandler errorHandler:errorHandler];
}

- (void)putWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",host, path];
    NSLog(@"put %@", urlString);
    NSLog(@"param %@", param);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    self.task = [self.requestManager PUT:urlString parameters:param success:^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求成功：%@", responseObject);
        if (successHandler) successHandler(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求失败：%@", [error localizedDescription]);
        if (errorHandler) errorHandler(@"网络连接异常，请稍后再试");
    }];
}

- (void)uploadFileWithParams:(NSDictionary *)param fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self uploadFileWithPath:self.path params:param fileData:fileData name:name fileName:fileName mimeType:mimeType successHandler:successHandler progressHander:progressHandler errorHandler:errorHandler];
}

- (void)uploadFileWithPath:(NSString *)path params:(NSDictionary *)param fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self uploadFileWithHost:self.host path:path params:param fileData:fileData name:name fileName:fileName mimeType:mimeType successHandler:successHandler progressHander:progressHandler errorHandler:errorHandler];
}

- (void)uploadFileWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param fileData:(NSData *)fileData name:(NSString *)name fileName:(NSString *)fileName mimeType:(NSString *)mimeType successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",host, path];
    NSLog(@"upload %@", urlString);
    NSLog(@"param %@", param);
    
    self.task = [self.requestManager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressHandler) progressHandler(uploadProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求成功：%@", responseObject);
        if (successHandler) successHandler(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求失败：%@", [error localizedDescription]);
        if (errorHandler) errorHandler(@"网络连接异常，请稍后再试");
    }];
}

- (void)uploadFileWithParams:(NSDictionary *)param fileDataDicArray:(NSArray *)fileDataDicArray successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self uploadFileWithPath:self.path params:param fileDataDicArray:fileDataDicArray successHandler:successHandler progressHander:progressHandler errorHandler:errorHandler];
}

- (void)uploadFileWithPath:(NSString *)path params:(NSDictionary *)param fileDataDicArray:(NSArray *)fileDataDicArray successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self uploadFileWithHost:self.host path:path params:param fileDataDicArray:fileDataDicArray successHandler:successHandler progressHander:progressHandler errorHandler:errorHandler];
}

- (void)uploadFileWithHost:(NSString *)host path:(NSString *)path params:(NSDictionary *)param fileDataDicArray:(NSArray *)fileDataDicArray successHandler:(SuccessHandlerBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    NSString *urlString = [NSString stringWithFormat:@"%@/%@",host, path];
    NSLog(@"upload %@", urlString);
    NSLog(@"param %@", param);
    
    self.task = [self.requestManager POST:urlString parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
        for (NSDictionary *fileDataDic in fileDataDicArray) {
            NSData *fileData = fileDataDic[WPUploadFileDataKey];
            NSString *name = fileDataDic[WPUploadNameKey];
            NSString *fileName = fileDataDic[WPUploadFileNameKey];
            NSString *mimeType = fileDataDic[WPUploadMimeTypeKey];
            [formData appendPartWithFileData:fileData name:name fileName:fileName mimeType:mimeType];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progressHandler) progressHandler(uploadProgress);
    } success:^(NSURLSessionDataTask *task, id responseObject) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求成功：%@", responseObject);
        if (successHandler) successHandler(responseObject);
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        NSLog(@"请求失败：%@", [error localizedDescription]);
        if (errorHandler) errorHandler(@"网络连接异常，请稍后再试");
    }];
}

- (void)downloadFileWithDownloadUrlString:(NSString *)downloadUrlString successHandler:(SuccessHandlerUrlBlock)successHandler progressHander:(ProgressChangeBlock)progressHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    NSLog(@"下载文件路劲：%@", downloadUrlString);
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURL *url = [NSURL URLWithString:[downloadUrlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    self.task = [self.requestManager downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        if (progressHandler) progressHandler(downloadProgress);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //保存的文件路径
        NSString *fullPath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:fullPath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        if (error) {
            NSLog(@"下载失败：%@", [error localizedDescription]);
            if (errorHandler) errorHandler([error localizedDescription]);
        } else {
            NSLog(@"文件下载保存路径：%@", filePath);
            if (successHandler) successHandler(filePath);
        }
    }];
    [self.task resume];
}

- (void)cancelRequest {
    [self.task cancel];
}
@end
