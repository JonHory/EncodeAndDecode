//
//  RHCFUser.h
//  fusionWealthApp
//
//  Created by rhcf_wujh on 16/8/18.
//  Copyright © 2016年 rhcf. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RHCFCoding.h"

@interface RHCFUser : RHCFCoding

@property (nonatomic ,copy  ) NSString  * member_id;/**< 会员ID*/

@property (nonatomic ,copy  ) NSString  * username;/**< 用户登陆名*/


@end
