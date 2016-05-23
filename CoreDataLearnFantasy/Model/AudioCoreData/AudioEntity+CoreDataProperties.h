//
//  AudioEntity+CoreDataProperties.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/23.
//  Copyright © 2016年 fantasy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AudioEntity.h"

NS_ASSUME_NONNULL_BEGIN

@interface AudioEntity (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *audioLocalPath;
@property (nullable, nonatomic, retain) NSString *audioName;
@property (nullable, nonatomic, retain) NSString *audioUrl;
@property (nullable, nonatomic, retain) NSString *audioDownloadProgress;
@property (nullable, nonatomic, retain) NSData   *audioDownloadResumeData;

@end

NS_ASSUME_NONNULL_END
