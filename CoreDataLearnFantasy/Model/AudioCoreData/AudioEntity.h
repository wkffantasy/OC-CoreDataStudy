//
//  AudioEntity.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/23.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>


NS_ASSUME_NONNULL_BEGIN

/**
思路，存储model，对于mp3文件 不做存储，在返回cell的时候，新建一个model，这个model有
 downloadTool，而用coreData存储的model没有tool
 
 */

@interface AudioEntity : NSManagedObject

+ (NSString *)entityName;
+ (instancetype)setupNewOne;

@end

NS_ASSUME_NONNULL_END

#import "AudioEntity+CoreDataProperties.h"
