//
//  PersonCoreDataManager.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>


@interface PersonCoreDataManager : NSObject

/**
 *  管理上下文对象
 */
@property(strong, nonatomic) NSManagedObjectContext * managedObjectContext;
/**
 *  管理模型对象
 */
@property(strong, nonatomic) NSManagedObjectModel * managedObjectModel;
/**
 *  持久化存储调度器
 */
@property(strong, nonatomic) NSPersistentStoreCoordinator * persistenStoreCoordinatoe;

+ (instancetype)shareInstance;

- (void)saveContext;


@end
