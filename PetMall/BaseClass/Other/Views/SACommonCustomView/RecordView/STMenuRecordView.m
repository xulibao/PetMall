//
//  STMenuRecordView.m
//  SnailTruck
//
//  Created by 唐欢 on 16/5/28.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "STMenuRecordView.h"
#import "SAMenuRecordModel.h"
// 筛选记录板字体大小
#define kRecordFont 13
// 筛选记录板字体间隙
#define kRecordMargin 10
// 筛选记录板字体高度
#define kRecordHeight 25
// 筛选记录板当前、订阅、重置 按钮宽度
#define kRecordBtnWith 30
@implementation STMenuRecordView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.recordArray = [NSMutableArray array];
    }
    return self;
}

- (void)setRecordArray:(NSMutableArray *)recordArray{
    
    _recordArray = recordArray;
    
    [self removeAllSubviews];
    recordArray.count ? (self.hidden = NO) : (self.hidden = YES);
    
    
    // 1.当前
//    UILabel * now = [[UILabel alloc] initWithFrame:CGRectMake(kRecordMargin, kRecordMargin/2, kRecordBtnWith, kRecordHeight)];
//    now.font = [UIFont systemFontOfSize:kRecordFont];
//    now.text = @"当前";
//    [self addSubview:now];
    
    // 2.重置
    UIButton * resetBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [resetBtn setTitle:@"重置" forState:UIControlStateNormal];
    [resetBtn setImage:IMAGE(@"carList_reset") forState:UIControlStateNormal];
    [resetBtn setTitleColor:kColorTextGay forState:UIControlStateNormal];
    [self addSubview:resetBtn];
//    resetBtn.frame = CGRectMake(kMainBoundsWidth-kRecordMargin-kRecordBtnWith, kRecordMargin/2, kRecordBtnWith, kRecordHeight);
    resetBtn.titleLabel.font = [UIFont systemFontOfSize:kRecordFont];
    [resetBtn addTarget:self action:@selector(resetBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [resetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).mas_offset(-10);
        make.centerY.mas_equalTo(self);
    }];
    
    // 4.选择的按钮
    CGFloat totalWith = kMainBoundsWidth-kRecordBtnWith-kRecordMargin*3;// 板子的总宽度限制
    NSInteger currentRow = 0;
    CGFloat pluseWith = 0.0;// 累计的宽度
    for (int i = 0; i<recordArray.count; i++) {
        
        SAMenuRecordModel *model = recordArray[i];
        
        STMenuSelectRecordBtn * btn = [[STMenuSelectRecordBtn alloc] init];
        btn.model = model;
        [btn setImage:IMAGE(@"carList_delete") forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:kRecordFont];
//        btn.layer.borderWidth = 0.5;
//        btn.layer.borderColor = kColorTextBlack.CGColor;
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitleColor:kColorTextBlack forState:UIControlStateNormal];

        [btn setTitle:model.name forState:UIControlStateNormal];
        CGFloat singleBtnWith = [btn.titleLabel.text sizeWithFont:[UIFont systemFontOfSize:kRecordFont] MaxSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
        
        btn.width = singleBtnWith+30;
        btn.height = kRecordHeight;
        
        btn.x = pluseWith+kRecordMargin;

        if (pluseWith+btn.width >totalWith) {
            btn.x = kRecordMargin;
            currentRow+=1;
            pluseWith = 0;
        }
        
        
        btn.y = (kRecordMargin/2+kRecordHeight)*currentRow + kRecordMargin/2;

        
        
        
        pluseWith += btn.width+kRecordMargin;
        
        [self addSubview:btn];
   
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    self.width = kMainBoundsWidth;
    self.height = CGRectGetMaxY(self.subviews.lastObject.frame)+kRecordMargin/2;
    
}

#pragma mark - 点击重置
- (void)resetBtnClick{
    if ([self.delegate respondsToSelector:@selector(menuRecordViewDeleteAll:)]) {
        [self.delegate menuRecordViewDeleteAll:self];
    }
}


#pragma mark - 点击标签
- (void)btnClick:(STMenuSelectRecordBtn*)btn{

    if ([self.delegate respondsToSelector:@selector(menuRecordView:didSelectBtn:)]) {
        [self.delegate menuRecordView:self didSelectBtn:btn];
    }
}

@end
