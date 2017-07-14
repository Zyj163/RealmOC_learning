//
//  BaseUseTests.m
//  RealmOC_learning
//
//  Created by ddn on 2017/7/14.
//  Copyright © 2017年 张永俊. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Realm/Realm.h>
#import "TestModel.h"
#import "TestSubModel.h"

@interface BaseUseTests : XCTestCase

@end

@implementation BaseUseTests

- (void)testCreate {
	RLMRealm *realm = [RLMRealm defaultRealm];
	//方式1
	TestModel *testModel = [[TestModel alloc] initWithValue:@{
															  @"id": @1,
															  @"age": @10,
															  @"name": @"zhangsan"
															  }];
	[realm beginWriteTransaction];
	[realm addObject:testModel];
	[realm commitWriteTransaction];
	
	//方式2
	TestModel *testModel2 = [[TestModel alloc] initWithValue:@{
															   @"id": @2,
															   @"age": @11,
															   @"name": @"lisi"
															   }];
	[realm transactionWithBlock:^{
		[realm addObject:testModel2];
	}];
	
	//方式3
	[realm transactionWithBlock:^{
		[TestModel createInRealm:realm withValue:@{
												   @"id": @3,
												   @"age": @12,
												   @"name": @"wangwu"
												   }];
	}];
}

- (void)testUpdate {
	RLMRealm *realm = [RLMRealm defaultRealm];
	//方式1
	TestModel *testModel = [[TestModel alloc] initWithValue:@{
															  @"id": @1
															  }];
	[testModel.tests addObject:[[TestSubModel alloc] initWithValue:@[@9]]];
	[realm beginWriteTransaction];
	[realm addOrUpdateObject:testModel];
	[realm commitWriteTransaction];
	
	//方式2
	[realm transactionWithBlock:^{
		[TestModel createOrUpdateInRealm:realm withValue:@{
															  @"id": @2,
															  @"age": @15
															  }];
	}];
	
	//方式3
	TestModel *testModel3 = [TestModel objectsWhere:@"name = 'wangwu'"].lastObject;
	[realm transactionWithBlock:^{
		testModel3.age = 20;
	}];
}

- (void)testDelete {
	RLMRealm *realm = [RLMRealm defaultRealm];
	
	[realm transactionWithBlock:^{
		
		[realm deleteObjects:[TestModel objectsWhere:@"name = 'wangwu'"]];
		//删除所有
//		[realm deleteAllObjects];
	}];
}

- (void)testQuery {
	RLMRealm *realm = [RLMRealm defaultRealm];
	
	//注意：数据发生变化，查询结果会实时更新
	
	RLMResults *results = [TestModel allObjectsInRealm:realm];
	
	RLMResults *sortedResults = [results sortedResultsUsingKeyPath:@"name" ascending:YES];
	
	RLMResults *results2 = [[results objectsWhere:@"age = 15"] objectsWhere:@"name = 'zhangsan'"];
	
	NSLog(@"=====%@\n=====%@\n=====%@\n", results, sortedResults, results2);
}

@end














