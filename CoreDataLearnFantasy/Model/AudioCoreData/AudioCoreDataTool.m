//
//  AudioCoreDataTool.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/23.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "AudioCoreDataTool.h"

#import "AudioEntity.h"
#import "DownloadTool.h"
#import "AllNonificationNames.h"

@interface AudioCoreDataTool ()<NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;

@end

@implementation AudioCoreDataTool

+ (instancetype)shareInstance{
  
  static dispatch_once_t onceToken;
  static AudioCoreDataTool * ret;
  dispatch_once(&onceToken, ^{
    ret = [[AudioCoreDataTool alloc]init];
  });
  
  return ret;
  
}


#pragma mark -  数据库操作

- (void)saveAudioEntity:(AudioEntity *)entity succeccBlock:(HandleSuccessBlock)success andFailedBlock:(HandleFailedBlock)failed{
  
  if ([self isHaveThisAudioEntity:entity.audioUrl]) {
    
    [self.managedObjectContext deleteObject:entity];
    if (failed) {
      failed(@"保存失败，已经有这个id的实体对象了");
    }
  }
  NSError * error;
  [self.managedObjectContext save:&error];
  if (error) {
    NSLog(@"add Audio entity failed %@",error);
    if (failed) {
      failed(error.localizedDescription);
    }
  } else {
 
    if (success) {
      success();
    }
  }
  
}
- (BOOL)isHaveThisAudioEntity:(NSString *)url{
  
  NSArray * allAudioEntity = [self fecthAllAudioEntity];
  
  for (AudioEntity * entity in allAudioEntity) {
    if ([entity.audioUrl isEqualToString:url]) {
      NSLog(@"YES %d",YES);
      return YES;
    }
  }
  return NO;
  
}
- (NSArray *)fecthAllAudioEntity{
  
  return self.fetchedResultsController.fetchedObjects;
  
}

#pragma mark - fetchedResultsController代理方法
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
  
//  [[NSNotificationCenter defaultCenter] postNotificationName:kAudioEntityCoreDataChangeNonification object:nil];
  
}


#pragma mark - 懒加载
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
    
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:[AudioEntity entityName]];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"audioName" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    [request setSortDescriptors:[NSArray array]];
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:[AudioCoreDataTool shareInstance].managedObjectContext sectionNameKeyPath:@"audioName" cacheName:nil];
    
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
    NSURL * url = [[self applicationDocumentURL] URLByAppendingPathComponent:@"myCoreDataAudio.db"];
    
    [_persistenStoreCoordinatoe addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:nil];
  }
  
  return _persistenStoreCoordinatoe;
}

- (NSURL *) applicationDocumentURL {
  
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}



@end
