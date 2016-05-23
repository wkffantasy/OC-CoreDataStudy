//
//  AudioEntity+CoreDataProperties.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/23.
//  Copyright © 2016年 fantasy. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "AudioEntity+CoreDataProperties.h"

@implementation AudioEntity (CoreDataProperties)

@dynamic audioLocalPath;
@dynamic audioName;
@dynamic audioUrl;
@dynamic audioDownloadProgress;
@dynamic audioDownloadResumeData;

@end
