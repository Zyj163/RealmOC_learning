//
//  AppDelegate.m
//  RealmOC_learning
//
//  Created by ddn on 2017/7/14.
//  Copyright © 2017年 张永俊. All rights reserved.
//

#import "AppDelegate.h"
#import <Realm/Realm.h>
#import "TestModel.h"
#import "TestSubModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

//数据迁移，需要参照版本号，默认版本号是0
//当第一次访问数据库时才会真正触发迁移
- (void)migrationRealm {
	RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
	
	config.schemaVersion = 2;
	
	[config setMigrationBlock: ^(RLMMigration *mifration, uint64_t oldSchemaVersion) {
		
		//需要根据不同的oldSchemaVersion做不同的处理，有可能出现0->2, 1->2 这种情况的版本迁移，不同版本间的迁移需要做不同的处理
		
		if (oldSchemaVersion < config.schemaVersion) {
			NSLog(@"自动迁移");
			
			[mifration enumerateObjects:@"TestModel" block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
				//数据处理(例如，新加num字段，可以给以前的数据的num赋值)
				newObject[@"num"] = @(2);
			}];
		}
	}];
	
	[RLMRealmConfiguration setDefaultConfiguration:config];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	[self migrationRealm];
//	RLMRealm *realm = [RLMRealm defaultRealm];
//	
//	
//	TestModel *testModel = [[TestModel alloc] initWithValue:@{
//															  @"id": @1,
//															  @"age": @10,
//															  @"name": @"zhangsan"
//															  }];
//	[realm beginWriteTransaction];
//	[realm addObject:testModel];
//	[realm commitWriteTransaction];
	
	return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
	// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
	// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
	// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
	// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
	// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
	// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
