//
//  ConfigRealm.m
//  RealmOC_learning
//
//  Created by ddn on 2017/7/14.
//  Copyright © 2017年 张永俊. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Realm/Realm.h>
#import "TestModel.h"
#import "TestSubModel.h"

@interface ConfigRealm : XCTestCase

@end

@implementation ConfigRealm

- (void)testExample {
	[self setDefaultRealmForUser:@"zhangsan"];
}

- (void)setDefaultRealmForUser:(NSString *)username {
	RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
	//使用默认路径，只是修改文件名，也可以修改路径
	config.fileURL = [[[config.fileURL URLByDeletingLastPathComponent] URLByAppendingPathComponent:username] URLByAppendingPathExtension:@"realm"];
//	config.readOnly = YES;//设为只读模式
	[RLMRealmConfiguration setDefaultConfiguration:config];
}

- (void)testRemoveRealm {
	[self setDefaultRealmForUser:@"zhangsan"];
	NSFileManager *fileMgr = [NSFileManager defaultManager];
	RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
	NSArray<NSURL *> *realmFileURLs = @[
										config.fileURL,
										[config.fileURL URLByAppendingPathExtension:@"lock"],
										[config.fileURL URLByAppendingPathExtension:@"log_a"],
										[config.fileURL URLByAppendingPathExtension:@"log_b"],
										[config.fileURL URLByAppendingPathExtension:@"note"]
										];
	for (NSURL *url in realmFileURLs) {
		NSError *error = nil;
		[fileMgr removeItemAtURL:url error:&error];
		if (error) {
			NSLog(@"removeRealmError: %@", error);
		}
	}
}

@end
