//
//  DJLHomeViewController.m
//  DJLSelectCity
//
//  Created by 邓金龙 on 16/1/18.
//  Copyright © 2016年 邓金龙. All rights reserved.
//

#import "DJLHomeViewController.h"
#import "ViewController.h"

@interface DJLHomeViewController ()<ViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation DJLHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"statusBar.png"] forBarMetrics:UIBarMetricsDefault];

}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // segue.identifier：获取连线的ID
    if ([segue.identifier isEqualToString:@"pushSegue"]) {
        ViewController *vc = segue.destinationViewController;
        vc.delegate = self;
    }
}

-(void)selectCity:(NSString *)city
{
    self.label.text = [NSString stringWithFormat:@"选则的城市：%@",city];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
