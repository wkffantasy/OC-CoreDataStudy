//
//  PersonCoreDataTool.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PersonCoreDataTool.h"

#import "AllNonificationNames.h"

#import "PersonEntity.h"

@interface PersonCoreDataTool()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;

@end

@implementation PersonCoreDataTool

+ (instancetype)shareInstance{
  
  static dispatch_once_t onceToken;
  static PersonCoreDataTool * ret;
  dispatch_once(&onceToken, ^{
    ret = [[PersonCoreDataTool alloc]init];
  });
  
  return ret;
  
}

- (NSManagedObjectContext *)managedObjectContext{
  
  if (_managedObjectContext == nil) {
    _managedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSMainQueueConcurrencyType];
    //指定调度器
    _managedObjectContext.persistentStoreCoordinator = self.persistenStoreCoordinatoe;
  }
  return _managedObjectContext;
  
}

- (NSManagedObjectModel *)managedObjectModel{
  
  if (_managedObjectModel == nil) {
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
  }
  return _managedObjectModel;
  
}

- (NSFetchedResultsController *)fetchedResultsController{
  
  if (_fetchedResultsController == nil) {
    
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:[PersonEntity entityName]];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"personId" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:[PersonCoreDataTool shareInstance].managedObjectContext sectionNameKeyPath:@"name" cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    NSError * error;
    [_fetchedResultsController performFetch:&error];
    if (error != nil) {
      NSLog(@"执行查询有错误%@",error);
    }
    
  }
  return _fetchedResultsController;
  
}

- (NSPersistentStoreCoordinator *)persistenStoreCoordinatoe{
  
  if (_persistenStoreCoordinatoe == nil) {
    _persistenStoreCoordinatoe = [[NSPersistentStoreCoordinator alloc]initWithManagedObjectModel:self.managedObjectModel];
    NSURL * url = [[self applicationDocumentURL] URLByAppendingPathComponent:@"myLearnCoreData.db"];
    
    [_persistenStoreCoordinatoe addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
  }
  
  return _persistenStoreCoordinatoe;
}


- (NSURL *) applicationDocumentURL {
  
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

#pragma mark - fetchedResultsController代理方法
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
  
  NSLog(@"count %lu",self.fetchedResultsController.fetchedObjects.count);
  
  [[NSNotificationCenter defaultCenter]postNotificationName:kPersonEntityCoreDataChangeNonification object:nil];
  
}

#pragma mark - 数据库的一些操作
- (void)savePersonEntity:(PersonEntity *)entity succeccBlock:(HandleSuccessBlock)success andFailedBlock:(HandleFailedBlock)failed{
  
  if ([self isHaveThisPersonEntity:entity.personId]) {
    
    [self.managedObjectContext deleteObject:entity];
    if (failed) {
      failed(@"保存失败，已经有这个id的实体对象了");
    }
  }
  [self.managedObjectContext save:nil];
  
}

- (NSArray *)fecthAllPersonEntity{
  
  return self.fetchedResultsController.fetchedObjects;
  
}

- (void)fetchAnPersonEntityAccordingID:(NSString *)personId succeccBlock:(FetchOneEntitySuccessBlock)success andFailedBlock:(HandleFailedBlock)failed{
  
  NSArray * allPersonEntity = [self fecthAllPersonEntity];
  for (PersonEntity *entity in allPersonEntity) {
    
    if ([entity.personId isEqualToString:personId]) {
      if (success) {
        success(entity);
      }
      
      return;
    }
    
  }
  if (failed) {
    failed(@"所有的实体对象中 没有这个实体");
  }
  
}

- (void)deletePersonEntityAccordingID:(NSString *)entityId succeccBlock:(HandleSuccessBlock)success andFailedBlock:(HandleFailedBlock)failed{
  
  NSArray * allPersonEntity = [self fecthAllPersonEntity];
  for (PersonEntity * entity in allPersonEntity) {
    if ([entity.personId isEqualToString:entityId]) {
      
      [[PersonCoreDataTool shareInstance].managedObjectContext deleteObject:entity];
      [self.managedObjectContext save:nil];
      if (success) {
        success();
      }
      return;
    }
  }
  
  if (failed) {
    failed(@"所有的实体对象中 没有这个实体对应这个id");
  }
  
}

- (void)deletePersonEntity:(PersonEntity *)entity succeccBlock:(HandleSuccessBlock)success andFailedBlock:(HandleFailedBlock)failed{
  
  NSArray * allPersonEntity = [self fecthAllPersonEntity];
  if ([allPersonEntity containsObject:entity]) {
    [self.managedObjectContext deleteObject:entity];
    [self.managedObjectContext save:nil];
    if (success) {
      success();
      return;
    }
  }
  
  if (failed) {
    failed(@"所有的实体对象中 没有这个实体");
  }
  
}


- (void)deleteAllPersonEntity{
  
  NSArray * allPersonEntity = [self fecthAllPersonEntity];
  for (PersonEntity * entity in allPersonEntity) {
    [[PersonCoreDataTool shareInstance].managedObjectContext deleteObject:entity];
  }
  [self.managedObjectContext save:nil];
  
}

- (BOOL)isHaveThisPersonEntity:(NSString *)personId{
  
  NSArray * allPersonEntity = [self fecthAllPersonEntity];
  for (PersonEntity * entity in allPersonEntity) {
    if ([entity.personId isEqualToString:personId]) {
      return YES;
    }
  }
  return NO;
  
}


@end
