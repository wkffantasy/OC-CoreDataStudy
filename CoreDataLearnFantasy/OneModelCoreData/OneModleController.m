//
//  OneModleController.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/20.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "OneModleController.h"

#import "EditController.h"
#import "Common.h"

@interface OneModleController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSArray * dataArray;

@end

@implementation OneModleController

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  [self setNavigation];
  
  [self setupTableViews];
  
  [self needReloadData];
  
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(needReloadData) name:kPersonEntityCoreDataChangeNonification object:nil];
  
}

- (void)needReloadData{
  
  _dataArray = [[PersonCoreDataTool shareInstance] fecthAllPersonEntity];
  [self.tableView reloadData];
  
}

- (void)setupTableViews{
  
  UITableView * tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStylePlain];
  tableView.delegate = self;
  tableView.dataSource = self;
  _tableView = tableView;
  [self.view addSubview:tableView];
  
}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
  return self.dataArray.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString * cellId= @"learnCoreData";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
  }
  PersonEntity * entity = self.dataArray[indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"name=%@,id=%@",entity.name,entity.personId];
  cell.detailTextLabel.text = entity.phone;
  
  return cell;
  
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
  PersonEntity * entity = self.dataArray[indexPath.row];
  
  //改
  //  entity.name = @"电脑";
  //  [[PersonCoreDataTool shareInstance] saveContext];
  
  //查
  [[PersonCoreDataTool shareInstance] fetchAnPersonEntityAccordingID:entity.personId succeccBlock:^(PersonEntity *newEntity){
    
    NSLog(@"fetch success %@",newEntity.name);
    
  } andFailedBlock:^(NSString *failedString) {
    
    NSLog(@"fetch failed %@",failedString);
    
  }];
  //  if ([[PersonCoreDataTool shareInstance] isHaveThisPersonEntity:entity.personId]) {
  //
  //    NSLog(@"isHave");
  //
  //  } else {
  //
  //    NSLog(@"isNotHave");
  //
  //  }
  
  //删除
  //  [[PersonCoreDataTool shareInstance] deletePersonEntity:entity succeccBlock:^{
  //    NSLog(@"delete success");
  //  } andFailedBlock:^(NSString *failedString) {
  //    NSLog(@"delete failed %@",failedString);
  //  }];
  
  //  [[PersonCoreDataTool shareInstance] deletePersonEntityAccordingID:entity.personId succeccBlock:^{
  //
  //    NSLog(@"delete success");
  //
  //  } andFailedBlock:^(NSString *failedString) {
  //
  //    NSLog(@"delete failed %@",failedString);
  //
  //  }];
  
}


- (void)setNavigation{
  
  UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStylePlain target:self action:@selector(clickAddButton)];
  self.navigationItem.rightBarButtonItem = right;
  
}
- (void)clickAddButton{
  
  EditController * eVC = [[EditController alloc]init];
  [self.navigationController pushViewController:eVC animated:YES];
  
}


@end
