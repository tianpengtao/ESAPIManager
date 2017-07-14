//
//  ESNetworkingManager.m
//  EasySDKExample
//
//  Created by 田鹏涛 on 2016/12/12.
//  Copyright © 2016年 tian. All rights reserved.
//


#import "ESAPIManager.h"
#import "ESAPIConfig.h"

@interface ESAPIManager()<NSURLSessionDelegate>
@property (readwrite, nonatomic, strong) NSOperationQueue *operationQueue;
@property (readwrite, nonatomic, strong) NSURLSession *session;

@end
@implementation ESAPIManager
+(instancetype)manager
{
    static dispatch_once_t pred;
    static ESAPIManager *sharedInstance = nil;
    
    dispatch_once(&pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}
-(instancetype)init
{
    self=[super init];
    if (self) {
        self.operationQueue = [[NSOperationQueue alloc] init];
        self.operationQueue.maxConcurrentOperationCount = 1;
        NSURLSessionConfiguration *configuration=[NSURLSessionConfiguration defaultSessionConfiguration];
        self.session = [NSURLSession sessionWithConfiguration:configuration
                                                     delegate:self
                                                delegateQueue:self.operationQueue];
        
    }
    return self;
}
-(void)cancelDataTask
{
    [_session invalidateAndCancel];
}

/**
 用遵守ESAPIProtocol协议的对象发起网络请求
 
 @param api 遵守ESAPIProtocol协议的对象
 @param success 成功回调
 @param failure 失败回调
 */
-(void)request:(id<ESAPIProtocol>)api
       success:(void (^)(id))success
       failure:(void (^)(NSError *))failure
{
    //url
    NSURL *baseURL=[api baseURL];
    NSString *path=[api path];
    NSString *urlStr=[baseURL.absoluteString stringByAppendingPathComponent:path];
    
    //http请求头
    NSDictionary *httpHeader=nil;
    if ([api respondsToSelector:@selector(HTTPHeader)]) {
        httpHeader=[api HTTPHeader];
    }
    
    //参数
    NSDictionary *baseParameters=nil;
    if ([api respondsToSelector:@selector(baseParameters)]) {
        baseParameters=[api baseParameters];
    }
    
    if (!baseParameters) {
        baseParameters=[ESAPIConfig shared].baseParameters;
    }
    
    NSDictionary *parameters=nil;
    if ([api respondsToSelector:@selector(parameters)]) {
        parameters=[api parameters];
    }
    NSMutableDictionary *muDic=[[NSMutableDictionary alloc] init];
    [muDic addEntriesFromDictionary:baseParameters];
    [muDic addEntriesFromDictionary:parameters];
    
    //http请求方法
    HTTPMethod httpMethod=POST;
    if ([api respondsToSelector:@selector(method)]) {
        httpMethod=[api method];
    }
    
    //超时时长
    NSInteger timeout=120;
    if ([api respondsToSelector:@selector(timeout)]) {
        timeout=[api timeout];
    }
    
    //是否debug
    BOOL debug=NO;
    if ([api respondsToSelector:@selector(debug)]) {
        debug=[api debug];
    }
    
    //是否用私有证书
    BOOL usePrivateCer=NO;
    if ([api respondsToSelector:@selector(usePrivateCer)]) {
        usePrivateCer=[api usePrivateCer];
    }
    
    [self requestWithHTTPMethod:httpMethod
                      URLString:urlStr
                     parameters:muDic
                     httpHeader:httpHeader
                        timeout:timeout
                        success:^(NSURLSessionDataTask *task, id result) {
                            
                            id parseResult=result;
                            if ([api respondsToSelector:@selector(parse:)]) {
                                parseResult=[api parse:result];
                            }
                            //成功
                            if (parseResult)
                            {
                                success(parseResult);
                                if (debug) {
                                    NSString *successTagStr=@"👌👌👌网络请求成功👌👌👌";
                                    NSLog(@"\n%@\nurl:\n%@\nparameters:\n%@\nresult:\n%@\n%@",successTagStr,urlStr,parameters,parseResult,successTagStr);
                                }
                            }
                            //业务失败
                            else
                            {
                                NSError *parseError=nil;
                                if ([api respondsToSelector:@selector(error:)]) {
                                    parseError=[api error:result];
                                }
                                failure(parseError);
                                if (debug) {
                                    NSString *failureTagStr=@"⚠️⚠️⚠️网络请求业务失败⚠️⚠️⚠️";
                                    NSLog(@"\n%@\nurl:%@\nparameters:%@\nresult:%@\n%@",failureTagStr,urlStr,parameters,parseError,failureTagStr);
                                }

                            }
                        
                        }
                        failure:^(NSURLSessionDataTask *task, NSError *error) {
                            NSError *parseError=error;
                            if ([api respondsToSelector:@selector(error:)]) {
                                parseError=[api error:error];
                            }
                            failure(parseError);
                            if (debug) {
                                NSString *failureTagStr=@"⚠️⚠️⚠️网络请求失败⚠️⚠️⚠️";
                                NSLog(@"\n%@\nurl:%@\nparameters:%@\nresult:%@\n%@",failureTagStr,urlStr,parameters,parseError,failureTagStr);
                            }
                        }];
}
-(NSString*)httpMethod:(HTTPMethod)method
{
    
    NSString *httpMethod=@"";
    switch (method) {
        case OPTIONS:
            httpMethod=@"OPTIONS";
            break;
        case GET:
            httpMethod=@"GET";
            break;
        case HEAD:
            httpMethod=@"HEAD";
            break;
        case POST:
            httpMethod=@"POST";
            break;
        case PUT:
            httpMethod=@"PUT";
            break;
        case PATCH:
            httpMethod=@"PATCH";
            break;
        case DELETE:
            httpMethod=@"DELETE";
            break;
        case TRACE:
            httpMethod=@"TRACE";
            break;
        case CONNECT:
            httpMethod=@"CONNECT";
            break;
        default:
            httpMethod=@"GET";
            break;
    }
    return httpMethod;
}
/**
 网络请求
 
 @param method HTTP方法,POST\GET
 @param URLString url字符
 @param parameters 参数
 @param success 成功回调
 @param failure 失败回调
 */
- (void)requestWithHTTPMethod:(HTTPMethod)method
                    URLString:(NSString *)URLString
                   parameters:(id)parameters
                   httpHeader:(NSDictionary *)httpHeader
                      timeout:(NSInteger)timeout
                      success:(void (^)(NSURLSessionDataTask *, id))success
                      failure:(void (^)(NSURLSessionDataTask *, NSError *))failure
{
    NSURLRequest *urlRequest=[self configURLRequestWithHTTPMethod:method URLString:URLString parameters:parameters httpHeader:httpHeader timeout:timeout];
    __block __weak NSURLSessionDataTask * dataTask = [self.session dataTaskWithRequest:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(dataTask,error);
            });

        }else{
            id result =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (result)
                {
                    success(dataTask,result);
                }
                else
                {
                    success(dataTask,data);
                }
            });
    
        }
    }];
    [dataTask resume];
}

