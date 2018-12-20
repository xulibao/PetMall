//
//  PMTimeLimitViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/16.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMTimeLimitViewController.h"
#import "PMTimeLimitItem.h"
#import "PMTimeLimitCell.h"
#import "DCGoodBaseViewController.h"
@interface PMTimeLimitViewController ()

@end

@implementation PMTimeLimitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"限时秒杀";
    [self requestPOST:API_Dogfood_presale parameters:@{@"pagenum":@(1),@"pagesize":@(10),@"fenl":@"1",@"type":[SAApplication sharedApplication].userType} success:^(__kindof SARequest *request, id responseObject) {
        NSArray * navArray = [PMTimeLimitNavItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"hour"]];
        NSMutableArray * vcList = [NSMutableArray array];
        int selectIndex = 0;
        for (int i = 0; i < navArray.count; i++) {
            PMTimeLimitNavItem * navItme = navArray[i];
            PMTimeLimitListViewController *vc = [[PMTimeLimitListViewController alloc] init];
            if ([navItme.zt intValue] == 0) {
                vc.title = [NSString stringWithFormat:@"%@\n已结束",navItme.time];
            }else if ([navItme.zt intValue] == 1){
                vc.title = [NSString stringWithFormat:@"%@\n秒杀中",navItme.time];
                selectIndex = i;
                vc.dataArray = [PMTimeLimitItem mj_objectArrayWithKeyValuesArray:responseObject[@"result"][@"data"]];
            }else if ([navItme.zt intValue] == 2){
                vc.title = [NSString stringWithFormat:@"%@\n即将开始",navItme.time];
            }
            vc.timeLimitNavId = navItme.timeLimitNavId;
            [vcList addObject:vc];
        }
        self.viewControllers = vcList;
        [self.segment setSelectedSegmentIndex:selectIndex animated:YES];

        
    } failure:NULL];

}
- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

}

- (void)initSegment {
    [super initSegment];
   
    self.segment.segmentWidthStyle = HMSegmentedControlSegmentWidthStyleFixed;
    [self.segment setTitleFormatter:^NSAttributedString *(HMSegmentedControl *segmentedControl, NSString *title, NSUInteger index, BOOL selected) {
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:title];
        NSRange topRange = NSMakeRange(0, 5);
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} range:topRange];
        [attStr addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} range:NSMakeRange(topRange.length, title.length - 5)];
        if (selected) {
                [attStr addAttributes:@{NSForegroundColorAttributeName:kColorFF5554} range:NSMakeRange(0, title.length)];
        }else{
            if (index == 0 || index == 1) {
                [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} range:NSMakeRange(0, title.length)];
            }
        }
      
        return attStr;
    }];
//
//    self.segment.titleTextAttributes = @{NSFontAttributeName: UIFontMake(15),
//                                    NSForegroundColorAttributeName: UIColorFromRGB(0x333333)
//                                    };
//    self.segment.selectedTitleTextAttributes = @{NSFontAttributeName: UIFontMake(15),
//                                            NSForegroundColorAttributeName: kColorBGRed
//                                            };
}
@end
@interface PMTimeLimitListViewController() <PMTimeLimitCellDelegate>


@end
@implementation PMTimeLimitListViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.viewModel.cellDelegate = self;
    if ([self.dataArray count] > 0) {
        [self setItems:self.dataArray];
    }else{
        [self fetchData];
    }
    
    self.tableView.mj_header.hidden = YES;
}

- (void)refreshingAction {
    [self fetchData];
}

#pragma mark - Request

- (void)fetchData {
    [self requestMethod:GARequestMethodPOST URLString:API_Dogfood_interval parameters:@{@"id":self.timeLimitNavId,@"pagenum":@(self.page),@"pagesize":@(10),@"type":[SAApplication sharedApplication].userType} resKeyPath:@"result" resArrayClass:[PMTimeLimitItem class] retry:YES success:^(__kindof SARequest *request, id responseObject) {
        [self setItems:responseObject];
    } failure:NULL];
    
}

- (void)PMTimeLimitCellDidClick:(PMTimeLimitCell *)cell{
    DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
    vc.goods_id = cell.item.timeLimitId;
//    vc.list_id  = cell.item.list_id;
    [self.navigationController pushViewController:vc  animated:YES];
}

- (void)didSelectCellWithItem:(id<STCommonTableRowItem>)item{
    PMTimeLimitItem * limitItem = (PMTimeLimitItem *)item;
    DCGoodBaseViewController * vc = [[DCGoodBaseViewController alloc] init];
    vc.goods_id = limitItem.timeLimitId;
//    vc.list_id  = limitItem.list_id;
    [self.navigationController pushViewController:vc  animated:YES];
}

@end
