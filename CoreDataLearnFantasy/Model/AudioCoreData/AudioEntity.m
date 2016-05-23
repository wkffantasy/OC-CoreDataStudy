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

+ (instancetype)instanceNewObjectWithContext:(NSManagedObjectContext *)managedObjectContext{
  
  return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:managedObjectContext];
  
}

+ (instancetype)setUpNewObject{
  
  return [self instanceNewObjectWithContext:[AudioCoreDataTool shareInstance].managedObjectContext];
  
}

@end
