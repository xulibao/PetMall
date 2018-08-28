//
//  SADropDownMenuCollectionFooterView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/27.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SADropDownMenuCollectionFooterView.h"
#import "SAMenuRecordModel.h"

@interface SADropDownMenuCollectionFooterView()
@property (nonatomic, strong) UIView * footerView;
@property(nonatomic, copy) NSString * minYear;
@property(nonatomic, copy) NSString * maxYear;
@property(nonatomic, copy) NSString * yearStr;
@property(nonatomic, copy) NSString * minMileage;
@property(nonatomic, copy) NSString * maxMileage;
@property(nonatomic, copy) NSString * mileageStr;

@property(nonatomic, strong) NSMutableArray *recordArray;
@end
@implementation SADropDownMenuCollectionFooterView
- (NSMutableArray *)recordArray{
    if (_recordArray == nil) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

- (void)setIsYearValue:(BOOL)isYearValue{
    _isYearValue = isYearValue;
    if (!isYearValue) {
        [self.yearSlider updateWithLeftValue:0 rightValue:100000];
    }
}

- (void)setIsMileageValue:(BOOL)isMileageValue{
    _isMileageValue = isMileageValue;
    if (!isMileageValue) {
        [self.mileageSlider updateWithLeftValue:0 rightValue:100000];
    }
}



-(instancetype)initWithFrame:(CGRect)frame{
    if (self=[super initWithFrame:frame]) {
        self.minYear = [@(0) stringValue];
        self.maxYear = [@(100000) stringValue];
        self.minMileage = [@(0) stringValue];
        self.maxMileage = [@(100000) stringValue];
        self.yearStr = @"不限";
        self.mileageStr = @"不限";
        [self addSubview:self.footerView];
    }return self;
}
- (UIView *)footerView{
    if (_footerView == nil) {
        _footerView = [[UIView alloc] init];
        _footerView.frame = CGRectMake(0, 0, kMainBoundsWidth, 250);
        CGFloat viewW = kMainBoundsWidth - 2 * 25;
        //车龄
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 15, 100, 20)];
        [_footerView addSubview:titleLabel];
        NSMutableAttributedString * attStr = [[NSMutableAttributedString alloc] initWithString:@"车龄（年）" attributes:@{NSForegroundColorAttributeName:kColorTextGay}];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0]}  range:NSMakeRange(0, 2)];
        titleLabel.attributedText = attStr;
        
        //数值变化区域
        UILabel *valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainBoundsWidth - 110, titleLabel.y, 100, 20)];
        valueLabel.textColor = kColorTextRed;
        valueLabel.textAlignment = NSTextAlignmentRight;
        [_footerView addSubview:valueLabel];
        STValueSlider * view = [[STValueSlider alloc] initWithFrame:CGRectMake((kMainBoundsWidth - viewW) *0.5 , 40, viewW, 60)];
        self.yearSlider = view;
        [_footerView addSubview:view];
        view.minIntervalValue = 3;
        view.maxValue = 15;
        view.totalSection = 5;
        view.callBack = ^(NSInteger minValue,NSInteger maxValue){
            self.minYear = [@(minValue) stringValue];
            self.maxYear = [@(maxValue) stringValue];
            if (minValue == 0) {
                if (maxValue >15) {
                    valueLabel.text = @"不限";
                }else{
                    valueLabel.text = [NSString stringWithFormat:@"%ld年以下",maxValue];
                }
            }else if ( 0 < minValue && minValue<= 15 ){
                if (maxValue > 15) {
                    valueLabel.text = [NSString stringWithFormat:@"%ld年以上",minValue];
                }else{
                    valueLabel.text = [NSString stringWithFormat:@"%ld-%ld年",minValue,maxValue];
                }
            }else{
                valueLabel.text = @"15年以上";
            }
            self.yearStr = valueLabel.text;
        };
        
        //行驶里程
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 115, 200, 20)];
        [_footerView addSubview:titleLabel];
        attStr = [[NSMutableAttributedString alloc] initWithString:@"行驶里程（万公里）" attributes:@{NSForegroundColorAttributeName:kColorTextGay}];
        [attStr addAttributes:@{NSForegroundColorAttributeName:[UIColor blackColor],NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0]}  range:NSMakeRange(0, 4)];
        titleLabel.attributedText = attStr;
        
        //数值变化区域
        valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(kMainBoundsWidth - 210, titleLabel.y, 200, 20)];
        valueLabel.textColor = kColorTextRed;
        valueLabel.textAlignment = NSTextAlignmentRight;
        [_footerView addSubview:valueLabel];
        view = [[STValueSlider alloc] initWithFrame:CGRectMake((kMainBoundsWidth - viewW) *0.5 , 40 + 100, viewW, 60)];
        self.mileageSlider = view;
        [_footerView addSubview:view];
        view.minIntervalValue = 5;
        view.maxValue = 60;
        view.totalSection = 6;
        valueLabel.text = @"不限";
        view.callBack = ^(NSInteger minValue,NSInteger maxValue){
            self.minMileage = [@(minValue) stringValue];
            self.maxMileage = [@(maxValue) stringValue];
            if (minValue == 0) {
                if (maxValue >60) {
                    valueLabel.text = @"不限";
                }else{
                    valueLabel.text = [NSString stringWithFormat:@"%ld万公里以下",maxValue];
                }
            }else if ( 0 < minValue && minValue<= 60 ){
                if (maxValue > 60) {
                    valueLabel.text = [NSString stringWithFormat:@"%ld万公里以上",minValue];
                }else{
                    valueLabel.text = [NSString stringWithFormat:@"%ld-%ld万公里",minValue,maxValue];
                }
            }else{
                valueLabel.text = @"60万公里以上";
            }
            self.mileageStr = valueLabel.text;
        };
        
        
        UIButton * resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
        resetBtn.frame = CGRectMake((kMainBoundsWidth - 2 * 100 - 30) * 0.5 , 200, 100, 30);
        resetBtn.layer.cornerRadius = 5;
        resetBtn.layer.borderColor = kColorBGRed.CGColor;
        resetBtn.layer.borderWidth =1;
        resetBtn.clipsToBounds = YES;
        [_footerView addSubview:resetBtn];
        [resetBtn setTitleColor:kColorBGRed forState:UIControlStateNormal];
        [resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton * confiremBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        confiremBtn.frame = CGRectMake(0, 200, 100, 30);
        confiremBtn.layer.cornerRadius = 5;
        resetBtn.clipsToBounds = YES;
        confiremBtn.backgroundColor = kColorBGRed;
        [confiremBtn setTitle:@"确定" forState:UIControlStateNormal];
        confiremBtn.frame = CGRectMake( CGRectGetMaxX(resetBtn.frame) + 30, resetBtn.y, resetBtn.width, 30);
        [_footerView addSubview:confiremBtn];
        [confiremBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confiremBtn addTarget:self action:@selector(confiremBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_footerView addLineViewisTop:YES leftInterval:0 andRightInterval:0];
    }
    return _footerView;
}

