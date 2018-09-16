//
//  PMShareView.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/16.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMShareView.h"
@interface PMShareView()
@property(nonatomic, strong) UIView * topView;
@end
@implementation PMShareView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if (self) {
        [self fecthSubViews];
    }
    return self;
}
- (void)fecthSubViews{
    self.backgroundColor = [UIColor whiteColor];
    UIView * topView = [[UIView alloc] init];
    self.topView = topView;
    [self addSubview:topView];
    
    
    
    UIButton * bottomBtn = [[UIButton alloc] init];
    [bottomBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [bottomBtn setTitle:@"取消" forState:UIControlStateNormal];
    [bottomBtn setTitleColor:kColor333333 forState:UIControlStateNormal];
    bottomBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:bottomBtn];

    [topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(75);
    }];
    
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.top.mas_equalTo(topView.mas_bottom);
    }];
    
    
}
- (void)cancelClick{
    if (self.cancel) {
        self.cancel();
    }
}

- (void)setBtnArray:(NSArray *)btnArray{
    CGFloat btnW = 45;
    CGFloat margin  = (kMainBoundsWidth -btnW * btnArray.count)/(btnArray.count + 1);
    for (int i = 0; i < btnArray.count; i++) {
        NSString * imageStr = btnArray[i];
        UIButton * btn = [[UIButton alloc] init];
        [btn setImage:IMAGE(imageStr) forState:UIControlStateNormal];
        [self.topView addSubview:btn];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(margin *(i + 1 )+ btnW * i );
            make.centerY.mas_equalTo(self.topView);
        }];
    }

}

@end
