//
//  DCGoodCommentViewController.m
//  CDDMall
//
//  Created by apple on 2017/6/21.
//  Copyright © 2017年 RocketsChen. All rights reserved.
//

#import "DCGoodCommentViewController.h"

// Controllers

// Models
//#import "DCCommentsItem.h"
#import "PMMyCommentItem.h"

// Views
#import "DCComHeadView.h"
#import "DCCommentsCntCell.h"
// Vendors
#import <MJExtension.h>
// Categories

// Others

@interface DCGoodCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

/* tableView */
@property (strong , nonatomic)UITableView *tableView;

/* DCComHeadView */
@property (strong , nonatomic)DCComHeadView *headView;

/* 评论数据 */
@property (strong , nonatomic)NSMutableArray<PMMyCommentItem *> *commentsItem;

@end

static NSString *const DCCommentsCntCellID = @"DCCommentsCntCell";

@implementation DCGoodCommentViewController

#pragma mark - LazyLoad
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.frame = CGRectMake(0, 0, ScreenW, ScreenH - 55);
        
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
        
        //注册
        [_tableView registerNib:[UINib nibWithNibName:NSStringFromClass([DCCommentsCntCell class]) bundle:nil] forCellReuseIdentifier:DCCommentsCntCellID];
    }
    return _tableView;
}

- (NSMutableArray<PMMyCommentItem *> *)commentsItem{
    if (!_commentsItem) {
        _commentsItem = [NSMutableArray array];
    }
    return _commentsItem;
}

#pragma mark - LifeCyle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"商品评价";
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.backgroundColor = DCBGColor;
    [self setUpHeadView];

    [self fecthData];
    
}

- (void)fecthData{
    if ([SAApplication userID] == nil) {
        [self showWaring:@"请先登录"];
        return;
    }   

    [self requestPOST:API_Dogfood_evaluation parameters:@{@"pagenum":@"1",@"user_id":[SAApplication userID],@"pagesize":@"10",@"user_goods":self.user_goods} success:^(__kindof SARequest *request, id responseObject) {
        self.headView.tipLabel.text =  [NSString stringWithFormat:@"%@%%好评",responseObject[@"result"][@"shul"][@"package_ok"]];
        self.headView.percentageLabel.text = [NSString stringWithFormat:@"(%@)",responseObject[@"result"][@"shul"][@"package_pl"]];
        self.commentsItem = [PMMyCommentItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"comment"]];
        [self.tableView reloadData];
    } failure:NULL];
}


#pragma mark - 头部视图
- (void)setUpHeadView{
    _headView = [DCComHeadView new];
    _headView.dc_height = 140;
    WEAKSELF
    _headView.comTypeBlock = ^(NSInteger index) {
        if (index == 2) { //中评论
            weakSelf.commentsItem = [PMMyCommentItem mj_objectArrayWithFilename:@"CommentBadData.plist"];
        }else{
            weakSelf.commentsItem = [PMMyCommentItem mj_objectArrayWithFilename:@"CommentData.plist"];
        }
        [weakSelf.tableView reloadData];
        [[NSNotificationCenter defaultCenter]postNotificationName:@"UpDataImageView" object:nil];
    };
    self.tableView.tableHeaderView = _headView;
}

#pragma mark - <UITableViewDataSource>
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _commentsItem.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DCCommentsCntCell *cell = [tableView dequeueReusableCellWithIdentifier:DCCommentsCntCellID forIndexPath:indexPath];
    cell.commentsItem = _commentsItem[indexPath.row];
    return cell;
}



#pragma mark - <UITableViewDelegate>
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return _commentsItem[indexPath.row].cellHeight;
}

@end
