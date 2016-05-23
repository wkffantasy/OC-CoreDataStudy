//
//  PersonEntity.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

#import "PersonCoreDataTool.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonEntity : NSManagedObject

+ (NSString *)entityName;

+ (instancetype)setUpNewObject;

@end

NS_ASSUME_NONNULL_END

#import "PersonEntity+CoreDataProperties.h"

