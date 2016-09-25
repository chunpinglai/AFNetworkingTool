//
//  AFNetworkingTool.h
//  AFNetworkingTool
//
//  Created by AbbyLai on 2016/9/25.
//  Copyright © 2016年 AbbyLai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

#define DefaultRequestTimeOutInterval 60
typedef enum {
    ConnectionType_POST,
    ConnectionType_GET
} ConnectionType;

@interface AFNetworkingTool : NSObject

//GET / POST request with timeout param
+ (void)requestPOSTWithURL:(NSString *)strURL Params:(NSDictionary *)params TimeoutInterval:(int)timeoutInterval Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock;
+ (void)requestGETWithURL:(NSString *)strURL Params:(NSDictionary *)params TimeoutInterval:(int)timeoutInterval Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock;
+ (void)requestWithURL:(NSString *)strURL Params:(NSDictionary *)params TimeoutInterval:(int)timeoutInterval ConnectionType:(ConnectionType)connectionType Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock;

//GET / POST request with file
+ (void)multipartRequestWithURL:(NSString *)strURL Params:(NSDictionary *)params FileData:(NSArray *)fileData ConnectionType:(ConnectionType)connectionType TimeoutInterval:(int)timeoutInterval Progress:(void (^)(NSProgress * _Nonnull))uploadProgress Success:(void (^)(id responseObject))successBlock Failure:(void (^)(NSError *error))failureBlock;

@end
