//
//  PersonEntity+CoreDataProperties.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "PersonEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface PersonEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *phone;
@property (nullable, nonatomic, retain) NSString *personId;

@end

NS_ASSUME_NONNULL_END
