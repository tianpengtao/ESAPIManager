//
//  ESGitHubAPI.m
//  ESNetworking
//
//  Created by 田鹏涛 on 2017/3/25.
//  Copyright © 2017年 1174060232@qq.com. All rights reserved.
//

#import "ESGitHubAPI.h"

@implementation ESGitHubAPI
/**
 基础url
 
 @return 基础url
 */
-(NSURL*)baseURL
{
    return [NSURL URLWithString:@"https://api.github.com"];
}


/**
 和baseURL拼接成一个全url
 
 @return path
 */
-(NSString*)path
{
    return [NSString stringWithFormat:@"/users/%@",_userName];
}

/**
 http请求头
 
 @return
 */
-(NSDictionary*)HTTPHeader
{
    return @{@"os":@"ios"};
}
/**
 http请求方法，默认POST
 
 @return http请求方法
 */
-(HTTPMethod)method
{
    return GET;
}
/**
 请求参数
 
 @return 请求参数
 */
-(NSDictionary*)parameters
{
    return nil;
}

/**
 请求结果解析，可解析状态码、转对象等操作
 
 @param result 结果
 @return 解析后的结果
 */
-(id)parse:(id)result
{
    //这里可以转对象等操作
    return result;
}

-(void)dealloc
{
    
}

@end
