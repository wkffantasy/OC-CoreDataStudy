//
//  PersonCoreDataTool.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>
#import "PersonEntity.h"

@interface PersonCoreDataTool : NSObject

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

#pragma mark - 数据库的一些操作
//增
- (void)saveContext;

//删


//改


//查


//取
- (NSArray *)fecthAllPersonEntity;

//

@end
