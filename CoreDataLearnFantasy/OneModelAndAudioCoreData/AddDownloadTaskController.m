//
//  AddDownloadTaskController.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "AddDownloadTaskController.h"

#import "common.h"
#import "AudioEntity.h"
#import "AudioCoreDataTool.h"
#import "DownloadTool.h"

@interface AddDownloadTaskController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSDictionary * dataDict;
@property (weak, nonatomic) UITableView * tableView;

@end

@implementation AddDownloadTaskController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.view.backgroundColor = [UIColor whiteColor];
  self.title = @"第二个test 添加";
  self.automaticallyAdjustsScrollViewInsets = NO;
  [self setupTableViews];
  
}

- (void)setupTableViews{
  
  UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
  tableView.delegate = self;
  tableView.dataSource = self;
  _tableView = tableView;
  [self.view addSubview:tableView];
  
  
}
#pragma mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.dataDict.allKeys.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString * cellId = @"AddDownloadTaskController";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellId];
  }
  
  cell.textLabel.text = self.dataDict.allKeys[indexPath.row];
  cell.detailTextLabel.text = self.dataDict.allValues[indexPath.row];

  return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  AudioEntity * entity = [AudioEntity setupNewOne];
  entity.audioName = self.dataDict.allKeys[indexPath.row];
  entity.audioUrl  = self.dataDict.allValues[indexPath.row];
  [[AudioCoreDataTool shareInstance] saveAudioEntity:entity succeccBlock:^{
    
    NSLog(@"add audio entity success");
    
  } andFailedBlock:^(NSString *failedString) {
    
    NSLog(@"add audio entity failed %@",failedString);
    
  }];
  
}

- (NSDictionary *)dataDict{
  
  if (_dataDict == nil) {
    _dataDict = @{
                  
                  @"发如雪":@"http://sc.111ttt.com/up/mp3/186020/111C438ED73884CDFF9EC4C687E90C78.mp3",
                  
                  };
  }
  
  return _dataDict;
  
}

- (void)beganToDownload:(AudioEntity *)audio{
  
  DownloadTool * tool = [[DownloadTool alloc]initWithUrl:audio.audioUrl andFileName:audio.audioName];
  /**
   audio.audioName = @"发如雪";
   audio.audioUrl  = @"http://sc.111ttt.com/up/mp3/186020/111C438ED73884CDFF9EC4C687E90C78.mp3";
   */
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
