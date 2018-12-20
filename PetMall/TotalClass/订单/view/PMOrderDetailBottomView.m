//
//  PMOrderDetailBottomView.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/15.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMOrderDetailBottomView.h"
@interface PMOrderDetailBottomView()
@property(nonatomic, strong) UILabel *orderNoLabel;
@property(nonatomic, strong) UILabel *label1;
@property(nonatomic, strong) UILabel *label2;
@property(nonatomic, strong) UILabel *label3;
@property(nonatomic, strong) UILabel *label4;

@end
@implementation PMOrderDetailBottomView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self fecthSubViews];
    }
    return self;
}

- (void)fecthSubViews{
    UIView * bgView = [[UIView alloc] init];
    bgView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bgView];

    UILabel * label0 = [[UILabel alloc] init];
    self.orderNoLabel = label0;
    label0.text = @"订单号：12351683510";
    label0.textColor = kColor333333;
    label0.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:label0];
    
    UILabel * label1 = [[UILabel alloc] init];
    self.label1 = label1;
    label1.text = @"支付宝交易号：201805121235168351012409";
    label1.textColor = kColor333333;
    label1.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc] init];
    self.label2 = label2;
    label2.text = @"下单时间：2018-07-10  12:23:47";
    label2.textColor = kColor333333;
    label2.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:label2];
    
    UILabel * label3 = [[UILabel alloc] init];
    self.label3 = label3;
    label3.text = @"付款时间：2018-07-10  12:32:12";
    label3.textColor = kColor333333;
    label3.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:label3];
    
    UILabel * label4 = [[UILabel alloc] init];
    self.label4 = label4;
    label4.text = @"发货时间：2018-07-10  14:08:36";
    label4.textColor = kColor333333;
    label4.font = [UIFont systemFontOfSize:12];
    [bgView addSubview:label4];
    
    
    UIButton * btn = [[UIButton alloc] init];
    [btn addTarget:self action:@selector(copyClick) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"复制" forState:UIControlStateNormal];
    [btn setTitleColor:kColor999999 forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    btn.layer.cornerRadius = 12.5;
    btn.layer.borderColor = kColor999999.CGColor;
    btn.layer.borderWidth = 0.5;
    btn.clipsToBounds = YES;
    [bgView addSubview:btn];

    
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(110);
    }];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-17);
        make.centerY.mas_equalTo(label0);
        make.size.mas_equalTo(CGSizeMake(45, 25));
    }];
    [label0 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(12);
    }];
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label0);
        make.top.mas_equalTo(label0.mas_bottom).mas_equalTo(10);
    }];
    [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label0);
        make.top.mas_equalTo(label1.mas_bottom).mas_equalTo(4);
    }];
    
    [label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label0);
        make.top.mas_equalTo(label2.mas_bottom).mas_equalTo(4);
    }];
    
    [label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(label0);
        make.top.mas_equalTo(label3.mas_bottom).mas_equalTo(4);
    }];
    
    
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = [UIColor whiteColor];
    [self addSubview:bottomView];
    
    UIButton * tagBtn = [[UIButton alloc] init];
    self.tagBtn = tagBtn;
//    [tagBtn setTitle:@"确认收货" forState:UIControlStateNormal];
    [tagBtn addTarget:self action:@selector(tagBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [tagBtn setTitleColor:kColorFF3945 forState:UIControlStateNormal];
    tagBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    tagBtn.layer.cornerRadius = 15;
    tagBtn.layer.borderColor = kColorFF3945.CGColor;
    tagBtn.layer.borderWidth = 0.5;
    tagBtn.clipsToBounds = YES;
    [bottomView addSubview:tagBtn];
    
    UIButton * tagBtn1 = [[UIButton alloc] init];
    self.tagBtn1 = tagBtn1;
//    [tagBtn1 setTitle:@"评价" forState:UIControlStateNormal];
    [tagBtn1 setTitleColor:kColor999999 forState:UIControlStateNormal];
    [tagBtn1 addTarget:self action:@selector(tagBtn1Click) forControlEvents:UIControlEventTouchUpInside];
    tagBtn1.titleLabel.font = [UIFont systemFontOfSize:14];
    tagBtn1.layer.cornerRadius = 15;
    tagBtn1.layer.borderColor = kColor999999.CGColor;
    tagBtn1.layer.borderWidth = 0.5;
    tagBtn1.clipsToBounds = YES;
    [bottomView addSubview:tagBtn1];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(bgView.mas_bottom).mas_offset(5);
        make.height.mas_equalTo(50);
        make.left.right.mas_equalTo(self);
    }];
    
    [tagBtn1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.right.mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(50, 30));
    }];
    
    [tagBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(bottomView);
        make.right.mas_equalTo(tagBtn1.mas_left).mas_offset(-15);
        make.size.mas_equalTo(CGSizeMake(85, 30));
    }];
}

- (void)setInfoModel:(PMOrderDetailInfoModel *)infoModel{
    _infoModel = infoModel;
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单号：%@",infoModel.order_no];
    self.label1.text = [NSString stringWithFormat:@"支付宝交易号：%@",infoModel.pay_no];
    self.label2.text = [NSString stringWithFormat:@"下单时间：%@",infoModel.time];
    if (infoModel.timea) {
         self.label3.text = [NSString stringWithFormat:@"付款时间：%@",infoModel.timea];
    }else{
        self.label3.hidden = YES;
    }
    if (infoModel.timeb) {
         self.label4.text = [NSString stringWithFormat:@"发货时间：%@",infoModel.timeb];
    }else{
        self.label4.hidden = YES;
    }

   
}

- (void)copyClick{
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = self.orderNoLabel.text;
    if (self.copyBlcok) {
        self.copyBlcok();
    }
}
- (void)tagBtnClick{
    if (self.tagBtnBlcok) {
        self.tagBtnBlcok();
    }
}
- (void)tagBtn1Click{
    if (self.tagBtn1Blcok) {
        self.tagBtn1Blcok();
    }
}
@end
