//
//  OKTableHeaderView.m
//  OKLogisticsInformation
//
//  Created by Oragekk on 16/7/9.
//  Copyright © 2016年 com.iOSDeveloper.duwenquan. All rights reserved.
//

#import "OKTableHeaderView.h"
#import <YYLabel.h>
#import <NSAttributedString+YYText.h>
#import <SDWebImage/UIImageView+WebCache.h>
@interface OKTableHeaderView ()
@property (nonatomic,strong) UIImageView *goodsPic;
@property (nonatomic,strong) UILabel *type;
@property (strong, nonatomic) UILabel *numLabel;
@property (strong, nonatomic) UILabel *comLabel;
@property (strong, nonatomic) YYLabel *phoneLabel;
@property (nonatomic,strong) UIWebView *phoneCallWebView;
@end
@implementation OKTableHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        self.image = IMAGE(@"order_shadowBg");
        
        [self setupUI];
    }
    return self;
}

- (void)setPhone:(NSString *)phone {
    _phone = phone;
    NSMutableAttributedString *text = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"官方电话：%@",phone]];
    NSRange range = [[NSString stringWithFormat:@"官方电话：%@",phone] rangeOfString: phone];
    
    [text addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexStr:@"0x9D9D9D"] range:NSMakeRange(0, 5)];
    [text setTextHighlightRange:range
                             color:[UIColor colorWithHexStr:@"0x59A3E8"]
                   backgroundColor:[UIColor whiteColor]
                         tapAction:^(UIView * _Nonnull containerView, NSAttributedString * _Nonnull text, NSRange range, CGRect rect) {
                             [self callPhoneThree:phone];
                         }];
    self.phoneLabel.attributedText = text;
}

- (void)setNumber:(NSString *)number {
    _number = number;
    self.numLabel.text = [NSString stringWithFormat:@"运单号：%@",number];
}

- (void)setCompany:(NSString *)company {
    _company = company;
    self.comLabel.text = [NSString stringWithFormat:@"%@",company];
}
- (void)setWltype:(NSString *)wltype {
    _wltype = wltype;
        
//    NSMutableAttributedString *wlStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"物流状态：%@",wltype]];
//    NSRange range = [[NSString stringWithFormat:@"物流状态：%@",wltype] rangeOfString: wltype];
//    [wlStr addAttribute:NSForegroundColorAttributeName value: [UIColor colorWithHexStr:@"0x07A628"] range:range];
//    self.type.attributedText = wlStr;
}
- (void)setImageUrl:(NSString *)imageUrl {
    _imageUrl = imageUrl;
    [self.goodsPic sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    
}
- (void)setupUI {
    self.goodsPic.frame=CGRectMake(15, 15, 40,40);
    self.goodsPic.image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"hh" ofType:@"jpg"]];
    [self addSubview:self.goodsPic];
    
    self.comLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.goodsPic.frame) + 15,10, 20*10, 15)];
    self.comLabel.font = [UIFont systemFontOfSize:12];
//    self.comLabel.textColor = [UIColor colorWithHexStr:@"0x9D9D9D"];
    self.comLabel.text = @"承运公司:";
    [self addSubview:self.comLabel];
    
    self.numLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.comLabel.frame.origin.x ,CGRectGetMaxY(self.comLabel.frame) + 5, 20*10, 15)];
    self.numLabel.font = [UIFont systemFontOfSize:12];
//    self.numLabel.textColor = [UIColor colorWithHexStr:@"0x9D9D9D"];
    self.numLabel.text = @"运单号:";
    [self addSubview:self.numLabel];
    
    self.phoneLabel = [[YYLabel alloc]initWithFrame:CGRectMake(self.comLabel.frame.origin.x ,CGRectGetMaxY(self.numLabel.frame) + 5, 20*10, 15)];
    self.phoneLabel.font = [UIFont systemFontOfSize:11];
//    self.phoneLabel.textColor = [UIColor colorWithHexStr:@"0x9D9D9D"];
    self.phoneLabel.text = @"官方电话:";
    [self addSubview:self.phoneLabel];
    
//    UILabel *line=[[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.goodsPic.frame)+15, kMainBoundsWidth, 8)];
//    line.backgroundColor= [UIColor colorWithHexStr:@"0xf1f1f1"];
//    [self addSubview:line];
    
}
#pragma mark 懒加载
-(UIImageView *)goodsPic{
    
    if(!_goodsPic) {
        
        _goodsPic =[[UIImageView alloc]init];
        
    }
    
    return _goodsPic;
    
}
-(UILabel *)type{
    
    if(!_type) {
        
        _type =[[UILabel alloc]init];
        
    }
    
    return _type;
    
}
-(UILabel *)numLabel{
    
    if(!_numLabel) {
        
        _numLabel =[[UILabel alloc]init];
        
    }
    
    return _numLabel;
    
}
-(UILabel *)comLabel{
    
    if(!_comLabel) {
        
        _comLabel =[[UILabel alloc]init];
        
    }
    
    return _comLabel;
    
}
-(YYLabel *)phoneLabel{
    
    if(!_phoneLabel) {
        
        _phoneLabel =[YYLabel new];
        
    }
    
    return _phoneLabel;
    
}
- (void)callPhoneThree:(NSString *)phoneNum{
    /*--------拨号方法三-----------*/
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNum]];
    if ( !_phoneCallWebView ) {
        
        _phoneCallWebView = [[UIWebView alloc] initWithFrame:CGRectZero];// 这个webView只是一个后台的容易 不需要add到页面上来  效果跟方法二一样 但是这个方法是合法的
    }
    [_phoneCallWebView loadRequest:[NSURLRequest requestWithURL:phoneURL]];
}
@end
