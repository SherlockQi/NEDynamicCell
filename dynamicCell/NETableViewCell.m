//
//  NETableViewCell.m
//  dynamicCell
//
//  Created by hosa on 2017/3/20.
//  Copyright © 2017年 Sherlock. All rights reserved.
//

#import "NETableViewCell.h"

@interface NETableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;
@end

static  NSString  *const kCellID = @"NETableViewCell";
@implementation NETableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tableView indexPaath:(NSIndexPath *)indexPath{
    
    NETableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellID];
    if (!cell) {
        cell = [[NSBundle mainBundle]loadNibNamed:NSStringFromClass(self) owner:nil options:nil].firstObject;
    }
    cell.backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",indexPath.row]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)scrollCell:(UITableView *)tableView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [tableView convertRect:self.frame toView:window];
    
    float distanceCenter = CGRectGetHeight(window.frame)/2 - CGRectGetMinY(rect);
    float difference = CGRectGetHeight(self.backImageView.frame) - CGRectGetHeight(self.frame);
    float imageMove = (distanceCenter / CGRectGetHeight(window.frame)) * difference;
    CGRect imageRect = self.backImageView.frame;
    imageRect.origin.y = imageMove - (difference/2);
    self.backImageView.frame = imageRect;
}
-(void)awakeFromNib{
    [super awakeFromNib];
    self.clipsToBounds = YES;
}



@end
