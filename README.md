# AFNetworkingTool

AFNetworkingTool is a useful networking tool.It's base on AFNetworking 3.0.
You can get your data easily!


## How To Get Started

+ Download AFNetworking and import it into your apps.
+ Download AFNetworkingTool and import it into your apps.

 
## Usage

    NSString *url = @"http://cloud.culture.tw/frontsite/trans/SearchShowAction.do";
    NSDictionary *params = @{@"method":@"doFindTypeJ",@"category":@"5"};
        
#### Use GET request.
	[AFNetworkingTool requestWithURL:url Params:params TimeoutInterval:20 ConnectionType:ConnectionType_GET Progress:nil Success:^(id responseObject) {
    NSDictionary *result = [self dealWithJsonData:responseObject];
    	//NSLog(@"result:%@",result);
    } Failure:^(NSError *error) {
    	//NSLog(@"error:%@",error);
    }];

#### Use POST request.

	[AFNetworkingTool requestWithURL:url Params:params TimeoutInterval:20 ConnectionType:ConnectionType_POST Progress:nil Success:^(id responseObject) {
    NSDictionary *result = [self dealWithJsonData:responseObject];
        //NSLog(@"result:%@",result);
    } Failure:^(NSError *error) {
        //NSLog(@"error:%@",error);
    }];

#### Upload file.

    NSData *fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"YourFilePath"]];
    NSArray *fileDataArray = @[@{
      @"mimetype":@"image/png", //Your mimetype
      @"content": fileData, //Your data
      @"name":@"", //API param
      @"fileName":@"iOS_Image"} //You fileName
    ];
    [AFNetworkingTool multipartRequestWithURL:url Params:params FileData:fileData ConnectionType:@"POST" TimeoutInterval:20 Progress:nil Success:^(id responseObject) {
        id result = [self dealWithJsonData:responseObject];
        NSLog(@"result:%@",result);
    } Failure:^(NSError *error) {
        NSLog(@"error:%@",error);
    }];
