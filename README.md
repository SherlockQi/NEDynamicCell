# NEDynamicCell


   



![image](https://github.com/SherlockQi/NEDynamicCell/blob/master/cell.gif )   


####原理:
1. 监听 tableView 滚动
2. 改变 cell 中图片的 frame

实现:
自定义 cell 
imageView 的上下约束要超过 cell 的 contentView

![imageView的约束](http://upload-images.jianshu.io/upload_images/1721249-5319e516b6428e56.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

监听滚动
```
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //可见 cell 
    NSArray<NETableViewCell*> *visibleCells = self.tableView.visibleCells;
    [visibleCells enumerateObjectsUsingBlock:^(NETableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //调用 cell 的方法,改变图片位置     
   [obj scrollCell:self.tableView];
    }];
}
```

cell 中改变图片 frame的方法
```
- (void)scrollCell:(UITableView *)tableView{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    //当前 cell 在 window上的位置
    CGRect rect = [tableView convertRect:self.frame toView:window];
    //window 中心和 cell 下端的距离
    float distanceCenter = CGRectGetHeight(window.frame)/2 - CGRectGetMinY(rect);
    //cell 和 图片的高度差(imageView 要高于 cell )
    float difference = CGRectGetHeight(self.backImageView.frame) - CGRectGetHeight(self.frame);
    //imageView 需要偏移的量
    float imageMove = (distanceCenter / CGRectGetHeight(window.frame)) * difference;
    //新的 frame
    CGRect imageRect = self.backImageView.frame;
    imageRect.origin.y = imageMove - (difference/2);
    self.backImageView.frame = imageRect;
}
```
剪切掉超出cell 的图片
```
-(void)awakeFromNib{
    [super awakeFromNib];
    self.clipsToBounds = YES;
}
```


这样就可以实现效果了
注意:
一.页面跳动
但是在运行时会发现,在第一次滚动时页面会进行一次调整,页面会跳一下.
我们在页面显示完成后主动调用一下scrollViewDidScroll 方法就可以解决;
```
//视图加载完在调用scrollViewDidScroll方法
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self scrollViewDidScroll:self.tableView];
}
```
二.分割线
为了让 cell 分开,自定义了 cell 分割线
但是在点击 cell 时 分割线会变透明,如图

解决:
```
 cell.selectionStyle = UITableViewCellSelectionStyleNone;
```




