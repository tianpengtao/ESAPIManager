//
//  NSObject+ESAPIManager.m
//  Pods
//
//  Created by 田鹏涛 on 2017/3/22.
//
//

#import "NSObject+ESAPIManager.h"
#import "ESAPIManager.h"
#import "ESAPIProtocol.h"
@implementation NSObject (ESAPIManager)
-(void)requestWithSuccess:(void (^)(id result))success
                  failure:(void (^)(NSError *error))failure
{
    if (![self conformsToProtocol:@protocol(ESAPIProtocol)])
    {
        NSAssert(NO, @"API_请遵守ESAPIProtocol协议");
        return;
    }
    [[ESAPIManager manager] request:(id<ESAPIProtocol>)self success:success failure:failure];
}
@end