//生成urlRequest
- (NSURLRequest*)configURLRequestWithHTTPMethod:(HTTPMethod)method
                                      URLString:(NSString *)URLString
                                     parameters:(id)parameters
                                     httpHeader:(NSDictionary *)httpHeader
                                        timeout:(NSInteger)timeout
{
    NSMutableURLRequest *urlRequest=[[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:timeout];
    NSLog(@"allHTTPHeaderFields:%@",[urlRequest allHTTPHeaderFields]);
    //配置http请求头
    [httpHeader enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [urlRequest setValue:obj forHTTPHeaderField:key];
    }];
    
    //配置http方法
    [urlRequest setHTTPMethod:[self httpMethod:method]];
    
    //配置http参数
    NSString *query=[self handleParameter:parameters];
    
    if (method==POST)
    {
        NSData *queryData=[query dataUsingEncoding:NSUTF8StringEncoding];
        [urlRequest setHTTPBody:queryData];
    }
    else
    {
        urlRequest.URL=[NSURL URLWithString:[NSString stringWithFormat:@"%@?%@",URLString,query]];
    }
    return urlRequest;
}

//GET参数处理
- (NSString*)handleParameter:(NSDictionary*)parameters
{
    NSMutableArray *parametersArray=[[NSMutableArray alloc] init];
    [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [parametersArray addObject:[NSString stringWithFormat:@"%@=%@",key,obj]];
    }];
    if (parametersArray.count>0) {
        return [parametersArray componentsJoinedByString:@"&"];
    }
    
    return nil;
}

#pragma mark - 安全验证
- (void)URLSession:(NSURLSession *)session didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential * __nullable credential))completionHandler
{
    if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
        NSURLCredential *cre = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        completionHandler(NSURLSessionAuthChallengeUseCredential,cre);
    }
}

@end
