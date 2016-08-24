//
//  RHCFUserHelper.m
//  fusionWealthApp
//
//  Created by rhcf_wujh on 16/8/18.
//  Copyright © 2016年 rhcf. All rights reserved.
//

#import "RHCFUserHelper.h"

@implementation RHCFUserHelper

static RHCFUserHelper *_instance;
+ (RHCFUserHelper *)share{
    static dispatch_once_t pred;
    dispatch_once(&pred, ^{
        if (!_instance) {
            _instance = [[RHCFUserHelper alloc] init];
        }
    });
    return _instance;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if(_instance == nil)
            _instance = [super allocWithZone:zone];
    });
    return _instance;
}
//保证copy时相同
-(id)copyWithZone:(NSZone *)zone{
    return _instance;
}


+ (void)save:(id)obj{
    if (!obj) {
        return;
    }
    [NSKeyedArchiver archiveRootObject:obj toFile:cachesPath()];
}

- (void)save{
    if (!_user) {
        return;
    }
    [NSKeyedArchiver archiveRootObject:_user toFile:cachesPath()];
}

+ (id)get{
    id obj = [NSKeyedUnarchiver unarchiveObjectWithFile:cachesPath()];
    return obj;
}

- (RHCFUser *)user{
    if (!_user) {
        _user = [[RHCFUser alloc]init];
    }
    return _user;
}

static inline NSString * cachesPath(){
    return [NSString stringWithFormat:@"%@/rhcfUserCaches",NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, true)[0]];
}



@end
