//
//  User.h
//  EncodeAndDecode
//
//  Created by rhcf_wujh on 16/8/18.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "RHCFCoding.h"

@interface User : RHCFCoding

@property (nonatomic ,copy) NSString * address;

@property (nonatomic ,copy) NSString * username;

@property (nonatomic ,copy) NSString * phone;

@end
