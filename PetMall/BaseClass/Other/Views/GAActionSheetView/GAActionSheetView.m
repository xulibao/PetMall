//
//  GAActionSheetView.m
//  GA_Base_CustomControls
//
//  Created by GhGh on 2017/7/11.
//  Copyright © 2017年 GhGh. All rights reserved.
//

#import "GAActionSheetView.h"
#define GA_ScreenWidth [UIScreen mainScreen].bounds.size.width
#define GA_ScreenHeight [UIScreen mainScreen].bounds.size.height
#define GA_RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define IOS8_GA_OVER [[UIDevice currentDevice].systemVersion floatValue] >= 8.0-0.1)
#define GA_TitleFont     [UIFont systemFontOfSize:18.0f]
#define GA_TitleHeight 60.0f
#define GA_ButtonHeight  49.0f
#define GA_DarkShadowViewAlpha 0.35f
#define GA_ShowAnimateDuration 0.3f
#define GA_HideAnimateDuration 0.2f
@interface GAActionSheetView () {
    NSString *_cancelButtonTitle;
    NSString *_destructiveButtonTitle;
    NSArray *_otherButtonTitles;
    UIView *_buttonBackgroundView;
    UIView *_darkShadowView;
}
@property (nonatomic, strong)GAActionSheetViewModel *ga_sheetModel;
@property (nonatomic, copy) NSString *title;
@end
@implementation GAActionSheetViewModel
@end
@implementation GAActionSheetView
#pragma mark - 全部自定义
- (instancetype)initWithModel:(GAActionSheetViewModel *)sheetModel Title:(NSString *)title
                     delegate:(id<GAActionSheetDelegate>)delegate
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION
{
    self = [super init];
    if(self) {
        _ga_sheetModel = sheetModel;
        _title = title;
        _delegate = delegate;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *args = [NSMutableArray array];
        
        if(_destructiveButtonTitle.length) {
            [args addObject:_destructiveButtonTitle];
        }
        
        [args addObject:otherButtonTitles];
        
        if (otherButtonTitles) {
            va_list params;
            va_start(params, otherButtonTitles);
            id buttonTitle;
            while ((buttonTitle = va_arg(params, id))) {
                if (buttonTitle) {
                    [args addObject:buttonTitle];
                }
            }
            va_end(params);
        }
        _otherButtonTitles = [NSArray arrayWithArray:args];
        [self _initSubViews];
    }
    return self;
}
#pragma mark - 全部自定义
- (instancetype)initWithModel:(GAActionSheetViewModel *)sheetModel Title:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
       destructiveButtonTitle:(NSString *)destructiveButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             actionSheetBlock:(GAActionSheetBlock) actionSheetBlock
{
    self = [super init];
    if(self) {
        _ga_sheetModel = sheetModel;
        _title = title;
        _cancelButtonTitle = cancelButtonTitle.length>0 ? cancelButtonTitle : @"取消";
        _destructiveButtonTitle = destructiveButtonTitle;
        
        NSMutableArray *titleArray = [NSMutableArray array];
        if (_destructiveButtonTitle.length) {
            [titleArray addObject:_destructiveButtonTitle];
        }
        [titleArray addObjectsFromArray:otherButtonTitles];
        _otherButtonTitles = [NSArray arrayWithArray:titleArray];
        self.actionSheetBlock = actionSheetBlock;
        
        [self _initSubViews];
    }
    return self;
}
// 初始化子控件
- (void)_initSubViews {
    
    self.frame = CGRectMake(0, 0, GA_ScreenWidth, GA_ScreenHeight);
    self.backgroundColor = [UIColor clearColor];
    self.hidden = YES;
    
    _darkShadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, GA_ScreenWidth, GA_ScreenHeight)];
    _darkShadowView.backgroundColor = GA_RGB(20, 20, 20);
    _darkShadowView.alpha = 0.0f;
    
    [self addSubview:_darkShadowView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(_dismissView:)];
    [_darkShadowView addGestureRecognizer:tap];
    
    
    _buttonBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    _buttonBackgroundView.backgroundColor = GA_RGB(220, 220, 220);
    [self addSubview:_buttonBackgroundView];
    
    CGFloat buttonHeight = _ga_sheetModel.buttonHeight ? _ga_sheetModel.buttonHeight : GA_ButtonHeight;
    if (self.title.length) {
        CGFloat titleHeight = _ga_sheetModel.titleHeight ? _ga_sheetModel.titleHeight : GA_TitleHeight;
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, buttonHeight - titleHeight, GA_ScreenWidth, titleHeight)];
        titleLabel.text = _title;
        titleLabel.numberOfLines = 0;
        titleLabel.textColor = GA_RGB(125, 125, 125);
        titleLabel.textAlignment = NSTextAlignmentCenter;
        UIFont *topTitleFont = _ga_sheetModel.topTitleFont ? _ga_sheetModel.topTitleFont : [UIFont systemFontOfSize:13.0f];
        titleLabel.font = topTitleFont;
        titleLabel.backgroundColor = [UIColor whiteColor];
        [_buttonBackgroundView addSubview:titleLabel];
    }
    for (int i = 0; i < _otherButtonTitles.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = i;
        [button setTitle:_otherButtonTitles[i] forState:UIControlStateNormal];
        button.backgroundColor = [UIColor whiteColor];
        button.titleLabel.font = _ga_sheetModel.titleFont ? _ga_sheetModel.titleFont : GA_TitleFont;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i==0 && _destructiveButtonTitle.length) {
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        }
        UIImage *image = [self imageFromContextWithColor:GA_RGB(243, 243, 243) size:CGSizeMake(10, 10)];
        [button setBackgroundImage:image forState:UIControlStateHighlighted];
        [button addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
        CGFloat buttonY = buttonHeight * (i + (_title.length>0?1:0));
        button.frame = CGRectMake(0, buttonY, GA_ScreenWidth, buttonHeight);
        [_buttonBackgroundView addSubview:button];
        
        
        UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
        line.backgroundColor = GA_RGB(210, 210, 210);
        line.frame = CGRectMake(0, buttonY, GA_ScreenWidth, 0.5);
        [_buttonBackgroundView addSubview:line];
    }
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.tag = _otherButtonTitles.count;
    [cancelButton setTitle:_cancelButtonTitle forState:UIControlStateNormal];
    cancelButton.backgroundColor = [UIColor whiteColor];
    cancelButton.titleLabel.font = _ga_sheetModel.titleFont ? _ga_sheetModel.titleFont : GA_TitleFont;;
    [cancelButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    UIImage *image = [self imageFromContextWithColor:GA_RGB(243, 243, 243) size:CGSizeMake(10, 10)];
    [cancelButton setBackgroundImage:image forState:UIControlStateHighlighted];
    [cancelButton addTarget:self action:@selector(_didClickButton:) forControlEvents:UIControlEventTouchUpInside];
    CGFloat buttonY = buttonHeight * (_otherButtonTitles.count + (_title.length>0?1:0)) + 5;
    cancelButton.frame = CGRectMake(0, buttonY, GA_ScreenWidth, buttonHeight);
    [_buttonBackgroundView addSubview:cancelButton];
    
    CGFloat height = buttonHeight * (_otherButtonTitles.count+1 + (_title.length>0?1:0)) + 5;
    _buttonBackgroundView.frame = CGRectMake(0, GA_ScreenHeight, GA_ScreenWidth, height);
    
}

