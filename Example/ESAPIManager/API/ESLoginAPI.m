//
//  ESLoginAPI.m
//  ESNetworking
//
//  Created by 田鹏涛 on 2017/3/20.
//  Copyright © 2017年 tianpengtao. All rights reserved.
//

#import "ESLoginAPI.h"

@implementation ESLoginAPI
/**
 基础url
 
 @return 基础url
 */
-(NSURL*)baseURL
{
    return [NSURL URLWithString:@"http://xxxx.com"];
}
/**
 和baseURL拼接成一个全url
 
 @return path
 */
-(NSString*)path
{
    return @"login.php";
}
/**
 请求参数
 
 @return 请求参数
 */
-(NSDictionary*)parameters
{
    return @{@"username":_username,
             @"password":_password};
}

/**
 请求结果解析，可解析状态码、转对象等操作
 
 @param result 结果
 @return 解析后的结果
 */
-(id)parse:(id)result
{
    return result;
}
@end
