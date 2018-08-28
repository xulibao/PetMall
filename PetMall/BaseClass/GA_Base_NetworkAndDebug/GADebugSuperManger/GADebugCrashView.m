//
//  GADebugCrashView.m
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//
#ifdef DEBUG

#import "GADebugCrashView.h"
#import "GADebugCrash.h"
#import "GADebugManager.h"

@interface GADebugCrashView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *crashes;
@property (nonatomic,strong) GADebugCrash *debugCrash;
@property (nonatomic,strong) UITableView *crashTableView;
@property (nonatomic,strong) UITextView *detailTextView;
@end
@implementation GADebugCrashView

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.debugCrash = [GADebugManager crashInstance];
        [self getCrashDate];
        // crash列表数据
//        self.crashes = [NSMutableArray arrayWithArray:[self.debugCrash crashes]];
        
        // crash列表
        self.crashTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.contentView.frame.size.width, self.contentView.frame.size.height - 50) style:UITableViewStylePlain];
        self.crashTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.crashTableView.delegate = self;
        self.crashTableView.dataSource = self;
        self.crashTableView.rowHeight = 40;
        self.crashTableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.crashTableView];
        
        // crash详情页
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
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.crashTableView.frame.size.width, 40)];
        
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = headerView.bounds;
        clearBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clearBtn setTitle:@"清除数据" forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:clearBtn];
        self.crashTableView.tableHeaderView = headerView;
        
        UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.crashTableView.frame.size.width, 40)];
        UIButton *clearBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn2.frame = headerView.bounds;
        clearBtn2.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [clearBtn2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clearBtn2 setTitle:@"清除数据" forState:UIControlStateNormal];
        [clearBtn2 addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [footerView addSubview:clearBtn2];
        self.crashTableView.tableFooterView = footerView;
        
        [self.crashTableView reloadData];
    }
    return self;
}
- (void)getCrashDate
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ; //得到documents的路径，为当前应用程序独享
    NSString *documentD = [paths objectAtIndex:0];
    NSString *configFile = [documentD stringByAppendingPathComponent:@"crashDebug.plist"];
    NSArray *crashArray = [NSArray arrayWithContentsOfFile:configFile];
    
    for (NSDictionary *dict in crashArray) {
    //    GACrashRequestModel *crashModel = [[GACrashRequestModel alloc] ];
    GADebugCrashModel *crashModel = [[GADebugCrashModel alloc] init];
    crashModel.page = dict[@"Controller"];
    crashModel.name = [NSString stringWithFormat:@"%@\n%@",dict[@"Exception Name"],dict[@"Exception Reason"]];
    
    NSDictionary *subDict = dict[@"Exception Parameters"];
    crashModel.version = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    crashModel.osversion = [[UIDevice currentDevice] systemVersion];
    crashModel.device = subDict[@"Device Information"];
    crashModel.network = dict[@"network"];
    crashModel.ip = dict[@"ip"];
    crashModel.name_iphone = dict[@"name_iphone"];
    crashModel.channel = @"测试使用";
    //crash时间
    crashModel.date = subDict[@"Error Occured Time"];
    
    crashModel.mark = [NSString stringWithFormat:@"Memory Information:%@; \nDisk Information:%@; \nmacAddress:%@; \nCPU Information:%@",subDict[@"Memory Information"], subDict[@"Disk Information"],subDict[@"macAddress"], subDict[@"CPU Information"]];
    NSMutableString *strM = [NSMutableString stringWithString:@""];
    for (NSString *strTemp in dict[@"Call Stack"]) {
        [strM appendString:strTemp];
        [strM appendString:@"\n"];
    }
    crashModel.stack = strM;
    [self.crashes addObject:crashModel];
    }
}
#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.crashes) {
        return self.crashes.count;
    }
    return self.crashes.count;
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
    GADebugCrashModel *model = [self.crashes objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@  %@",model.page,model.date];
    
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
    GADebugCrashModel *model = [self.crashes objectAtIndex:indexPath.row];
    
    NSMutableString *text = [NSMutableString stringWithFormat:@""];
    [text appendFormat:@"页面名称：\n%@\n\n",model.page];
    [text appendFormat:@"异常名称及原因：\n%@\n\n",model.name];
    [text appendFormat:@"app版本号：\n%@\n\n",model.version];
    [text appendFormat:@"系统版本号：\n%@\n\n",model.osversion];
    [text appendFormat:@"设备类型：\n%@\n\n",model.device];
    
    [text appendFormat:@"网络类型：\n%@\n\n",model.network]; // 网络类型
    [text appendFormat:@"渠道：\n%@\n\n",model.channel];
    [text appendFormat:@"ip地址：\n%@\n\n",model.ip];
    [text appendFormat:@"用户名：\n%@\n\n",model.name_iphone];
    [text appendFormat:@"crash时间：\n%@\n\n",model.date];
    [text appendFormat:@"设备状态：\n%@\n\n",model.mark];
    [text appendFormat:@"堆栈信息：\n%@\n\n",model.stack];
    self.detailTextView.text = text;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.contentView cache:YES];
    
    self.detailTextView.hidden = NO;
    self.crashTableView.hidden = YES;
    
    [UIView commitAnimations];
}

- (void)clearBtnClick:(id)sender{
    self.crashes = nil;
    // 暂时忽略
//    [[GADebugManager crashInstance] clearCrash];
    // 删除
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES) ; //得到documents的路径，为当前应用程序独享
    NSString *documentD = [paths objectAtIndex:0];
    NSString *configFile = [documentD stringByAppendingPathComponent:@"crashDebug.plist"];
    [[NSFileManager defaultManager] removeItemAtPath:configFile error:nil];
    [self.crashTableView reloadData];
}

- (void) closeBtnClick:(id)sender{
    if (self.detailTextView.hidden == NO) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.contentView cache:YES];
        
        self.detailTextView.hidden = YES;
        self.crashTableView.hidden = NO;
        
        [UIView commitAnimations];
    }else{
        self.crashTableView = nil;
        self.detailTextView = nil;
        self.crashes = nil;
        [super closeBtnClick:sender];
    }
}
- (NSMutableArray *)crashes
{
    if (_crashes == nil) {
        _crashes = [NSMutableArray arrayWithCapacity:3];
    }
    return _crashes;
}
@end

#endif
