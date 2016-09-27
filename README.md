# AFNetworkingTool

AFNetworkingTool is a useful networking tool.It's base on AFNetworking 3.0.
You can get your data easily!

---------------------------------------
## How To Get Started

+ Download AFNetworking and import it into your apps.
+ Download AFNetworkingTool and import it into your apps.

---------------------------------------
 
## Usage

    NSString *url = @"http://cloud.culture.tw/frontsite/trans/SearchShowAction.do";
    NSDictionary *params = @{@"method":@"doFindTypeJ",@"category":@"5"};
        
#### Use GET request.

    [self getRequestWithParams:params url:url];

#### Use POST request.

    [self postRequestWithParams:params url:url];


#### Upload file.

    NSData *fileData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"YourFilePath"]];
    NSArray *fileDataArray = @[@{
      @"mimetype":@"image/png", //Your mimetype
      @"content": fileData, //Your data
      @"name":@"", //API param
      @"fileName":@"iOS_Image"} //You fileName
    ];
    [self multipartRequestWithParams:params url:url connectType:@"POST" fileData:fileDataArray];
