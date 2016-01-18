//
//  DJLLocateCell.m
//  DJLSelectCity
//
//  Created by 邓金龙 on 16/1/18.
//  Copyright © 2016年 邓金龙. All rights reserved.
//

#import "DJLLocateCell.h"

@implementation DJLLocateCell
{
    UICollectionView* _collectionView;
    NSMutableArray* _dataSource;
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建UI
        [self createCollectionView];
    }
    return self;
}
-(void)setItemsArray:(NSArray *)itemsArray
{
    //当数据源有值是，应刷新collectionView
    _dataSource = [itemsArray mutableCopy];
    [_collectionView reloadData];
}
- (void)createCollectionView
{
    //布局方式
    UICollectionViewFlowLayout *flowLayout= [[UICollectionViewFlowLayout alloc] init];
    flowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;//滚动方向
    flowLayout.itemSize = CGSizeMake(98, 40);//item的大小
    flowLayout.sectionInset = UIEdgeInsetsMake(10, 10, 16, 16);//设置section的边距
    
    //第二个参数是cell的布局
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width-15, 210) collectionViewLayout:flowLayout];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    _collectionView.scrollEnabled = NO;
    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"locationCollectionCell"];
    [self.contentView addSubview:_collectionView];
}

#pragma mark UICollectionViewDataSource & UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataSource.count;
}
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"locationCollectionCell" forIndexPath:indexPath];
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 98, 40)];
    label.font = [UIFont systemFontOfSize:16];
    label.text = _dataSource[indexPath.row];
    label.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:label];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //选中item，通过block将数据回调出去
    self.selectCell(_dataSource[indexPath.row]);
}
#pragma mark -
- (void)awakeFromNib {
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
}
@end

