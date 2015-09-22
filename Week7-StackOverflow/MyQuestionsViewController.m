//
//  MyQuestionsViewController.m
//  Week7-StackOverflow
//
//  Created by Joey Nessif on 9/15/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

#import "MyQuestionsViewController.h"

@interface MyQuestionsViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation MyQuestionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.tableView.dataSource = self;
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return 35;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
  static NSString *fontName = @"Copperplate";
  static int fontSize = 10;
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MyQuestionCell" forIndexPath:indexPath];
  
  cell.textLabel.font = [UIFont fontWithName:fontName size:fontSize];
  if (indexPath.row == 4) {
    cell.textLabel.text = @"    You have not asked any questions.";
  }
  cell.backgroundColor = [UIColor lightGrayColor];
  
  return cell;
}

@end
