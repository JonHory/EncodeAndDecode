//
//  RHCFUserHelper.h
//  fusionWealthApp
//
//  Created by rhcf_wujh on 16/8/18.
//  Copyright © 2016年 rhcf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHCFUser.h"

@interface RHCFUserHelper : NSObject

/**
 *  用户模型
 */
@property (nonatomic ,copy) RHCFUser * user;

/**
 *  单例
 *
 *  @return 单例
 */
+ (RHCFUserHelper *)share;

/**
 *  归档obj对象
 *
 *  @param obj 归档
 */
+ (void)save:(id)obj;

/**
 *  解档
 *
 *  @return 解档obj
 */
+ (id)get;

- (void)save;


@end
