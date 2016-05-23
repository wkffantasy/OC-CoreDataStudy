//
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
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateDataArray) name:kAudioEntityCoreDataChangeNonification object:nil];
  [self updateDataArray];
  
}
- (void)updateDataArray{
  
  NSArray * entityArray = [[AudioCoreDataTool shareInstance] fecthAllAudioEntity];
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
  
  AddDownloadTaskController * addVC = [[AddDownloadTaskController alloc]init];
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
  cell.textLabel.text= [NSString stringWithFormat:@"%@,%@",model.audioName,model.audioDownloadProgress];
  cell.detailTextLabel.text = model.audioUrl;
  
  return cell;
  
  
}


- (NSMutableArray *)dataArray{
  
  if (_dataArray == nil) {
    _dataArray = [NSMutableArray array];
  }
  return _dataArray;
  
}

@end
