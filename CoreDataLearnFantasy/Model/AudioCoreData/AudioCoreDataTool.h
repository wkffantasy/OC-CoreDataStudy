//
//  AudioCoreDataTool.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/23.
//  Copyright © 2016年 fantasy. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class AudioEntity;

typedef void(^HandleSuccessBlock)();
typedef void(^HandleFailedBlock)(NSString *failedString);
//typedef void(^FetchOneEntitySuccessBlock)(AudioEntity *entity);


@interface AudioCoreDataTool : NSObject

@property(strong, nonatomic) NSManagedObjectContext * managedObjectContext;

@property(strong, nonatomic) NSManagedObjectModel * managedObjectModel;

@property(strong, nonatomic) NSPersistentStoreCoordinator * persistenStoreCoordinatoe;

+ (instancetype)shareInstance;

//数据库操作
- (NSArray *)fecthAllAudioEntity;
- (BOOL)isHaveThisAudioEntity:(NSString *)url;
- (void)saveAudioEntity:(AudioEntity *)entity succeccBlock:(HandleSuccessBlock)success andFailedBlock:(HandleFailedBlock)failed;



@end
