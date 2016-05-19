//
//  NSManagedObject+PersonObject.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "NSManagedObject+PersonObject.h"
#import "PersonCoreDataManager.h"

@implementation NSManagedObject (PersonObject)

+ (NSString *)entityName{
  
  return NSStringFromClass([self class]);
  
}
+ (instancetype)instanceNewObjectWithContext:(NSManagedObjectContext *)managedObjectContext{
  
  return [NSEntityDescription insertNewObjectForEntityForName:[self entityName] inManagedObjectContext:managedObjectContext];
  
}

+ (instancetype)instanceObject{
  
  return [self instanceNewObjectWithContext:[PersonCoreDataManager shareInstance].managedObjectContext];
  
}

- (void)save{
  
  [[PersonCoreDataManager shareInstance] saveContext];
  
}


@end
