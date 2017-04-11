//
//  ESViewController.m
//  ESAPIManager
//
//  Created by tianpengtao on 03/25/2017.
//  Copyright (c) 2017 tianpengtao. All rights reserved.
//

#import "ESViewController.h"
#import "ESGitHubAPI.h"
#import "ESWeatherAPI.h"
#import "ESAPIConfig.h"
@interface ESViewController ()

@end

@implementation ESViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIButton *button=[UIButton buttonWithType:UIButtonTypeSystem];
    button.frame=CGRectMake(10, 50, 300, 50);
    [button setTitle:@"获取天气" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(zhengzhouWeather) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIButton *githubButton=[UIButton buttonWithType:UIButtonTypeSystem];
    githubButton.frame=CGRectMake(10, 110, 300, 50);
    [githubButton setTitle:@"GitHub" forState:UIControlStateNormal];
    [githubButton addTarget:self action:@selector(gitHubInfo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:githubButton];
}
-(void)zhengzhouWeather
{
    ESWeatherAPI *weatherApi=[[ESWeatherAPI alloc] init];
    weatherApi.password=@"DJOYnieT8234jlsK";
    weatherApi.city=@"北京";
    weatherApi.day=0;
    [weatherApi requestWithSuccess:^(id result) {
        
    } failure:^(NSError *error) {
        
    }];
}
-(void)gitHubInfo
{
    ESGitHubAPI *githubApi=[[ESGitHubAPI alloc] init];
    githubApi.userName=@"tianpengtao";
    [githubApi requestWithSuccess:^(id result) {
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
