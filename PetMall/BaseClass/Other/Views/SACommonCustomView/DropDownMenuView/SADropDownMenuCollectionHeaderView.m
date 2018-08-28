//
//  SADropDownMenuCollectionHeaderView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/27.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SADropDownMenuCollectionHeaderView.h"

@interface SADropDownMenuCollectionHeaderView()

@property(nonatomic,strong)UILabel *titleLable;

@end

@implementation SADropDownMenuCollectionHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
    
        
        _titleLable=[[UILabel alloc]init];
        _titleLable.textColor = kColorTextBlack;
        [self addSubview:_titleLable];
        _titleLable.font=[UIFont systemFontOfSize:18];
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.offset(15);
            make.centerY.equalTo(self.mas_centerY);
        }];
        
    }return self;
}

- (void)setHeaderStr:(NSString *)headerStr{
    _headerStr = headerStr;
    self.titleLable.text = headerStr;
}

@end
