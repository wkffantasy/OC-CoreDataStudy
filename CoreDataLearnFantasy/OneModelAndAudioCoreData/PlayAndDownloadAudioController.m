画//
//  PlayAndDownloadAudioController.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "PlayAndDownloadAudioController.h"

#import "AddDownloadTaskController.h"

#import "DownloadTool.h"
#import "AudioCoreDataTool.h"
#import "common.h"

#import "WaitToDownloadModel.h"
#import "AudioEntity.h"

@interface PlayAndDownloadAudioController ()<UITableViewDelegate,UITableViewDataSource>


@property (strong, nonatomic) NSMutableArray  * dataArray;
@property (weak, nonatomic) UITableView * tableView;

@end

@implementation PlayAndDownloadAudioController

- (void)viewDidLoad {
  
    [super viewDidLoad];
  
    self.view.backgroundColor = [UIColor whiteColor];
  
  self.automaticallyAdjustsScrollViewInsets = NO;
  self.title = @"第二个test 展示";
  [self settingNavigation];
  [self setupTableViews];
  
//  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDataArray) name:kAudioEntityCoreDataChangeNonification object:nil];
  [self updateDataArray];
  
}
- (void)updateDataArray{
  
  NSArray * entityArray = [[AudioCoreDataTool shareInstance] fecthAllAudioEntity];
  [self.dataArray removeAllObjects];
  for (AudioEntity * entity in entityArray) {
    
    WaitToDownloadModel * model = [[WaitToDownloadModel alloc]init];
    model.audioName = entity.audioName;
    model.audioUrl  = entity.audioUrl;
    model.audioDownloadProgress = [NSString stringWithFormat:@"%@",entity.audioDownloadProgress];
    model.audioLocalPath = entity.audioLocalPath;
    model.audioDownloadResumeData = entity.audioDownloadResumeData;
    [self.dataArray addObject:model];
  }
  [self.tableView reloadData];
  
}

- (void)settingNavigation{
  
  UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStylePlain target:self action:@selector(clickRightButton)];
  self.navigationItem.rightBarButtonItem = right;
  
}
- (void)clickRightButton{
  
  @weakify(self);
  AddDownloadTaskController * addVC = [[AddDownloadTaskController alloc]init];
  addVC.needReload = ^(){
  
    @strongify(self);
    [self updateDataArray];
    
  };
  [self.navigationController pushViewController:addVC animated:YES];
  
}

- (void)setupTableViews{
  
  UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
  tableView.delegate = self;
  tableView.dataSource = self;
  _tableView = tableView;
  [self.view addSubview:tableView];
  
}

#pragma  mark - <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.dataArray.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString * cellId = @"PlayAndDownloadAudioController";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellId];
  }
  
  WaitToDownloadModel * model = self.dataArray[indexPath.row];
  if (model.audioDownloadProgress == nil) {
    
    cell.textLabel.text = model.audioName;
  } else {
  
    cell.textLabel.text= [NSString stringWithFormat:@"%@,%@",model.audioName,model.audioDownloadProgress];
  
  }
  cell.detailTextLabel.text = model.audioUrl;
  
  return cell;
  
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  WaitToDownloadModel * model = self.dataArray[indexPath.row];
  if (model.audioDownloadProgress.floatValue != 100) {
    
    NSArray * entityArray = [[AudioCoreDataTool shareInstance] fecthAllAudioEntity];
    
    AudioEntity * entity = entityArray[indexPath.row];
    
    switch (model.downloadMP3Tool.downloadStatus) {
      case DownloadStatusNotBegan:
        [model.downloadMP3Tool startDownload];
        break;
      case DownloadStatusDoing:
        [model.downloadMP3Tool pause];
        break;
      case DownloadStatusIsPause:
        [model.downloadMP3Tool startDownload];
        break;
      
      default:
        break;
    }
    @weakify(model);
    model.downloadMP3Tool.finishedBlock = ^(DownloadTool * finishedDownloadTool){
      @strongify(model);
      model.audioLocalPath = finishedDownloadTool.localPath;
      entity.audioLocalPath = model.audioLocalPath;
      [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
      [[AudioCoreDataTool shareInstance].managedObjectContext save:nil];
    };
    
    model.downloadMP3Tool.pauseBlock = ^(NSData * resume){
      @strongify(model);
      model.audioDownloadResumeData = resume;
      entity.audioDownloadResumeData=resume;
      [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
      [[AudioCoreDataTool shareInstance].managedObjectContext save:nil];
    };
    
    model.downloadMP3Tool.downloadingBlock = ^(int64_t alreadyDownload,int64_t totalCount){
      @strongify(model);
      
      model.audioDownloadProgress = [NSString stringWithFormat:@"%.2f\%%",(double)alreadyDownload/totalCount * 100];
      entity.audioDownloadProgress = model.audioDownloadProgress;
      [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
      [[AudioCoreDataTool shareInstance].managedObjectContext save:nil];
      
    };
    model.downloadMP3Tool.failedBlock = ^(NSError *error){
      
      NSLog(@"error %@",error.localizedDescription);
      
    };
    
    
  } else {
    
    //播放
    
  }
  
  
}


- (NSMutableArray *)dataArray{
  
  if (_dataArray == nil) {
    _dataArray = [NSMutableArray array];
  }
  return _dataArray;
  
}

@end
