//
//  AudioEntity.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/23.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "AudioEntity.h"

#import "AudioCoreDataTool.h"

@implementation AudioEntity


+ (NSString *)entityName{
  
  return NSStringFromClass([self class]);
  
}
+ (instancetype)setupNewOne{
  
  AudioEntity * entity = [NSEntityDescription insertNewObjectForEntityForName:[AudioEntity entityName] inManagedObjectContext:[AudioCoreDataTool shareInstance].managedObjectContext];
  
  return entity;
  
}

@end
