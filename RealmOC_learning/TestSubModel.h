//
//  TestSubModel.h
//  RealmOC_learning
//
//  Created by ddn on 2017/7/14.
//  Copyright © 2017年 张永俊. All rights reserved.
//

#import <Realm/Realm.h>

@interface TestSubModel : RLMObject

@property int age;

//反向关系
@property (readonly) RLMLinkingObjects *testModel;

@end

// This protocol enables typed collections. i.e.:
// RLMArray<TestSubModel *><TestSubModel>
RLM_ARRAY_TYPE(TestSubModel)
