//
//  GADebugUILineView.m
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/12/7.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GADebugUILineView.h"
#import "GAUITestViewFrameManager.h"
@interface GADebugUILineView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *uiDateArray;
@property (nonatomic,strong) UITableView *UITableView;
@end
@implementation GADebugUILineView

+ (GADebugUILineView *)sharedInstance {
    static GADebugUILineView *debugBusinessLine = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        debugBusinessLine = [[GADebugUILineView alloc] init];
    });
    return debugBusinessLine;
}

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 30)];
        label.text = @"UI测试,提供给开发和UI使用,仅测试当前页面";
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        
        self.uiDateArray = @[@"打开",@"关闭",@"",@"请选择标线颜色,默认红色",@"红色",@"黑色",@"白色",@"随机"];
        
        // 请求列表
        self.UITableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, self.contentView.frame.size.width, self.contentView.frame.size.height - 100) style:UITableViewStylePlain];
        self.UITableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.UITableView.delegate = self;
        self.UITableView.dataSource = self;
        self.UITableView.rowHeight = 55;
        self.UITableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.UITableView];
        
        [self.UITableView reloadData];

    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.uiDateArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[UIView alloc] init];
        cell.textLabel.numberOfLines = 2;
        cell.selectedBackgroundView = [[UIView alloc] init];
        
    }
    if (indexPath.row % 2 == 0) {
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.1];
    }else{
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    }
    cell.textLabel.text = [self.uiDateArray objectAtIndex:indexPath.row];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            // 打开 - 延时 对线程优化
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [GAUITestViewFrameManager sharedInstance].isOpenUITest = YES;
                [[GAUITestViewFrameManager sharedInstance] testAllSubViews_UIWidthAndHeight:nil withLineColor:UITstColor_Red];
            });
        }
            break;
        case 1:
        {
            // 关闭
            [GAUITestViewFrameManager sharedInstance].isOpenUITest = NO;
            [[GAUITestViewFrameManager sharedInstance] removeAllTestUILine:nil];
        }
            break;
        case 4:
        {
            // 红色
            [[GAUITestViewFrameManager sharedInstance] testAllSubViews_UIWidthAndHeight:nil withLineColor:UITstColor_Red];
        }
            break;
        case 5:
        {
            // 黑色
            [[GAUITestViewFrameManager sharedInstance] testAllSubViews_UIWidthAndHeight:nil withLineColor:UITstColor_Black];
        }
            break;
        case 6:
        {
            // 白色
            [[GAUITestViewFrameManager sharedInstance] testAllSubViews_UIWidthAndHeight:nil withLineColor:UITstColor_White];
        }
            break;
        case 7:
        {
            // 白色
            [[GAUITestViewFrameManager sharedInstance] testAllSubViews_UIWidthAndHeight:nil withLineColor:UITstColor_Random];
        }
            break;
            
        default:
            break;
    }
}
@end
