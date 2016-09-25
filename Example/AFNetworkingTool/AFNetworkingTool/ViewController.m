//
//  ViewController.m
//  AFNetworkingTool
//
//  Created by AbbyLai on 2016/9/25.
//  Copyright © 2016年 AbbyLai. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworkingTool.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSString *url = @"http://cloud.culture.tw/frontsite/trans/SearchShowAction.do";
    NSDictionary *params = @{@"method":@"doFindTypeJ",
                             @"category":@"5"};
    
    [self getRequestWithParams:params url:url];
    //[self postRequestWithParams:params url:url];
    /*
    //upload file
    NSData *fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"YourFilePath"]];
    NSArray *fileDataArray = @[
                               @{@"mimetype":@"image/png",
                                 @"content": fileData,
                                 @"name":@"", //API param
                                 @"fileName":@"iOS_Image"}
                               ];
    
    [self multipartRequestWithParams:params url:url connectType:@"POST" fileData:fileDataArray];
    */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)postRequestWithParams:(NSDictionary *)params url:(NSString *)url {
    [AFNetworkingTool requestWithURL:url Params:params TimeoutInterval:20 ConnectionType:ConnectionType_POST Progress:nil Success:^(id responseObject) {
        
        NSDictionary *result = [self dealWithJsonData:responseObject];
        NSLog(@"result:%@",result);
        
    } Failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)getRequestWithParams:(NSDictionary *)params url:(NSString *)url {
    [AFNetworkingTool requestWithURL:url Params:params TimeoutInterval:20 ConnectionType:ConnectionType_GET Progress:nil Success:^(id responseObject) {
        
        NSDictionary *result = [self dealWithJsonData:responseObject];
        NSLog(@"result:%@",result);
        
    } Failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (void)multipartRequestWithParams:(NSDictionary *)params url:(NSString *)url connectType:(NSString *)connectType fileData:(NSArray *)fileData {
    ConnectionType type = ConnectionType_GET;
    if ([connectType isEqualToString:@"POST"]) {
        type = ConnectionType_POST;
    }
    else {
        type = ConnectionType_GET;
    }
    
    [AFNetworkingTool multipartRequestWithURL:url Params:params FileData:fileData ConnectionType:type TimeoutInterval:20 Progress:nil Success:^(id responseObject) {
        
        id result = [self dealWithJsonData:responseObject];
        NSLog(@"result:%@",result);
        
    } Failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
}

- (NSDictionary *)dealWithJsonData:(id)responseObject{
    NSError * err;
    NSDictionary *serializationResult = [NSJSONSerialization JSONObjectWithData:responseObject options:(kNilOptions) error:&err];
    
    if ([NSJSONSerialization isValidJSONObject:serializationResult]) {
        return serializationResult;
    } else {
        return @{};
    }
}

@end
