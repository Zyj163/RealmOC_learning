//
//  TestModel.m
//  RealmOC_learning
//
//  Created by ddn on 2017/7/14.
//  Copyright © 2017年 张永俊. All rights reserved.
//

#import "TestModel.h"

@interface TestModel()

@property NSString *sex;

@end

@implementation TestModel

+ (NSString *)primaryKey
{
	return @"id";
}

//不能为空的属性(默认是可以为空的)
+ (NSArray<NSString *> *)requiredProperties
{
	return @[@"id"];
}

// Specify default values for properties

+ (NSDictionary *)defaultPropertyValues
{
    return @{@"id": @0, @"sex": @"unknown"};
}

// Specify properties to ignore (Realm won't persist these)
//默认readonly的属性是被忽略的
//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
