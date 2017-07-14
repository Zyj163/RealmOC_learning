//
//  TestModel.h
//  RealmOC_learning
//
//  Created by ddn on 2017/7/14.
//  Copyright © 2017年 张永俊. All rights reserved.
//

#import <Realm/Realm.h>
#import "TestSubModel.h"

@interface TestModel : RLMObject
/*
 支持类型 BOOL, bool, int, NSInteger, long, long long, float, double, NSString, NSDate, NSData, and NSNumber
 You can use RLMArray<Object *><Object> and RLMObject subclasses to model relationships such as to-many and to-one.
 
 RLMArrays support Objective‑C generics. Here’s what the different components of the property definition mean and why they are useful:
 
 RLMArray: The property type.
 <Object *>: The generic specialization. This helps prevent using the array with the wrong object type at compile-time.
 <Object>: The protocol this RLMArray conforms to. This enables Realm to know how to specialize the schema of this model at runtime.
 */
@property int id;
@property int age;
@property NSString *name;

@property NSNumber<RLMInt> *num;

@property (readonly) NSString *sex;

//使用时直接调用add，不需要创建，置为nil时只是清空数组
@property RLMArray<TestSubModel *><TestSubModel> *tests;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<TestModel *><TestModel>
RLM_ARRAY_TYPE(TestModel)
