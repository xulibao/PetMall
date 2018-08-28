//
//  GADebugAdsView.m
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//
// 内存检测
#import "GADebugAdsView.h"
@interface GADebugAdsView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *leakArrayM;
@property (nonatomic,strong) UITableView *leakTableView;
@property (nonatomic,strong) UITextView *detailTextView;
@end
@implementation GADebugAdsView

+ (GADebugAdsView *)sharedInstance {
    static GADebugAdsView *debugAds = nil;
    static dispatch_once_t once_t;
    dispatch_once(&once_t, ^{
        debugAds = [[GADebugAdsView alloc] init];
    });
    return debugAds;
}

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self getLeakDate];
        self.leakTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.contentView.frame.size.width, self.contentView.frame.size.height - 50) style:UITableViewStylePlain];
        self.leakTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.leakTableView.delegate = self;
        self.leakTableView.dataSource = self;
        self.leakTableView.rowHeight = 45;
        self.leakTableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.leakTableView];
        
        // leak详情页
        // 详情页
        self.detailTextView = [[UITextView alloc] initWithFrame:self.contentView.bounds];
        self.detailTextView.editable = NO;
        self.detailTextView.textColor = [UIColor whiteColor];
        self.detailTextView.backgroundColor = [UIColor clearColor];
        self.detailTextView.font = [UIFont systemFontOfSize:14.0];
        self.detailTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self.contentView addSubview:self.detailTextView];
        self.detailTextView.hidden = YES;
        
        //清除按钮
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.leakTableView.frame.size.width, 40)];
        
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = headerView.bounds;
        clearBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clearBtn setTitle:@"清除数据" forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:clearBtn];
        self.leakTableView.tableHeaderView = headerView;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.leakTableView.frame.size.width, 40)];
        UIButton *clearBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn2.frame = headerView.bounds;
        clearBtn2.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [clearBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clearBtn2 setTitle:@"清除数据" forState:UIControlStateNormal];
        [clearBtn2 addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:clearBtn2];
        self.leakTableView.tableFooterView = footerView;
        
        [self.leakTableView reloadData];
    }
    return self;
}
- (void)getLeakDate
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ; //得到documents的路径，为当前应用程序独享
    NSString *documentD = [paths objectAtIndex:0];
    NSString *configFile = [documentD stringByAppendingPathComponent:@"ghLeakDebug.plist"];
    NSArray *tempArray = [NSArray arrayWithContentsOfFile:configFile];

    [self.leakArrayM addObjectsFromArray:tempArray];
}
#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.leakArrayM) {
        return self.leakArrayM.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"RequestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[UIView alloc] init];
        cell.textLabel.numberOfLines = 2;
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.selectedBackgroundView = [[UIView alloc] init];
        
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    }
 
    NSDictionary *dict = self.leakArrayM[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ \n%@",dict[@"title"], dict[@"time"]];
//    @"message"
    if (indexPath.row % 2 == 0) {
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }else{
        cell.backgroundView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
    }
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = self.leakArrayM[indexPath.row];
    NSString *tipsStr = @"- (BOOL)willDealloc {\n       return NO;\n   }";
    self.detailTextView.text = [NSString stringWithFormat:@"\n%@ \n%@\n\n详情：\n%@\n\n如果当前对象是单利对象可以在.m文件中添加:\n%@",dict[@"title"], dict[@"time"], dict[@"message"],tipsStr];
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.contentView cache:YES];
    
    self.detailTextView.hidden = NO;
    self.leakTableView.hidden = YES;
    
    [UIView commitAnimations];
}

- (void)clearBtnClick:(id)sender{
    self.leakArrayM = nil;
    // 删除
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ; //得到documents的路径，为当前应用程序独享
    NSString *documentD = [paths objectAtIndex:0];
    NSString *configFile = [documentD stringByAppendingPathComponent:@"ghLeakDebug.plist"];
    [[NSFileManager defaultManager] removeItemAtPath:configFile error:nil];
    [self.leakTableView reloadData];
}
#pragma mark - 底部按钮
- (void)closeBtnClick:(id)sender{
    if (self.detailTextView.hidden == NO) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.contentView cache:YES];
        
        self.detailTextView.hidden = YES;
        self.leakTableView.hidden = NO;
        
        [UIView commitAnimations];
    }else{
        self.leakTableView = nil;
        self.detailTextView = nil;
        [super closeBtnClick:sender];
    }
}

- (NSMutableArray *)leakArrayM
{
    if (_leakArrayM == nil) {
        _leakArrayM = [NSMutableArray arrayWithCapacity:3];
    }
    return _leakArrayM;
}
@end
