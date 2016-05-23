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

+ (instancetype)setUpNewObject{
  
  NSLog(@"first %@",[[PersonCoreDataTool shareInstance] fecthAllPersonEntity]);
  
  PersonEntity * entity = [NSEntityDescription insertNewObjectForEntityForName:[PersonEntity entityName] inManagedObjectContext:[PersonCoreDataTool shareInstance].managedObjectContext];
  
  NSLog(@"second %@",[[PersonCoreDataTool shareInstance] fecthAllPersonEntity]);
  
  return entity;
  
}


@end
