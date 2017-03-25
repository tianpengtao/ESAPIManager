//
//  ESNetworkingManager.h
//  EasySDKExample
//
//  Created by 田鹏涛 on 2016/12/12.
//  Copyright © 2016年 tian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ESAPIProtocol.h"


@interface ESAPIManager : NSObject


+(instancetype)manager;

/**
 用遵守ESAPIProtocol协议的对象发起网络请求

 @param api 遵守ESAPIProtocol协议的对象
 @param success 成功回调
 @param failure 失败回调
 */
-(void)request:(id<ESAPIProtocol>)api
       success:(void (^)(id))success
       failure:(void (^)(NSError *))failure;

/**
 取消当前正在进行的网络请求
 */
- (void)cancelDataTask;
@end
