//
//  WaitToDownloadModel.h
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DownloadTool.h"

@interface WaitToDownloadModel : NSObject

@property (nonatomic, copy) NSString *audioLocalPath;
@property (nonatomic, copy) NSString *audioName;
@property (nonatomic, copy) NSString *audioUrl;
@property (nonatomic, copy) NSString *audioDownloadProgress;
@property (nonatomic, strong) NSData   *audioDownloadResumeData;

@property (nonatomic, strong) DownloadTool * downloadMP3Tool;

@end
