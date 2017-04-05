//
//  ESAPICache.m
//  Pods
//
//  Created by 田鹏涛 on 2017/3/27.
//
//  缓存、暂无实现

#import "ESAPICache.h"

@implementation ESAPICache
+ (ESAPICache *)shared
{
    static dispatch_once_t pred;
    static ESAPICache *sharedInstance = nil;
    dispatch_once(&pred, ^
                  {
                      sharedInstance = [[self alloc] init];
                  });
    return sharedInstance;
}
@end
