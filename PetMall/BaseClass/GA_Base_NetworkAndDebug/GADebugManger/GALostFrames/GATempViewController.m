//
//  GATempViewController.m
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/12/21.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GATempViewController.h"

@interface GATempViewController ()

@end

@implementation GATempViewController
static GATempViewController *instance_;
+ (instancetype)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance_ = [[self alloc] init];
        instance_.view.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 20);
    });
    return instance_;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
