//
//  NETableViewCell.h
//  dynamicCell
//
//  Created by hosa on 2017/3/20.
//  Copyright © 2017年 Sherlock. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NETableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView indexPaath:(NSIndexPath *)indexPath;
- (void)scrollCell:(UITableView *)tableView;
@end
