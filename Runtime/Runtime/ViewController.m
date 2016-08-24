//
//  ViewController.m
//  Runtime
//
//  Created by rhcf_wujh on 16/8/24.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "ViewController.h"
#import "RHCFUserHelper.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    RHCFUserHelper * helper = [RHCFUserHelper share];
    helper.user.username = @"www";
    [helper save];
    RHCFUser * user = helper.user;
    NSLog(@"user:%@",user.username);
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
