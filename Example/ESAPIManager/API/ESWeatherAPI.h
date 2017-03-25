//
//  ESWeatherAPI.h
//  ESNetworking
//
//  Created by 田鹏涛 on 2017/3/21.
//  Copyright © 2017年 1174060232@qq.com. All rights reserved.
//

#import "ESBaseAPI.h"

@interface ESWeatherAPI : ESBaseAPI
@property(nonatomic,copy)NSString *city;
@property(nonatomic,copy)NSString *password;
@property(nonatomic,assign)NSInteger day;

@end
