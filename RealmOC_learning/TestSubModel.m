//
//  TestSubModel.m
//  RealmOC_learning
//
//  Created by ddn on 2017/7/14.
//  Copyright © 2017年 张永俊. All rights reserved.
//

#import "TestSubModel.h"

@implementation TestSubModel

//反向关系的描述
+ (NSDictionary<NSString *,RLMPropertyDescriptor *> *)linkingObjectsProperties
{
	return @{
			 @"testModel": [RLMPropertyDescriptor descriptorWithClass:NSClassFromString(@"TestModel") propertyName:@"tests"]
			 };
}

// Specify default values for properties

//+ (NSDictionary *)defaultPropertyValues
//{
//    return @{};
//}

// Specify properties to ignore (Realm won't persist these)

//+ (NSArray *)ignoredProperties
//{
//    return @[];
//}

@end
