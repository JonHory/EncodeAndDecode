//
//  RHCFCoding.m
//  alertTest
//
//  Created by rhcf_wujh on 16/8/18.
//  Copyright © 2016年 wjh. All rights reserved.
//

#import "RHCFCoding.h"
#import <objc/runtime.h>

@implementation RHCFCoding


- (void)encodeWithCoder:(NSCoder *)aCoder{
    Class cls = [self class];
    while (cls != [NSObject class]) {
        /*判断是自身类还是父类*/
        BOOL bIsSelfClass = (cls == [self class]);
        unsigned int iVarCount = 0;//成员变量个数
        unsigned int propVarCount = 0;
        unsigned int sharedVarCount = 0;
        Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/
        objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/
        sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;
        
        for (int i = 0; i < sharedVarCount; i++) {
            const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i));
            NSString *key = [NSString stringWithUTF8String:varName];
            /*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/
            id varValue = [self valueForKey:key];
            if (varValue) {
                [aCoder encodeObject:varValue forKey:key];//使用KVC获取key对应的变量值
            }
        }
        free(ivarList);//释放掉
        free(propList);//释放掉
        cls = class_getSuperclass(cls);
    }
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    Class cls = [self class];
    while (cls != [NSObject class]) {
        /*判断是自身类还是父类*/
        BOOL bIsSelfClass = (cls == [self class]);
        unsigned int iVarCount = 0;
        unsigned int propVarCount = 0;
        unsigned int sharedVarCount = 0;
        Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/
        objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/
        sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;
        
        for (int i = 0; i < sharedVarCount; i++) {
            const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i));
            NSString *key = [NSString stringWithUTF8String:varName];
            id varValue = [aDecoder decodeObjectForKey:key];
            if (varValue) {
                [self setValue:varValue forKey:key];//使用KVC强制写入到对象中
            }
        }
        free(ivarList);//释放掉
        free(propList);//释放掉
        cls = class_getSuperclass(cls);
    }
    return self;
}

- (id)copyWithZone:(NSZone *)zone{
    id copy = [[[self class] allocWithZone:zone] init];    
    Class cls = [self class];   
    while (cls != [NSObject class]) {  
        /*判断是自身类还是父类*/    
        BOOL bIsSelfClass = (cls == [self class]);  
        unsigned int iVarCount = 0; 
        unsigned int propVarCount = 0;  
        unsigned int sharedVarCount = 0;    
        Ivar *ivarList = bIsSelfClass ? class_copyIvarList([cls class], &iVarCount) : NULL;/*变量列表，含属性以及私有变量*/   
        objc_property_t *propList = bIsSelfClass ? NULL : class_copyPropertyList(cls, &propVarCount);/*属性列表*/   
        sharedVarCount = bIsSelfClass ? iVarCount : propVarCount;   
        
        for (int i = 0; i < sharedVarCount; i++) {  
            const char *varName = bIsSelfClass ? ivar_getName(*(ivarList + i)) : property_getName(*(propList + i)); 
            NSString *key = [NSString stringWithUTF8String:varName];    
            /*valueForKey只能获取本类所有变量以及所有层级父类的属性，不包含任何父类的私有变量(会崩溃)*/  
            id varValue = [self valueForKey:key];   
            NSArray *filters = @[@"superclass", @"description", @"debugDescription", @"hash"]; 
            if (varValue && [filters containsObject:key] == NO) { 
                [copy setValue:varValue forKey:key];    
            }   
        }   
        free(ivarList); 
        free(propList); 
        cls = class_getSuperclass(cls); 
    }   
    return copy;    
}


@end
