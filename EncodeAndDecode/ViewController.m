//
//  ViewController.m
//  EncodeAndDecode
//
//  Created by rhcf_wujh on 16/8/18.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "ViewController.h"
#import "User.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    User * user = [[User alloc]init];
    user.username = @"wjh";
    user.phone = @"13312344321";
    user.address = @"cn";
    
    [self save:user];
    
    User * u = [self get];
    NSLog(@"%@  %@  %@",u.username,u.phone,u.address);
    u.username = @"wujh";
    [self save:u];
    
    User * uu = [self get];
    NSLog(@"%@  %@  %@",uu.username,uu.phone,uu.address);
    
    
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)save:(id)obj{
    [NSKeyedArchiver archiveRootObject:obj toFile:cachesPath()];
}

- (id)get{
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:cachesPath()];
    return obj;
}






static inline NSString * cachesPath(){
    return [NSString stringWithFormat:@"%@/rhcfUserCaches",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
