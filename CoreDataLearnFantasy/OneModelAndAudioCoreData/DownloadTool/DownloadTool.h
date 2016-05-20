//
//  DownloadTool.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger,DownloadToolStatus) {

  DownloadStatusNotBegan = 0,//没开始下载
  DownloadStatusDoing,//正在下载
  DownloadStatusIsPause,//下载暂停
  DownloadStatusHaveFinished,//下载完成
  DownloadStatusFailed,//下载失败
};

typedef void(^FinishedDownloadBlock)();
typedef void(^DownloadingBlock)(int64_t alreadyDownload,int64_t totalCount);
typedef void(^DownloadFailedBlock)(NSError *error);

@interface DownloadTool : NSObject

- (instancetype)initWithUrl:(NSString *)downloadUrl;

/**
 *  resumeData记录上一次下载位置
 */
@property (strong, nonatomic) NSData* resumeData;
@property (copy, nonatomic) NSString * localPath;
@property (assign, nonatomic) DownloadToolStatus downloadStatus;
@property (copy, nonatomic) FinishedDownloadBlock finishedBlock;
@property (copy, nonatomic) DownloadingBlock downloadingBlock;
@property (copy, nonatomic) DownloadFailedBlock failedBlock;

- (void)startDownload;//开始下载
- (void)pause;//暂停
- (void)goonDownload;//继续下载


@end
