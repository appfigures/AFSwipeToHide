//
//  AFRootTableViewController.m
//  AFSwipeToHide
//
//  Created by dw_iOS iOS软件工程师 曾宪华 QQ：543413507 on 14-11-18.
//  Copyright (c) 2014年 Oz. All rights reserved.
//

#import "AFRootTableViewController.h"
#import "ViewController.h"
#import "ControllerNameItem.h"

@interface AFRootTableViewController ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation AFRootTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"AFSwipeToHide";
    
    self.dataSource = [[ControllerNameItem newDataSource] mutableCopy];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    // Configure the cell...
    ControllerNameItem *item = self.dataSource[indexPath.row];
    cell.textLabel.text = item.title;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"DetailViewController"];
    if (viewController) {
        viewController.item = self.dataSource[indexPath.row];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
