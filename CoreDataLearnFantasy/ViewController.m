//
//  ViewController.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "ViewController.h"

//controller
#import "EditController.h"
#import "Common.h"



@interface ViewController ()<NSFetchedResultsControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) UITableView * tableView;
@property (strong, nonatomic) NSArray * dataArray;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
  
  [super viewWillAppear:animated];
  
  if (_dataArray != [[PersonCoreDataTool shareInstance] fecthAllPersonEntity]) {
    
    _dataArray = [[PersonCoreDataTool shareInstance] fecthAllPersonEntity];
    [self.tableView reloadData];
    NSLog(@"self.tableView reloadData");
  }
  
}

- (void)viewDidLoad {
  
  [super viewDidLoad];
  
  self.automaticallyAdjustsScrollViewInsets = NO;
  
  [self setNavigation];
  
  [self setupTableViews];
  
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
