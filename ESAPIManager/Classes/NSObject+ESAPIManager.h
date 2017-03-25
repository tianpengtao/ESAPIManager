//
//  NSObject+ESAPIManager.h
//  Pods
//
//  Created by 田鹏涛 on 2017/3/22.
//
//

#import <Foundation/Foundation.h>

@interface NSObject (ESAPIManager)
-(void)requestWithSuccess:(void (^)(id result))success
                  failure:(void (^)(NSError *error))failure;
@end
