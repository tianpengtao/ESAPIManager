//
//  ESBaseAPI.m
//  ESNetworking
//
//  Created by 田鹏涛 on 2017/3/20.
//  Copyright © 2017年 1174060232@qq.com. All rights reserved.
//

#import "ESBaseAPI.h"

@implementation ESBaseAPI

/**
 基础url
 
 @return 基础url
 */
-(NSURL*)baseURL
{
  return [NSURL URLWithString:@"http://php.weather.sina.com.cn"];
}


/**
 和baseURL拼接成一个全url
 
 @return path
 */
-(NSString*)path
{
  return @"";
}

/**
 http请求方法，默认POST
 
 @return http请求方法
 */
-(HTTPMethod)method
{
  return POST;
}
/**
 基础参数
 
 @return 基础参数
 */
-(NSDictionary*)baseParameters
{
    NSTimeInterval timestamp=[[NSDate date] timeIntervalSince1970];
    NSString *token=@"token";
    return @{@"timestamp":@(timestamp),
             @"token":token};
}
/**
 请求参数
 
 @return 请求参数
 */
-(NSDictionary*)parameters
{
  return @{};
}

/**
 是否使用私有的https证书，默认NO
 
 @return 是否使用私有的https证书，默认NO
 */
-(BOOL)usePrivateCer
{
    return NO;
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

/**
 错误解析
 
 @param result 结果
 @return 解析后的结果
 */
-(id)error:(id)error
{
  return error;
}

/**
 超时时间，默认60s
 
 @return 超时时间
 */
-(int)timeout
{
  return 60;
}

/**
 是否Debug
 
 @return 是否Debug
 */
-(BOOL)debug
{
    
#ifdef DEBUG
    return YES;
#else
    return NO;
#endif
    
}


-(void)dealloc
{
    
}
@end
