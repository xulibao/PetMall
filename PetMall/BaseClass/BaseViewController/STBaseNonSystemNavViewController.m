//
//  STBaseNonSystemNavViewController.m
//  SnailTruck
//
//  Created by GhGh on 16/1/18.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "STBaseNonSystemNavViewController.h"

@interface STNavgationBar ()

@end
@implementation STNavgationBar

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupBackgroundView];
        [self setupTitleLabel];
        [self setupLeftBarButton];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.navigationBarBg.frame = (CGRect){CGPointZero, self.bounds.size};
    CGFloat maxWidth = self.width * 200.0/375.0;
    CGSize titleSize = [self.titleLabel sizeThatFits:CGSizeMake(maxWidth, self.height)];
    titleSize.width = maxWidth < titleSize.width ? maxWidth : titleSize.width;
    self.titleLabel.frame = (CGRect){(self.width - titleSize.width) / 2, (self.height - titleSize.height) / 2, titleSize};
    _leftBarButton.frame = (CGRect){0,(self.height - 44) / 2, 44,44};
    [_leftBarButton setImageEdgeInsets:UIEdgeInsetsMake(0, -15, 0, 0)];
}

#pragma mark - 导航栏 View
- (void)setupBackgroundView {
    // 导航栏 背景图 {0，0，View的宽，64}
    _navigationBarBg = [[UIImageView alloc] init];
    _navigationBarBg.backgroundColor = UIColorFromRGB(0xf8f8f8);
    [self addSubview:_navigationBarBg];
    // 加线
    //    _navigationBarLineView = [[UIView alloc] initWithFrame:CGRectMake(0, kNavgationBarHeight - 1.0/[UIScreen mainScreen].scale, UI_SCREEN_WIDTH, 1.0/[UIScreen mainScreen].scale)];
    //    _navigationBarLineView.backgroundColor = [UIColor colorWithRed:211/255.0 green:211/255.0 blue:211/255.0 alpha:1.0];
    //    [_navigationBarBg addSubview:_navigationBarLineView];
    
    [self addSubview:_navigationBarBg];
}

#pragma mark - 导航栏中间 title
- (void)setupTitleLabel {
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.textColor = kNavigationBlackColor;
    _titleLabel.backgroundColor = [UIColor clearColor];
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    _titleLabel.font = kNavigationTitleFont;
    [self addSubview:_titleLabel];
}

#pragma mark - 创建 左侧 按钮
- (void)setupLeftBarButton {
    _leftBarButton = [UIButton buttonWithType:UIButtonTypeSystem];
    // 项目都是ios7以上版本，故写死
    [_leftBarButton setImage:[UIImage imageNamed:@"nav_Back_normal"] forState:UIControlStateNormal];
    [_leftBarButton setImage:[UIImage imageNamed:@"nav_Back_normal"] forState:UIControlStateHighlighted];
    [_leftBarButton setTintColor:[UIColor blackColor]];
//    _leftBarButton.adjustsImageWhenHighlighted =NO;
    [self addSubview:_leftBarButton];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self setNeedsLayout];
}

@end

@interface STBaseNonSystemNavViewController ()

@end

@implementation STBaseNonSystemNavViewController

#pragma mark - Override STBaseViewController

- (void)initSubviews {
    [super initSubviews];
    
    if ([self shouldHiddenSystemNavgation]) {
        _statusBarView = [[UIImageView alloc] init];
        _statusBarView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_statusBarView];
    }
    
    if ([self shouldInitSTNavgationBar]) {
        [self setupNavgationBar];
    }
}

- (BOOL)shouldHiddenSystemNavgation {
    return YES;
}

- (void)requestDidStop:(__kindof SARequest *)request {
    [super requestDidStop:request];
    [self bringNavgationBar];
}

- (void)showEmptyRetryViewWithButtonAction:(SEL)action {
    [super showEmptyRetryViewWithButtonAction:action];
    [self.navgationBar bringToFront];
}

#pragma mark - Override UIViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self bringNavgationBar];
    self.navgationBar.leftBarButton.hidden = !(self.navigationController.viewControllers.count > 1);
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.statusBarView.frame = [[UIApplication sharedApplication] statusBarFrame];
    self.navgationBar.frame = (CGRect){0, CGRectGetMaxY(self.statusBarView.frame), self.view.width, kNavgationBarHeight};
}

- (void)setTitle:(NSString *)title {
    if ((self.shouldHiddenSystemNavgation || self.shouldInitSTNavgationBar) && self.navgationBar) {
        self.navgationBar.title = title;
    } else {
        [super setTitle:title];
    }
}

#pragma mark - PublicMethod

- (void)setupNavgationBar {
    _navgationBar = [[STNavgationBar alloc] init];
    [self.view addSubview:_navgationBar];
    [_navgationBar.leftBarButton addTarget:self
                                    action:@selector(popViewController:)
                          forControlEvents:UIControlEventTouchUpInside];
    _statusBarView.backgroundColor = UIColorFromRGB(0xf8f8f8);
}

- (CGPoint)viewOrigin {
    CGFloat y = CGRectGetMaxY([[UIApplication sharedApplication] statusBarFrame]);
    if (self.shouldInitSTNavgationBar || self.navgationBar) {
        y += kNavgationBarHeight;
    }
    return CGPointMake(0, y);
}

- (void)bringNavgationBar {
    [self.view bringSubviewToFront:self.statusBarView];
    [self.view bringSubviewToFront:self.navgationBar];
}

@end

@implementation STBaseNonSystemNavViewController (SubclassingHooks)

- (BOOL)shouldInitSTNavgationBar {
    return NO;
}

@end
