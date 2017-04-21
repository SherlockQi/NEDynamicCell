//
//  NETransition.m
//  dynamicCell
//
//  Created by hosa on 2017/3/20.
//  Copyright © 2017年 Sherlock. All rights reserved.
//
#import "NETransition.h"
//#import <UIKit/UIViewControllerTransitioning.h>
#import "NEDetailTableViewController.h"
#import "ViewController.h"
@interface NETransition()

//@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIView *midView;
@property (nonatomic, strong) UIView *botView;


@end
@implementation NETransition
- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (NSTimeInterval)transitionDuration:(nullable id <UIViewControllerContextTransitioning>)transitionContext{
    return 1.0;
}


- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
    
    if (self.present) {//present
        [self presentAnimateTransition:transitionContext];
    }else{//dismiss
        [self dismissAnimateTransition:transitionContext];
    }
    
}
- (void)presentAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //toViewController:即B视图控制器
    NEDetailTableViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //toView:B视图控制器的view
    UITableView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //containView:可以理解为它管理着所有做转场动画的视图，必须将toView加入到其中
    UIView *containView = [transitionContext containerView];
   
    

    
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    NSLog(@"%f",duration);
   
    if (containView != nil && toView != nil && toViewController != nil) {
        
        toView.frame = [transitionContext finalFrameForViewController:toViewController];
        [containView addSubview:toView];
        
        
        UIView *midView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.rect), self.rect.size.width, toView.bounds.size.height - CGRectGetMaxY(self.rect))];
        midView.backgroundColor = [UIColor whiteColor];
        [containView addSubview:midView];
        
        
        UIView *bottomView = [[UIView alloc]initWithFrame:CGRectMake(0, toView.bounds.size.height, self.rect.size.width, toView.bounds.size.height- 2*self.rect.size.height)];
        bottomView.backgroundColor = [UIColor orangeColor];
        [containView addSubview:bottomView];
        


        [containView insertSubview:self.topView atIndex:999];

        self.midView = midView;
        self.botView = bottomView;
        toViewController.bottomView = bottomView;
        
        [UIView animateWithDuration:0.8 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
            self.topView.frame = CGRectMake(0, 0, self.rect.size.width, self.rect.size.height);
            midView.frame = CGRectMake(0, self.rect.size.height, self.rect.size.width, self.rect.size.height);
            bottomView.frame = CGRectMake(0, CGRectGetMaxY(midView.frame), self.rect.size.width, toView.bounds.size.height- 2*self.rect.size.height);
        } completion:^(BOOL finished) {
            toView.tableHeaderView = self.topView;
            [transitionContext completeTransition:finished];
        }];
    }
}

- (void)dismissAnimateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    //toViewController:即B视图控制器
    ViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //toView:B视图控制器的view
    UITableView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    //containView:可以理解为它管理着所有做转场动画的视图，必须将toView加入到其中
    UIView *containView = [transitionContext containerView];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    NSLog(@"%f",duration);

    

    [UIView animateWithDuration:1.2 delay:0 options:UIViewAnimationOptionLayoutSubviews animations:^{
    
        self.midView.frame = self.rect;
        self.botView.frame = self.rect;
        self.topView.frame = self.rect;

        self.midView.alpha = 0;
        self.botView.alpha = 0;

        
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:finished];

    }];
    

}

- (void)setTopView:(UIView *)topView{
    _topView = topView;
    _topView.frame = self.rect;
}





//- (id <UIViewImplicitlyAnimating>) interruptibleAnimatorForTransition:(id <UIViewControllerContextTransitioning>)transitionContext NS_AVAILABLE_IOS(10_0){
//    return nil;
//}

// This is a convenience and if implemented will be invoked by the system when the transition context's completeTransition: method is invoked.
//- (void)animationEnded:(BOOL) transitionCompleted{
//
//}
@end
