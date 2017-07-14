//
//  ViewController.m
//  RealmOC_learning
//
//  Created by ddn on 2017/7/14.
//  Copyright © 2017年 张永俊. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "TestModel.h"
#import "TestSubModel.h"

@interface ViewController ()

@property (strong, nonatomic) RLMNotificationToken *notify;

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	TestModel *testModel = [TestModel allObjects].firstObject;
	RLMArray *objects = testModel.tests;
	self.notify = [objects addNotificationBlock:^(RLMArray * _Nullable results, RLMCollectionChange * _Nullable change, NSError * _Nullable error) {
		//一开始就先调用了一次
		NSLog(@"===results:%@====", results);
	}];
}

- (void)dealloc
{
	[self.notify stop];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	RLMRealm *realm = [RLMRealm defaultRealm];
	TestModel *testModel = [TestModel allObjects].firstObject;
	[realm beginWriteTransaction];
	if (testModel.tests.count == 0) {
		[testModel.tests addObject: [[TestSubModel alloc] initWithValue:@[@9]]];
	} else {
		testModel.tests.firstObject.age = 10;
	}
	[realm commitWriteTransaction];
}


@end
