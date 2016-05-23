//
//  PlayAndDownloadAudioController.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PlayAndDownloadAudioController.h"

#import "DownloadTool.h"
#import "AudioCoreDataTool.h"
#import "common.h"

#import "AudioEntity.h"

@interface PlayAndDownloadAudioController ()



@end

@implementation PlayAndDownloadAudioController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  
  AudioEntity * audio = [AudioEntity setUpNewObject];
  audio.audioName = @"发如雪";
  audio.audioUrl  = @"http://sc.111ttt.com/up/mp3/186020/111C438ED73884CDFF9EC4C687E90C78.mp3";
  
  [[AudioCoreDataTool shareInstance] saveAudioEntity:audio succeccBlock:^{
   
    NSLog(@"add audioEntity seccess");
    
  } andFailedBlock:^(NSString *failedString) {
    
    NSLog(@"failedString %@",failedString);
    
  }];
  
}

- (void)beganToDownload:(AudioEntity *)audio{
  
  DownloadTool * tool = [[DownloadTool alloc]initWithUrl:audio.audioUrl andFileName:audio.audioName];
  tool.finishedBlock = ^(DownloadTool * finishedDownloadTool){
    
    audio.audioLocalPath = finishedDownloadTool.localPath;
    
  };
  
  tool.pauseBlock = ^(NSData * resume){
    
    audio.audioDownloadResumeData = resume;
    
  };
  
  tool.downloadingBlock = ^(int64_t alreadyDownload,int64_t totalCount){
    
    NSLog(@"progress = %f",(double)alreadyDownload/totalCount);
    audio.audioDownloadProgress = @((double)alreadyDownload/totalCount);
    
  };
  tool.failedBlock = ^(NSError *error){
    
    NSLog(@"error %@",error.localizedDescription);
    
  };
  
  [tool startDownload];
  
}


@end
