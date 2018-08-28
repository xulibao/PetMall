//
//  GALostFramesView.m
//  GA_Base_FrameWork
//
//  Created by GhGh on 15/12/18.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "GALostFramesView.h"
#import "KMCGeigerCounter.h"
@interface GALostFramesView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSArray *uiDateArray;
@property (nonatomic,strong) UITableView *UITableView;
@end
@implementation GALostFramesView
- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 50, [UIScreen mainScreen].bounds.size.width, 30)];
        label.text = @"丢帧测试,提供给开发流程行测试使用";
        label.textColor = [UIColor redColor];
        label.font = [UIFont systemFontOfSize:15];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        
        self.uiDateArray = @[@"打开",@"",@"关闭"];
        
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
    if (indexPath.row == 0) {
        [KMCGeigerCounter sharedGeigerCounter].enabled = YES;
    }else
    {
        [KMCGeigerCounter sharedGeigerCounter].enabled = NO;
        
    }
}
@end
