//
//  OKTableCellContentView.m
//  OKLogisticsInformation
//
//  Created by Oragekk on 16/7/9.
//  Copyright © 2016年 com.iOSDeveloper.duwenquan. All rights reserved.
//
#define kLeftMagin 55
#define kImageWidth 25
#import "OKTableCellContentView.h"
#import <YYLabel.h>
#import <NSAttributedString+YYText.h>
#import "OKLogisticModel.h"
#import "NSString+phone.h"
@interface OKTableCellContentView ()

@property (strong, nonatomic)UILabel *statueLabel;
@property (strong, nonatomic)YYLabel *infoLabel;
@property (strong, nonatomic)UILabel *dateLabel;

@property(nonatomic, strong) UIImageView *stateImageView;
@property (nonatomic,strong) UIWebView *phoneCallWebView;

@property(nonatomic, strong) OKLogisticModel *model;
@end

#define PHONEREGULAR @"\\d{3,4}[- ]?\\d{7,8}"//匹配10到12位连续数字，或者带连字符/空格的固话号，空格和连字符可以省略。
@implementation OKTableCellContentView

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
    self.backgroundColor = [UIColor whiteColor];
    
    UIImageView * stateImageView = [[UIImageView alloc] init];
    self.stateImageView = stateImageView;
    [self addSubview:stateImageView];
    
    
    YYLabel *info= [[YYLabel alloc]init];
    info.numberOfLines = 0;
    [self addSubview:info];
    _infoLabel = info;
    
    UILabel *date = [[UILabel alloc]init];
    date.textAlignment = NSTextAlignmentCenter;
    date.numberOfLines = 0;
    date.font = [UIFont systemFontOfSize:8];
    date.textColor = [UIColor colorWithHexStr:@"#999999"];
    
    [self addSubview:date];
    _dateLabel = date;
    
    UILabel *statueLabel = [[UILabel alloc]init];
    statueLabel.font = [UIFont systemFontOfSize:13];
    statueLabel.textColor = [UIColor colorWithHexStr:@"#999999"];    [self addSubview:statueLabel];
    _statueLabel = statueLabel;
    
//    UILabel *line = [[UILabel alloc]init];
//    line.backgroundColor = RGB(238, 238, 238);
//    [self addSubview:line];
    CGFloat offX =  0.5 *(kMainBoundsWidth  - 24) - kLeftMagin - kImageWidth * 0.5;
    [stateImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self).offset(-offX);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kImageWidth, kImageWidth));
    }];
    
    
    [statueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(kLeftMagin + kImageWidth);
    }];
    
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(statueLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(kLeftMagin + kImageWidth);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
    
//    [line mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self).offset(50);
//        make.right.mas_equalTo(self);
//        make.bottom.mas_equalTo(self);
//        make.height.mas_equalTo(@1);
//    }];
    
}

- (void)reloadDataWithModel:(OKLogisticModel*)model {
    _model = model;
    [self.statueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(kLeftMagin + kImageWidth + 10);
    }];
    
    [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.statueLabel.mas_bottom).offset(5);
        make.left.mas_equalTo(self.statueLabel);
        make.right.mas_equalTo(self).offset(-10);
    }];
    
    [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.stateImageView.mas_left).mas_offset(-5);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(20);
        
    }];
    switch (model.statue) {
        case PMLogisticStatue_start:{
            self.stateImageView.hidden = YES;
            [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(kLeftMagin + kImageWidth + 10);
            }];
            [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.stateImageView.mas_left).mas_offset(-5);
                make.centerY.mas_equalTo(self);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(20);
            }];

        }
            break;
        case PMLogisticStatue_xiadan:{
            self.stateImageView.image = IMAGE(@"logistic_xiadan");
            self.stateImageView.hidden = NO;
            self.statueLabel.text = @"已下单";
        }
            break;
        case PMLogisticStatue_chuku:{
            self.statueLabel.text = @"已出库";
            self.stateImageView.image = IMAGE(@"logistic_chuku");
            self.stateImageView.hidden = NO;
        }
            break;
        case PMLogisticStatue_fahuo:{
            self.statueLabel.text = @"已发货";
            self.stateImageView.image = IMAGE(@"logistic_fahuo");
            self.stateImageView.hidden = NO;
        }
            break;
        case PMLogisticStatue_lanjian:{
            self.statueLabel.text = @"已揽件";
            self.stateImageView.image = IMAGE(@"logistic_lanjian");
            self.stateImageView.hidden = NO;
        }
            break;
        case PMLogisticStatue_tuzhong:{
            self.stateImageView.hidden = YES;
            [self.infoLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(self);
                make.left.mas_equalTo(kLeftMagin + kImageWidth + 10);
            }];
            [self.dateLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.right.mas_equalTo(self.stateImageView.mas_left).mas_offset(-5);
                make.centerY.mas_equalTo(self);
                make.width.mas_equalTo(30);
                make.height.mas_equalTo(20);
            }];

        }
            break;
        case PMLogisticStatue_dangqianweizhi:{
            self.statueLabel.text = @"运输中";
            self.stateImageView.image = IMAGE(@"logistic_zuihoueweizhi");
            self.stateImageView.hidden = NO;
        }
            break;
        case PMLogisticStatue_shouhuodi:{
            self.stateImageView.image = IMAGE(@"logistic_xiadan");
            self.stateImageView.hidden = NO;
        }
            break;
        default:
            self.stateImageView.hidden = YES;
            break;
    }
    
    NSRange stringRange = NSMakeRange(0, model.dsc.length);
    //正则匹配
    NSError *error;
    NSRegularExpression *regexps = [NSRegularExpression regularExpressionWithPattern:PHONEREGULAR options:0 error:&error];
    // 转为富文本
    NSMutableAttributedString *dsc = [[NSMutableAttributedString alloc]initWithString:model.dsc];
    // NSFontAttributeName
    [dsc addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:11] range:NSMakeRange(0, model.dsc.length)];
    if (self.currented) {
        [dsc addAttribute:NSForegroundColorAttributeName value:RGB(7, 166, 40) range:NSMakeRange(0, model.dsc.length)];
    }else {
        [dsc addAttribute:NSForegroundColorAttributeName value:RGB(139, 139, 139) range:NSMakeRange(0, model.dsc.length)];
    }
    if (!error && regexps != nil) {
        [regexps enumerateMatchesInString:model.dsc options:0 range:stringRange usingBlock:^(NSTextCheckingResult * _Nullable result, NSMatchingFlags flags, BOOL * _Nonnull stop) {
            //可能为电话号码的字符串及其所在位置
            NSMutableAttributedString *actionString = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",[model.dsc substringWithRange:result.range]]];
            NSRange phoneRange = result.range;
            //这里需要判断是否是电话号码，并添加链接
            if ([NSString isMobilePhoneOrtelePhone:actionString.string]) {
                [dsc setTextHighlightRange:phoneRange
                                     color:[UIColor colorWithHexStr:@"0x59A3E8"]
                           backgroundColor:[UIColor whiteColor]
                                 tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                                     [self callPhoneThree:actionString.string];
                                 }];
                
            }
        }];
    }
    
    self.infoLabel.attributedText = dsc;
    self.dateLabel.text = model.date;
    
    
    
    [self setNeedsDisplay];
