//
//  ESWeatherAPI.m
//  ESNetworking
//
//  Created by 田鹏涛 on 2017/3/21.
//  Copyright © 2017年 1174060232@qq.com. All rights reserved.
//

#import "ESWeatherAPI.h"

@implementation ESWeatherAPI

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
    return @"xml.php";
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
 请求参数
 
 @return 请求参数
 */
-(NSDictionary*)parameters
{
    NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingGB_18030_2000);
    NSString *city =[_city stringByAddingPercentEscapesUsingEncoding:enc];
    NSParameterAssert(city);
    NSParameterAssert(_password);

    return @{@"city":city,
             @"password":_password,
             @"day":@(_day)};
}

/**
 请求结果解析
 
 @param result 结果
 @return 解析后的结果
 */
-(id)parse:(id)result
{
    return [[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding];
}

-(void)dealloc
{

}
@end
