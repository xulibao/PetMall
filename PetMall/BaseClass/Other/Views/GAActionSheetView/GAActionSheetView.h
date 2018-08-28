//
//  GAActionSheetView.h
//  GA_Base_CustomControls
//
//  Created by GhGh on 2017/7/11.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
// 特殊情况下 - 自定义
@interface GAActionSheetViewModel : NSObject
// topTitleFont 标题大小
@property (nonatomic, strong) UIFont *titleFont, *topTitleFont;
@property(nonatomic, assign)CGFloat titleHeight;
@property(nonatomic, assign)CGFloat buttonHeight;
@property(nonatomic, assign)CGFloat darkShadowViewAlpha;
@property(nonatomic, assign)CGFloat showAnimateDuration;
@property(nonatomic, assign)CGFloat hideAnimateDuration;
@end
@protocol GAActionSheetDelegate;
typedef void(^GAActionSheetBlock)(NSInteger buttonIndex,NSString *buttonTitle);
@interface GAActionSheetView : UIView
/**
 *  type delegate
 *  @param sheetModel             sheetModel      (可以为空)
 *  @param title                  title            (可以为空)
 *  @param delegate               delegate
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 */
#pragma mark - 全部自定义
- (instancetype)initWithModel:(GAActionSheetViewModel *)sheetModel Title:(NSString *)title
                     delegate:(id<GAActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

/**
 *  type block
 *  @param sheetModel             sheetModel      (可以为空)
 *  @param title                  title           (可以为空)
 *  @param actionSheetBlock               delegate
 *  @param cancelButtonTitle      "取消"按钮         (默认有)
 *  @param destructiveButtonTitle "警示性"(红字)按钮  (可以为空)
 *  @param otherButtonTitles      otherButtonTitles
 */
#pragma mark - 全部自定义 - 推荐使用blcok
- (instancetype)initWithModel:(GAActionSheetViewModel *)sheetModel Title:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             actionSheetBlock:(GAActionSheetBlock) actionSheetBlock;


// 都可以
@property (nonatomic, weak) id<GAActionSheetDelegate> delegate;
@property (nonatomic, copy) GAActionSheetBlock actionSheetBlock;
// 展示
- (void)show;
@end



#pragma mark - delegate
@protocol GAActionSheetDelegate <NSObject>
@optional
- (void)actionSheet:(GAActionSheetView *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex buttonTitle:(NSString *)buttonTitle;
@end




// 使用1
/*
 GAActionSheetViewModel *sheetModel = [[GAActionSheetViewModel alloc] init];
 sheetModel.titleFont = [UIFont systemFontOfSize:22];
 sheetModel.topTitleFont = [UIFont systemFontOfSize:30];
 sheetModel.titleHeight = 70;
 sheetModel.buttonHeight = 50;
 sheetModel.darkShadowViewAlpha = 0.5;
 sheetModel.showAnimateDuration = 0.5;
 sheetModel.hideAnimateDuration = 0.5;
 GAActionSheetView *actionSheet = [[GAActionSheetView alloc] initWithModel:sheetModel Title:@"我是自定义1" delegate:self cancelButtonTitle:@"取消按钮1" destructiveButtonTitle:@"红色按钮1" otherButtonTitles:@"我是其他0",@"我是其他1",@"我是其他2",@"我是其他3", nil];
 actionSheet.actionSheetBlock = ^(NSInteger buttonIndex){
 NSLog(@"buttonIndex-------%ld",buttonIndex);
 };
 [actionSheet show];
 
 // 代理
 - (void)actionSheet:(GAActionSheetView *)actionSheet didClickedButtonAtIndex:(NSInteger)buttonIndex
 {
 NSLog(@"buttonIndex2-------%ld",buttonIndex);
 }
 */

// 使用2
/*
 GAActionSheetViewModel *sheetModel = [[GAActionSheetViewModel alloc] init];
 sheetModel.titleFont = [UIFont systemFontOfSize:22];
 sheetModel.topTitleFont = [UIFont systemFontOfSize:30];
 sheetModel.titleHeight = 70;
 sheetModel.buttonHeight = 50;
 sheetModel.darkShadowViewAlpha = 0.5;
 sheetModel.showAnimateDuration = 0.5;
 sheetModel.hideAnimateDuration = 0.5;
 GAActionSheetView *actionSheet = [[GAActionSheetView alloc] initWithModel:sheetModel Title:@"我是自定义" cancelButtonTitle:@"取消按钮" destructiveButtonTitle:@"红色按钮" otherButtonTitles:@[@"我是其他0",@"我是其他1",@"我是其他2",@"我是其他3"] actionSheetBlock:^(NSInteger buttonIndex) {
 NSLog(@"GAActionSheetView ---- %ld",buttonIndex);
 }];
 [actionSheet show];
 z
 */


// 使用3
/*
 GAActionSheetView *actionSheet = [[GAActionSheetView alloc] initWithModel:nil Title:@"我是自定义1" delegate:self cancelButtonTitle:@"取消按钮1" destructiveButtonTitle:@"红色按钮1" otherButtonTitles:@"我是其他0",@"我是其他1",@"我是其他2",@"我是其他3", nil];
 actionSheet.actionSheetBlock = ^(NSInteger buttonIndex){
 NSLog(@"buttonIndex-------%ld",buttonIndex);
 };
 [actionSheet show];
 
 */


