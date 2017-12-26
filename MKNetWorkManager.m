//
//  MKNetWorkManager.m
//  SZComprehensiveExercise
//
//  Created by drision on 16/6/24.
//  Copyright © 2016年 drision. All rights reserved.
//

#import "MKNetWorkManager.h"
#import"MKNetworkKit.h"

@interface MKNetWorkManager ()

@property (nonatomic, copy) NSString *path;

@property (nonatomic, strong) MKNetworkEngine *engine;
@property (nonatomic, strong) MKNetworkOperation *operation;

@end

@implementation MKNetWorkManager

- (instancetype)initWithPath:(NSString *)path {
    self = [super init];
    if (self) {
        self.path = path;
        self.engine = [[MKNetworkEngine alloc] initWithHostName:USERINFOFIND(hostNameKey)];
    }
    return self;
}

#pragma mark - set
- (void)setHeaders:(NSDictionary *)headers {
    _headers = headers;
    self.engine = [[MKNetworkEngine alloc] initWithHostName:USERINFOFIND(hostNameKey) customHeaderFields:_headers];
}

#pragma mark - private
- (void)requestCompletionWithSuccessHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    [self.operation addCompletionHandler:^(MKNetworkOperation *completedOperation) {
        NSString *jsonString = completedOperation.responseJSON;
        if (jsonString) {
            NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
            
            NSError *err;
            
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                 
                                                                options:NSJSONReadingMutableContainers
                                 
                                                                  error:&err];
            if (successHandler) successHandler(dic);
        } else {
            NSLog(@"返回是空的");
        }
    } errorHandler:^(MKNetworkOperation *completedOperation, NSError *error) {
        NSLog(@"请求失败，错误描述:%@", [error localizedDescription]);
        if (errorHandler) errorHandler(error);
    }];
    [self.engine enqueueOperation:self.operation];
}

#pragma mark - public
- (void)getWithParams:(NSDictionary *)params successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    for (int i = 0;i < [params allKeys].count;i++) {
        NSString *key = [[params allKeys] objectAtIndex:i];
        if (i == 0) {
            self.path = [NSString stringWithFormat:@"%@?%@=%@", self.path, key, params[key]];
        } else {
            self.path = [NSString stringWithFormat:@"&%@=%@", key, params[key]];
        }
    }
    
    NSLog(@"path = %@", self.path);
    
    self.operation = [self.engine operationWithPath:self.path params:nil httpMethod:@"GET"];
    [self requestCompletionWithSuccessHandler:successHandler errorHandler:errorHandler];
    
}

- (void)postWithParams:(NSDictionary *)params successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    self.operation = [self.engine operationWithPath:self.path params:params httpMethod:@"POST"];
}

- (void)downloadFileFrom:(NSString *)remoteUrlString to:(NSString *)filePath downloadProgress:(progressChangeBlock)progressChangeHanler successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    self.operation = [self.engine operationWithPath:remoteUrlString params:nil httpMethod:@"GET"];
    [self.operation addDownloadStream:[NSOutputStream outputStreamToFileAtPath:filePath append:YES]];
    [self.operation onDownloadProgressChanged:^(double progress) {
        NSLog(@"download progerss:%f", progress);
        if (progressChangeHanler) progressChangeHanler(&progress);
    }];
    
    [self requestCompletionWithSuccessHandler:successHandler errorHandler:errorHandler];
}

- (void)uploadFileFromFileData:(NSData *)fileData params:(NSDictionary *)params filename:(NSString *)filename mimeType:(NSString *)fileType downloadPrecess:(progressChangeBlock)progressChangeHanler successHandler:(SuccessHandlerBlock)successHandler errorHandler:(ErrorHandlerBlock)errorHandler {
    self.operation = [self.engine operationWithPath:@"upload" params:params httpMethod:@"POST"];
    [self.operation addData:fileData forKey:@"media" mimeType:fileType fileName:filename];
    [self.operation setFreezable:YES];
    [self.operation onUploadProgressChanged:^(double progress) {
        NSLog(@"upload progerss:%f", progress);
        if (progressChangeHanler) progressChangeHanler(&progress);
    }];
    
    [self requestCompletionWithSuccessHandler:successHandler errorHandler:errorHandler];
}

@end
