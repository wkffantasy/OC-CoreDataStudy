//
//  PlayAndDownloadAudioController.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PlayAndDownloadAudioController.h"

#import "DownloadTool.h"

@interface PlayAndDownloadAudioController ()

@end

@implementation PlayAndDownloadAudioController

- (void)viewDidLoad {
  
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
  //http://sc.111ttt.com/up/mp3/186020/111C438ED73884CDFF9EC4C687E90C78.mp3
  //发如雪
  dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    
    DownloadTool * tool = [[DownloadTool alloc]initWithUrl:@"http://sc.111ttt.com/up/mp3/186020/111C438ED73884CDFF9EC4C687E90C78.mp3"];
    tool.finishedBlock = ^{
    
      NSLog(@"finished");
      
    };
    
    tool.downloadingBlock = ^(int64_t alreadyDownload,int64_t totalCount){
      
      NSLog(@"progress = %f",(double)alreadyDownload/totalCount);
      
    };
    tool.failedBlock = ^(NSError *error){
    
      NSLog(@"error %@",error.localizedDescription);
      
    };
    
    [tool startDownload];
    
    
  });
  
}


@end
