//
//  ViewController.m
//  dynamicCell
//
//  Created by hosa on 2017/3/20.
//  Copyright © 2017年 Sherlock. All rights reserved.
//

#import "ViewController.h"
#import "NETableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController
//视图加载完在调用scrollViewDidScroll方法
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NETableViewCell *cell = [NETableViewCell  cellWithTableView:tableView indexPaath:indexPath];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    NSArray<NETableViewCell*> *visibleCells = self.tableView.visibleCells;
    [visibleCells enumerateObjectsUsingBlock:^(NETableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj scrollCell:self.tableView];
    }];
}
@end