//    [self layoutIfNeeded];
}

- (void)setCurrentTextColor:(UIColor *)currentTextColor {
    
    self.infoLabel.textColor = currentTextColor;
}

- (void)setTextColor:(UIColor *)textColor {
    
    self.infoLabel.textColor = textColor;
}

- (void)setCurrented:(BOOL)currented {
    
    _currented = currented;
    if (currented) {
        self.infoLabel.textColor = RGBA(7, 166, 40, 1.0);
    } else {
        self.infoLabel.textColor = RGB(139, 139, 139);
    }
}

- (void)callPhoneThree:(NSString *)phoneNum{
    /*--------拨号方法三-----------*/
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
    if ( !_phoneCallWebView ) {
        
        _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CGFloat height = self.bounds.size.height;
    CGFloat cicleWith;
    if (self.model.statue == PMLogisticStatue_start ||  self.model.statue == PMLogisticStatue_tuzhong) {
        cicleWith = 6;
    }else{
        cicleWith = 25;
    }
    //    CGFloat shadowWith = cicleWith/3.0;
    
    if (self.hasUpLine) {
        
        UIBezierPath *topBezier = [UIBezierPath bezierPath];
        [topBezier moveToPoint:CGPointMake(kLeftMagin+ kImageWidth * 0.5, 0)];
        [topBezier addLineToPoint:CGPointMake(kLeftMagin + kImageWidth * 0.5, height/2.0 - cicleWith/2.0)];
        
        topBezier.lineWidth = 1.0;
        UIColor *stroke = RGB(185, 185, 185);
        [stroke set];
        [topBezier stroke];
    }
    
    if (self.model.statue == PMLogisticStatue_start ||  self.model.statue == PMLogisticStatue_tuzhong) {
        UIBezierPath *cicle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(kLeftMagin + kImageWidth * 0.5 -cicleWith/2.0, height/2.0 - cicleWith/2.0, cicleWith, cicleWith)];
        //
                UIColor *cColor = RGB(185, 185, 185);
                [cColor set];
                [cicle fill];

                [cicle stroke];
    }
    
//    if (self.currented) {
//
//        UIBezierPath *cicle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50/2.0 - cicleWith/2.0, height/2.0 - cicleWith/2.0, cicleWith, cicleWith)];
//
//        cicle.lineWidth = cicleWith/3.0;
//        UIColor *cColor = RGBA(7, 166, 40, 1.0);
//        [cColor set];
//        [cicle fill];
//
//        UIColor *shadowColor = RGBA(7, 166, 40, 0.5);
//        [shadowColor set];
//
//
//        [cicle stroke];
//    } else {
//
//        UIBezierPath *cicle = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50/2.0-cicleWith/2.0, height/2.0 - cicleWith/2.0, cicleWith, cicleWith)];
//
//        UIColor *cColor = RGB(185, 185, 185);
//        [cColor set];
//        [cicle fill];
//
//        [cicle stroke];
//    }
    
    if (self.hasDownLine) {
        
        UIBezierPath *downBezier = [UIBezierPath bezierPath];
        [downBezier moveToPoint:CGPointMake(kLeftMagin + kImageWidth * 0.5, height/2.0 + cicleWith/2.0)];
        [downBezier addLineToPoint:CGPointMake(kLeftMagin + kImageWidth * 0.5, height)];
        
        downBezier.lineWidth = 1.0;
        UIColor *stroke = RGB(185, 185, 185);
        [stroke set];
        [downBezier stroke];
    }
}
@end