- (void)confiremBtnClick{
    [self.recordArray removeAllObjects];
    if (![self.yearStr isEqualToString:@"不限"] ) {
        SAMenuRecordModel * model = [[SAMenuRecordModel alloc] init];
        model.name = self.yearStr;
        model.serveKey = @"carAgeEnd";
        model.serveSubKey = @"carAgeStart";
        model.serveID = [self.maxYear integerValue] > 15 ? @"" :self.maxYear;
        model.serveSubID = self.minYear;
        [self.recordArray addObject:model];
    }
    if (![self.mileageStr isEqualToString:@"不限"] ) {
        SAMenuRecordModel * model = [[SAMenuRecordModel alloc] init];
        model.name = self.mileageStr;
        model.serveKey = @"mileageEnd";
        model.serveSubKey = @"mileageStart";
        model.serveID = [self.maxMileage integerValue] > 60 ? @"" : self.maxMileage;
        model.serveSubID = self.minMileage;
        [self.recordArray addObject:model];
    }
    
    
    
    
    if (self.confiremCallBack) {
        self.confiremCallBack(self.recordArray);
    }
}

- (void)resetBtnClick{
    [self.yearSlider updateWithLeftValue:0 rightValue:100000];
    [self.mileageSlider updateWithLeftValue:0 rightValue:100000];
    if (self.resetCallBack) {
        self.resetCallBack();
    }
}
@end
