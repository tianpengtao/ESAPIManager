//
//  ESAPIConfig.h
//  Pods
//
//  Created by 田鹏涛 on 2017/3/27.
//
//  配置，优先级小于遵守ESAPIProtocol协议的配置

#import <Foundation/Foundation.h>

@interface ESAPIConfig : NSObject

+ (ESAPIConfig *)shared;

/**
 基础参数
 */
@property(nonatomic,strong)NSDictionary *baseParameters;

- (instancetype)init NS_UNAVAILABLE;
+ (instancetype)new NS_UNAVAILABLE;
@end
