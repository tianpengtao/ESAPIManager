//
//  ESAPIConfig.m
//  Pods
//
//  Created by 田鹏涛 on 2017/3/27.
//
//

#import "ESAPIConfig.h"

@implementation ESAPIConfig
+ (ESAPIConfig *)shared
{
    static dispatch_once_t pred;
    static ESAPIConfig *sharedInstance = nil;
    dispatch_once(&pred, ^
                  {
                      sharedInstance = [[self alloc] init];
                  });
    return sharedInstance;
}
@end
