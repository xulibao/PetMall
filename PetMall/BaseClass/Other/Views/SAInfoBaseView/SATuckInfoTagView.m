//
//  SATuckInfoTagView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/6.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SATuckInfoTagView.h"
#import "SATruckInfoConstValue.h"
@interface SATuckInfoTagView ()

@property (nonatomic,strong) UILabel *label0;

@end

@implementation SATuckInfoTagView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializationSubViews];
    }
    return self;
}

- (void)initializationSubViews{
    UILabel  *label0 = [[UILabel alloc] init];
    self.label0 = label0;
    [self addSubview:label0];
}

- (void)setTagsAtts:(NSArray<NSAttributedString *> *)tagsAtts{
    _tagsAtts = tagsAtts;
    for (int i = 0; i < tagsAtts.count; i++) {
        NSAttributedString * attStr = tagsAtts[i];
        UILabel  *label= [[UILabel alloc] init];
        label.layer.cornerRadius = 3;
//        label.layer.borderColor = [attStr ob]
        label.attributedText = attStr;
        [self addSubview:label];
        [label sizeThatFits:(CGSize){CGFLOAT_MAX,CGFLOAT_MAX}];
        [self.label0 setFrame:(CGRect){i * k_padding_5,0,self.label0.bounds.size.width + k_padding_20,self.label0.bounds.size.height + k_padding_15}];
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];

    
}


@end