- (void)_didClickButton:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex: buttonTitle:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:button.tag buttonTitle:button.currentTitle];
    }
    if (self.actionSheetBlock) {
        self.actionSheetBlock(button.tag,button.currentTitle);
    }
    [self _hide];
}

- (void)_dismissView:(UITapGestureRecognizer *)tap {
    
    if (_delegate && [_delegate respondsToSelector:@selector(actionSheet:didClickedButtonAtIndex: buttonTitle:)]) {
        [_delegate actionSheet:self didClickedButtonAtIndex:_otherButtonTitles.count buttonTitle:@""];
    }
    
    if (self.actionSheetBlock) {
        self.actionSheetBlock(_otherButtonTitles.count,@"");
    }
    
    [self _hide];
}
// 展示
- (void)show{
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    [window addSubview:self];
    self.hidden = NO;
    CGFloat darkShadowViewAlpha = _ga_sheetModel.darkShadowViewAlpha ? _ga_sheetModel.darkShadowViewAlpha : GA_DarkShadowViewAlpha;
    CGFloat showAnimateDuration = _ga_sheetModel.showAnimateDuration ? _ga_sheetModel.showAnimateDuration : GA_ShowAnimateDuration;
    [UIView animateWithDuration:showAnimateDuration animations:^{
        _darkShadowView.alpha = darkShadowViewAlpha;
        _buttonBackgroundView.transform = CGAffineTransformMakeTranslation(0, -_buttonBackgroundView.frame.size.height);
    } completion:^(BOOL finished) {
        
    }];
}
// 隐藏
- (void)_hide {
    CGFloat hideAnimateDuration = _ga_sheetModel.hideAnimateDuration ? _ga_sheetModel.hideAnimateDuration : GA_HideAnimateDuration;
    [UIView animateWithDuration:hideAnimateDuration animations:^{
        _darkShadowView.alpha = 0;
        _buttonBackgroundView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        self.hidden = YES;
        [self removeFromSuperview];
    }];
}
/**
 通过Color & Size快速创建一个UIImage
 */
- (UIImage *)imageFromContextWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = (CGRect){{0.0f,0.0f},size};
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0.0f);
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
@end
