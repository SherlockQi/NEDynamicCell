//
//  ViewController.m
//  dynamicCell
//
//  Created by hosa on 2017/3/20.
//  Copyright © 2017年 Sherlock. All rights reserved.
//

#import "ViewController.h"
#import "NETableViewCell.h"
#import "NEDetailTableViewController.h"
#import "NETransition.h"
//#import "DHSmartScreenshot.h"
#import "UIView+DHSmartScreenshot.h"

@interface ViewController ()<UIViewControllerTransitioningDelegate>

//@property (nonatomic, strong) NETableViewCell *selectCell;
@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) NETransition *transition;
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NEDetailTableViewController *detailViewC = [[NEDetailTableViewController alloc]init];
    detailViewC.modalPresentationStyle = UIModalPresentationCustom;
    detailViewC.transitioningDelegate = self;
    self.indexPath = indexPath;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self presentViewController:detailViewC animated:YES completion:nil];
    });
}

//MARK: - UIViewControllerTransitioningDelegate
- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    
    self.transition = [[NETransition alloc]init];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect cellFrame = [self.tableView rectForRowAtIndexPath:self.indexPath];
    NETableViewCell *cell = [self.tableView cellForRowAtIndexPath:self.indexPath];
    CGRect rect = [self.tableView convertRect:cellFrame toView:window];
    NSLog(@"%@",NSStringFromCGRect(rect));
    self.transition.rect = rect;
    self.transition.present = YES;
    self.transition.topView = [cell snapshotViewAfterScreenUpdates:YES];
    return self.transition;
}


- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{

    self.transition.present = NO;
    return self.transition;
}











//- (nullable id <UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed{
//    return nil;
//}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
//    return nil;
//}

//- (nullable id <UIViewControllerInteractiveTransitioning>)interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
//    return nil;
//}

//- (nullable UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(nullable UIViewController *)presenting sourceViewController:(UIViewController *)source NS_AVAILABLE_IOS(8_0){
//    return nil;
//}



 @end
