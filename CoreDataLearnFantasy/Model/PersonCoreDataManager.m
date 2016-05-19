//
//  PersonCoreDataManager.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PersonCoreDataManager.h"

@implementation PersonCoreDataManager

+ (instancetype)shareInstance{
  
  static dispatch_once_t onceToken;
  static PersonCoreDataManager * ret;
  dispatch_once(&onceToken, ^{
    ret = [[PersonCoreDataManager alloc]init];
  });
  
  return ret;
  
}

- (void)saveContext{
  
  [self.managedObjectContext save:nil];
  
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




@end
