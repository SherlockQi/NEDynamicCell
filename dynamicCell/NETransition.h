//
//  NETransition.h
//  dynamicCell
//
//  Created by hosa on 2017/3/20.
//  Copyright © 2017年 Sherlock. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIViewControllerTransitioning.h>

@interface NETransition : NSObject<UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) CGRect rect;

@property (nonatomic, assign) BOOL present;

@property (nonatomic, strong) UIImage *topViewImage;
@end
