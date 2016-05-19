//
//  EditController.m
//  CoreDataLearnFantasy
//
//  Created by fantasy on 16/5/19.
//  Copyright © 2016年 fantasy. All rights reserved.
//

#import "EditController.h"

//lib or others
#import "common.h"

@interface EditController ()

@property (weak, nonatomic) UITextField * nameTextField;

@property (weak, nonatomic) UITextField * phoneTextField;

@property (weak, nonatomic) UITextField * idTextField;

@end

@implementation EditController

- (instancetype)init{
  
  if (self = [super init]) {
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
  }
  return self;
  
}

- (void)viewDidLoad{
  
  [super viewDidLoad];
  
  [self setNavigation];
  
  [self setupViews];
  
}


- (void)setNavigation{
  
  UIBarButtonItem * right = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(clickAddButton)];
  self.navigationItem.rightBarButtonItem = right;
  
  UIBarButtonItem * left = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(clickCancelButton)];
  self.navigationItem.leftBarButtonItem = left;
  
}

- (void)clickAddButton{
  
  NSAssert(_nameTextField.text.length > 0, @"");
  NSAssert(_idTextField.text.length > 0, @"");
  
#warning  数据库的增
  PersonEntity * entity = [PersonEntity instanceObject];
  entity.name = self.nameTextField.text;
  entity.phone = self.phoneTextField.text;
  entity.personId = self.idTextField.text;
  [entity save];
  [self.navigationController popViewControllerAnimated:YES];
  
}
- (void)clickCancelButton{
  
  [self.navigationController popViewControllerAnimated:YES];

}

- (void)setupViews{
  
  CGFloat textFieldHeight = 40;
  
  UITextField * textField1 = [[UITextField alloc]init];
  textField1.frame = CGRectMake(50, 50 + 64, kScreenWidth - 100, textFieldHeight);
  textField1.placeholder = @" 请输入姓名(不能为空)";
  [self setTextField:textField1];
  _nameTextField = textField1;
  [self.view addSubview:textField1];
  
  UITextField * textField2 = [[UITextField alloc]init];
  textField2.frame = CGRectMake(50, CGRectGetMaxY(_nameTextField.frame)+30, kScreenWidth - 100, textFieldHeight);
  
  textField2.placeholder = @" 请输入号码(可空)";
  [self setTextField:textField2];
  _phoneTextField = textField2;
  [self.view addSubview:textField2];
  
  UITextField * textField3 = [[UITextField alloc]init];
  textField3.frame = CGRectMake(50, CGRectGetMaxY(_phoneTextField.frame)+30, kScreenWidth - 100, textFieldHeight);
  
  textField3.placeholder = @" 请输入id(不可空)";
  [self setTextField:textField3];
  _idTextField = textField3;
  [self.view addSubview:textField3];
  
  
}

- (void)setTextField:(UITextField *)textField{
  
  textField.layer.masksToBounds = YES;
  textField.layer.cornerRadius = 5;
  textField.layer.borderWidth = 1;
  textField.layer.borderColor = [UIColor grayColor].CGColor;
  
}

@end
