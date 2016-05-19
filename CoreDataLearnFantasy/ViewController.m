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
#import "PersonCoreDataManager.h"
#import "PersonEntity+CoreDataProperties.h"
#import "NSManagedObject+PersonObject.h"

@interface ViewController ()<NSFetchedResultsControllerDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) NSFetchedResultsController * fetchedResultsController;

@property (weak, nonatomic) UITableView * tableView;

@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
  
  [super viewWillAppear:animated];
  [self.tableView reloadData];
  
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
  
  return self.fetchedResultsController.fetchedObjects.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
  
  static NSString * cellId= @"learnCoreData";
  UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
  if (cell == nil) {
    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellId];
  }
  PersonEntity * entity = self.fetchedResultsController.fetchedObjects[indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"name=%@,id=%@",entity.name,entity.personId];
  cell.detailTextLabel.text = entity.phone;
  
  return cell;
  
}

- (void)setNavigation{
  
  UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"add" style:UIBarButtonItemStylePlain target:self action:@selector(clickAddButton)];
  self.navigationItem.rightBarButtonItem = right;
  
}
- (void)clickAddButton{
  
  EditController * eVC = [[EditController alloc]init];
  [self.navigationController pushViewController:eVC animated:YES];
  
}




#pragma mark - fetchedResultsController代理方法
- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
  
  for (PersonEntity * entity in self.fetchedResultsController.fetchedObjects) {
    NSLog(@"名字==%@",entity.name);
  }
  
}

- (NSFetchedResultsController *)fetchedResultsController{
  
  if (_fetchedResultsController == nil) {
    
    NSFetchRequest * request = [[NSFetchRequest alloc]initWithEntityName:[PersonEntity entityName]];
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"personId" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc]initWithFetchRequest:request managedObjectContext:[PersonCoreDataManager shareInstance].managedObjectContext sectionNameKeyPath:@"name" cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    NSError * error;
    [_fetchedResultsController performFetch:&error];
    if (error != nil) {
      NSLog(@"执行查询有错误%@",error);
    }
    
  }
  return _fetchedResultsController;
  
}

@end
