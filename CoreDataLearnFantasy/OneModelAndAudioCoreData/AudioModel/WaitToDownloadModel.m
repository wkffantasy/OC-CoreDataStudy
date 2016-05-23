//
//  WaitToDownloadModel.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "WaitToDownloadModel.h"

@implementation WaitToDownloadModel

- (DownloadTool *)downloadMP3Tool{
  
  if (_downloadMP3Tool == nil) {
    
    _downloadMP3Tool = [[DownloadTool alloc]initWithUrl:self.audioUrl andFileName:self.audioName andResumeData:self.audioDownloadResumeData];
    
  }
  return _downloadMP3Tool;
  
}

@end
