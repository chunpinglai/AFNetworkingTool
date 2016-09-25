//
//  AFNetworkingTool.m
//  AFNetworkingTool
//
//  Created by AbbyLai on 2016/9/25.
//  Copyright © 2016年 AbbyLai. All rights reserved.
//

#import "AFNetworkingTool.h"

@implementation AFNetworkingTool

+ (void)requestPOSTWithURL:(NSString *)strURL Params:(NSDictionary *)params TimeoutInterval:(int)timeoutInterval Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    int timeout = timeoutInterval ? timeoutInterval : DefaultRequestTimeOutInterval;
    [manager.requestSerializer setTimeoutInterval:timeout];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [AFNetworkingTool requestPOSTWithManager:manager URL:strURL Params:params Progress:uploadProgress Success:successBlock Failure:failureBlock];
}

+ (void)requestPOSTWithManager:(AFHTTPSessionManager *)manager URL:(NSString *)strURL Params:(NSDictionary *)params Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock	{
    [manager POST:strURL parameters:params progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)requestGETWithURL:(NSString *)strURL Params:(NSDictionary *)params TimeoutInterval:(int)timeoutInterval Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock {
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    int timeout = timeoutInterval ? timeoutInterval : DefaultRequestTimeOutInterval;
    [manager.requestSerializer setTimeoutInterval:timeout];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [AFNetworkingTool requestGETWithManager:manager URL:strURL Params:params Progress:uploadProgress Success:successBlock Failure:failureBlock];
}

+ (void)requestGETWithManager:(AFHTTPSessionManager *)manager URL:(NSString *)strURL Params:(NSDictionary *)params Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock	{
    [manager GET:strURL parameters:params progress:uploadProgress success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failureBlock) {
            failureBlock(error);
        }
    }];
}

+ (void)requestWithURL:(NSString *)strURL Params:(NSDictionary *)params TimeoutInterval:(int)timeoutInterval ConnectionType:(ConnectionType)connectionType Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock {
    if (connectionType == ConnectionType_POST) {
        [AFNetworkingTool requestPOSTWithURL:strURL Params:params TimeoutInterval:timeoutInterval Progress:uploadProgress Success:successBlock Failure:failureBlock];
    }
    else {
        [AFNetworkingTool requestGETWithURL:strURL Params:params TimeoutInterval:timeoutInterval Progress:uploadProgress Success:successBlock Failure:failureBlock];
    }
}

+ (void)multipartRequestWithURL:(NSString *)strURL Params:(NSDictionary *)params FileData:(NSArray *)fileData ConnectionType:(ConnectionType)connectionType TimeoutInterval:(int)timeoutInterval Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock {
    NSString *connectionTypeStr = @"GET";
    if (connectionType == ConnectionType_POST) {
        connectionTypeStr = @"POST";
    }
    else {
        connectionTypeStr = @"GET";
    }
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer]
                                    multipartFormRequestWithMethod:connectionTypeStr
                                    URLString:strURL
                                    parameters:params
                                    constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                        
                                        for (int i=0; i<fileData.count; i++) {
                                            NSDictionary *dic = [fileData objectAtIndex:i];
                                            NSData *data = dic[@"content"];
                                            [formData appendPartWithFileData:data name:dic[@"paramName"] fileName:dic[@"fileName"] mimeType:dic[@"mimetype"]];
                                        }
                                    }
                                    error:nil];
    
    int timeout = timeoutInterval ? timeoutInterval : DefaultRequestTimeOutInterval;
    [request setTimeoutInterval:timeout];
    
    AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    NSURLSessionUploadTask *uploadTask = [manager uploadTaskWithStreamedRequest:request progress:uploadProgress completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error) {
            if (failureBlock) {
                failureBlock(error);
            }
        } else {
            if (successBlock) {
                successBlock(responseObject);
            }
        }
    }];
    
    [uploadTask resume];
}

@end


