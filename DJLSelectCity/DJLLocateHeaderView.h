//
//  DJLLocateHeaderView.h
//  DJLSelectCity
//
//  Created by 邓金龙 on 16/1/18.
//  Copyright © 2016年 邓金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJLLocateHeaderView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) NSString* cityName;//当前定位城市
@property (nonatomic,copy) void(^selectCity)(NSString* city);
-(instancetype)initWithSource:(NSMutableArray*)array;

@end
