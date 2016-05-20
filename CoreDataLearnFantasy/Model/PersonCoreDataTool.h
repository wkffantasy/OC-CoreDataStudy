//
//  PersonCoreDataTool.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>


@class PersonEntity;

typedef void(^HandleSuccessBlock)();
typedef void(^HandleFailedBlock)(NSString *failedString);
typedef void(^FetchOneEntitySuccessBlock)(PersonEntity *entity);

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

#pragma mark - 数据库的一些操作 所有的操作 都是根据id来进行的
//增
- (void)savePersonEntity:(PersonEntity *)entity
            succeccBlock:(HandleSuccessBlock)success
          andFailedBlock:(HandleFailedBlock )failed;;

//删
- (void)deletePersonEntity:(PersonEntity *)entity
              succeccBlock:(HandleSuccessBlock)success
            andFailedBlock:(HandleFailedBlock )failed;

- (void)deletePersonEntityAccordingID:(NSString *)entityId
                         succeccBlock:(HandleSuccessBlock)success
                       andFailedBlock:(HandleFailedBlock )failed;

- (void)deleteAllPersonEntity;

//查
- (BOOL)isHaveThisPersonEntity:(NSString *)personId;

//取
- (NSArray *)fecthAllPersonEntity;
- (void)fetchAnPersonEntityAccordingID:(NSString *)personId
                          succeccBlock:(FetchOneEntitySuccessBlock)success
                        andFailedBlock:(HandleFailedBlock )failed;


@end
