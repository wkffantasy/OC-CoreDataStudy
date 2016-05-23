//
//  PersonEntity.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PersonEntity.h"

@interface PersonEntity ()

@end

@implementation PersonEntity


+ (NSString *)entityName{
  
  return NSStringFromClass([self class]);
  
}

+ (instancetype)instanceNewObjectWithContext:(NSManagedObjectContext *)managedObjectContext{
  
  return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:managedObjectContext];
  
}

+ (instancetype)setUpNewObject{
  
  return [self instanceNewObjectWithContext:[PersonCoreDataTool shareInstance].managedObjectContext];
  
}


@end
