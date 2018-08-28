//
//  STBaseNonSystemNavViewController.h
//  SnailTruck
//
//  Created by GhGh on 16/1/18.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "STBaseViewController.h"

@interface STNavgationBar : UIView

@property (nonatomic,strong) UILabel *titleLabel; // 头title - 更改其他View时可以先隐藏，之后随意添加
@property (nonatomic,strong) UIImageView *navigationBarBg; // navigationBar图片
@property (nonatomic, strong) UIView *navigationBarLineView; // navigationBar底部线0.5,0.33高

@property (nonatomic,strong) UIButton *leftBarButton; // 左侧按钮 默认是返回按钮
@property (nonatomic,strong) UIButton *rightBarButton;

@property(nonatomic, copy) NSString *title;

@end

@interface STBaseNonSystemNavViewController : STBaseViewController

@property(nonatomic, strong) UIImageView *statusBarView;//背景色同 navgationBar 没有 navgationBar 时透明
@property(nonatomic, strong) STNavgationBar *navgationBar; //默认为空 重载 shouldInitNavgationBar 返回 yes 或者 使用setupNavgationBar初始化

/**
 *  负责初始化和设置controller里面的view，也就是self.view的subView。目的在于分类代码，所以与view初始化的相关代码都写在这里。
 *
 *  @warning initSubviews只负责subviews的init，不负责布局。布局相关的代码应该写在 <b>viewDidLayoutSubviews</b>
 */
- (void)initSubviews NS_REQUIRES_SUPER;

- (void)setupNavgationBar;//在 initSubviews 中调用

/**
 获取布局开始位置
 当没有 navgationBar 时 viewOrigin 为 statusBarView 高度
 有 navgationBar 时 viewOrigin 为 statusBarView + navgationBar 高度
 @return 开始布局位置
 */
- (CGPoint)viewOrigin;

- (void)bringNavgationBar;

@end

@interface STBaseNonSystemNavViewController (SubclassingHooks)

- (BOOL)shouldInitSTNavgationBar;

@end;


