//
//  ViewController.m
//  SelectCity
//
//  Created by 邓金龙 on 16/1/18.
//  Copyright © 2016年 邓金龙. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"
#import "DJLLocateHeaderView.h"
#import "DJLHomeViewController.h"

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController
{
    NSMutableDictionary* _cities;
    NSMutableArray* _keys;
    DJLLocateHeaderView* _headerView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    _keys = [[NSMutableArray alloc] init];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"statusBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [self getCityData];//获取城市信息
    [self createTableView];//创建表格
    
}
#pragma mark 获取城市信息
-(void)getCityData
{
    //读取plist文件
    NSString *path=[[NSBundle mainBundle] pathForResource:@"citydict" ofType:@"plist"];
    //所有城市
    _cities = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    //所有城市分类的首字母，排序
    [_keys addObjectsFromArray:[[_cities allKeys] sortedArrayUsingSelector:@selector(compare:)]];
}
#pragma mark 创建UI
- (void)createTableView
{
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cityCell"];
    [_tableView setTableFooterView:[[UIView alloc] initWithFrame:CGRectZero]];
    _tableView.sectionIndexColor = [UIColor blackColor];//设置表格所用颜色
    
    
    _headerView = [[DJLLocateHeaderView alloc] initWithSource:[[[NSUserDefaults standardUserDefaults] objectForKey:@"selectCity"] mutableCopy]];//作为表格头的数据源
    __weak ViewController* wSeaf = self;
    [_headerView setSelectCity:^(NSString *city) {
        [wSeaf saveCityHistory:city];
    }];
    //表格头
    [_tableView setTableHeaderView:_headerView];
    
}
#pragma mark 保存历史选中城市的记录
- (void)saveCityHistory:(NSString*)city
{
    NSMutableArray* selectCitys = [[[NSUserDefaults standardUserDefaults] objectForKey:@"selectCity"] mutableCopy];
    if (selectCitys == nil) {
        NSMutableArray* array = [[NSMutableArray alloc] init];
        [array addObject:city];
        [[NSUserDefaults standardUserDefaults] setObject:array forKey:@"selectCity"];
    }else{
        if (selectCitys.count < 6) {
            [selectCitys addObject:city];
            [[NSUserDefaults standardUserDefaults] setObject:selectCitys forKey:@"selectCity"];
        }else{
            [selectCitys removeObjectAtIndex:0];
        }
    }
    if ([self.delegate respondsToSelector:@selector(selectCity:)]) {
        [self.delegate selectCity:city];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _keys.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray* array = _cities[_keys[section]];
    return array.count;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cityCell" forIndexPath:indexPath];
    NSArray* array = _cities[_keys[indexPath.section]];
    cell.textLabel.text = array[indexPath.row];
    cell.textLabel.textColor = UIColorFromRGB(0x666666);
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 32;
}
- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView* bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 32)];
    bgView.backgroundColor = UIColorFromRGB(0xf0f0f0);
    
    UILabel* label = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.view.frame.size.width-30, 32)];
    label.font = [UIFont systemFontOfSize:15];
    label.text = _keys[section];
    label.textColor = UIColorFromRGB(0x666666);
    [bgView addSubview:label];
    return bgView;
}
//显示表格右边索引集合
- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return _keys;
}
//选中索引回调方法
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    MBProgressHUD *hub = [[MBProgressHUD alloc] initWithView:self.view];
    hub.mode = MBProgressHUDModeCustomView;
    hub.labelFont = [UIFont systemFontOfSize:16];
    hub.labelText = title;
    hub.minShowTime = 0.5;
    [self.view addSubview:hub];
    [hub showAnimated:YES whileExecutingBlock:^{
        
    } completionBlock:^{
        [hub removeFromSuperview];
    }];
    
    return index;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray* cityArray = _cities[_keys[indexPath.section]];
    [self saveCityHistory:cityArray[indexPath.row]];
    
}
#pragma mark -
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
