//
//  ZMLocateHeaderView.m
//  ZhiMian
//
//  Created by king on 15/10/19.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "DJLLocateHeaderView.h"
#import "DJLLocateCell.h"

@implementation DJLLocateHeaderView
{
    UITableView* _tableView;
    NSArray* _headerStringArray;
    NSMutableArray* _dataSource;
}
-(void)setCityName:(NSString *)cityName
{
    _cityName = cityName;
    [_tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
}
-(instancetype)initWithSource:(NSMutableArray*)array
{
    if (self = [super init]) {
        //根据历史记录，设置表格头的高度
        _dataSource = array;
        CGSize size = [UIScreen  mainScreen].bounds.size;
        if (_dataSource.count < 4) {
            
            self.frame = CGRectMake(0, 0, size.width, 426);
        }else if (_dataSource.count > 3 && _dataSource.count < 7){
            self.frame = CGRectMake(0, 0, size.width, 426+60);
        }else{
            self.frame = CGRectMake(0, 0, size.width, 426+60+60);
        }
        
        //数据源
        [self createSource];
        //创建UI
        [self createTableView];
    }
    return self;
}
- (void)createSource
{
    
    _headerStringArray = @[@"当前定位城市",@"最近访问城市",@"热门城市"];
}
- (void)createTableView
{
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView registerClass:[DJLLocateCell class] forCellReuseIdentifier:@"locateHeaderCell"];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self addSubview:_tableView];
    
}
#pragma mark UITableViewDataSource,UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DJLLocateCell* cell = [tableView dequeueReusableCellWithIdentifier:@"locateHeaderCell" forIndexPath:indexPath];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    //将数据源存入cell中
    if (indexPath.section == 0) {
        NSArray* array = [[NSUserDefaults standardUserDefaults] objectForKey:@"selectCity"];
        //当前城市
        if (array != nil) {
            cell.itemsArray = @[[array lastObject]];
        }else{
            cell.itemsArray = @[];
        }
        
    }else if (indexPath.section == 1){
        //历史城市
        cell.itemsArray = _dataSource;
    }else{
        //热门城市
        cell.itemsArray = @[@"北京",@"上海",@"广州",@"深圳",@"武汉",@"天津",@"西安",@"南京",@"杭州",@"成都",@"重庆"];
    }
    //cell中选中的城市回调方法
    [cell setSelectCell:^(NSString * city) {
        
        self.selectCity(city);
    }];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        return 60;
    }else if (indexPath.section == 1){
        if (_dataSource.count < 4) {
            return 60;
        }else if (_dataSource.count > 3 && _dataSource.count < 7){
            return 120;
        }else{
            return 180;
        }
        
    }else{
        return 210;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, 32)];
    bgView.backgroundColor = [UIColor whiteColor];
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.frame.size.width, 32)];
    label.font = [UIFont systemFontOfSize:16];
    label.text = _headerStringArray[section];
    [bgView addSubview:label];
    return bgView;
}
@end
