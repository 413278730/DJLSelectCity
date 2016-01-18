//
//  DJLLocateCell.h
//  DJLSelectCity
//
//  Created by 邓金龙 on 16/1/18.
//  Copyright © 2016年 邓金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DJLLocateCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>
@property (nonatomic,strong) NSArray* itemsArray;
@property (nonatomic,copy) void(^selectCell)(NSString* city);
@end
