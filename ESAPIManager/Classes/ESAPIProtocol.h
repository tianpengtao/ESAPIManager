//
//  ESAPIProtocol.h
//  Pods
//
//  Created by 田鹏涛 on 2017/3/20.
//
//

#import <UIKit/UIKit.h>
#import "NSObject+ESAPIManager.h"

//仅GET、POST当前有效
typedef enum
{
    OPTIONS,
    GET,
    HEAD,
    POST,
    PUT,
    PATCH,
    DELETE,
    TRACE,
    CONNECT
}
HTTPMethod;
@protocol ESAPIProtocol <NSObject>

@required
/**
 基础url
 
 @return 基础url
 */
-(NSURL*)baseURL;


/**
 和baseURL拼接成一个全url
 
 @return path
 */
-(NSString*)path;


@optional

/**
 http请求头
 
 @return
 */
-(NSDictionary*)HTTPHeader;

/**
 http请求方法，默认POST
 
 @return http请求方法
 */
-(HTTPMethod)method;

/**
 基础参数
 
 @return 基础参数
 */
-(NSDictionary*)baseParameters;

/**
 请求参数
 
 @return 请求参数
 */
-(NSDictionary*)parameters;

/**
 是否使用私有的https证书，默认NO
 
 @return 是否使用私有的https证书，默认NO
 */
-(BOOL)usePrivateCer;

/**
 请求结果解析，可解析状态码、转对象等操作
 
 @param result 结果
 @return 解析后的结果
 */
-(id)parse:(id)result;

/**
 错误解析，可根据状态码添加提示
 
 @param result 结果
 @return 解析后的结果
 */
-(id)error:(id)error;

/**
 超时时间，默认120s
 
 @return 超时时间
 */
-(int)timeout;

/**
 是否Debug，默认NO
 
 @return 是否Debug
 */
-(BOOL)debug;

@end
