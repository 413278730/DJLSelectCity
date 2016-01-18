//
//  ViewController.h
//  DJLSelectCity
//
//  Created by 邓金龙 on 16/1/18.
//  Copyright © 2016年 邓金龙. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

- (void)selectCity:(NSString*)city;

@end

@interface ViewController : UIViewController

@property (nonatomic,assign) id<ViewControllerDelegate> delegate;

@end

