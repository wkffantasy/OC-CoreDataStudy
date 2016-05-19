//
//  NSManagedObject+PersonObject.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface NSManagedObject (PersonObject)

+ (NSString *)entityName;

+ (instancetype)instanceObject;

+ (instancetype)instanceNewObjectWithContext:(NSManagedObjectContext *)managedObjectContext;

- (void)save;

@end
