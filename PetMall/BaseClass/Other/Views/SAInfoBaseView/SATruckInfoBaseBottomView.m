//
//  SATuckInfoBaseBottomView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "SATruckInfoBaseBottomView.h"
#import "SATruckInfoConstValue.h"
#import "SAButton.h"

@interface SATruckInfoBaseBottomView()

@end


@implementation SATruckInfoBaseBottomView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initializationSubViews];
    }
    return self;
}

- (void)initializationSubViews{
    
    SAEventHandleLabel  *label0 = [[SAEventHandleLabel alloc] init];
    self.label0 = label0;
    label0.font = UIFontMake(12);
    label0.text = @"开始时间：2018年 6月 5日";
    [self addSubview:label0];
    
    SAFloatLayoutView *tagViews = [[SAFloatLayoutView alloc] init];
    tagViews.contentMode = UIViewContentModeRight;
    tagViews.itemMargins = UIEdgeInsetsMake(0, 5, 0, 0);
    tagViews.minimumItemSize = CGSizeMake(55, 25);
    tagViews.maximumItemSize = CGSizeMake(60, 25);
    self.tagViews = tagViews;
    [self addSubview:tagViews];
}

- (void)setTags:(NSArray<NSAttributedString *> *)tags {
    if (![_tags isEqualToArray:tags]) {
        [self.tagViews removeAllSubviews];
        [tags enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(NSAttributedString * _Nonnull tag, NSUInteger idx, BOOL * _Nonnull stop) {
            SAGhostButton *tagButton;
            tagButton = [[SAGhostButton alloc] init];
            tagButton.tag = idx;
            CGSize size = [tag.string sizeWithAttributes:tag.attributes];
            tagButton.size = CGSizeMake(size.width + 10, size.height + 5);
            tagButton.cornerRadius = tagButton.size.height * 0.5;

//            [tagButton.titleLabel setFont:UIFontMake(13)];
            tagButton.ghostColor = [tag attribute:NSForegroundColorAttributeName
                                          atIndex:(tag.length-1)
                                   effectiveRange:nil];
            //            [tagButton setTitleColor:tagButton.ghostColor forState:UIControlStateNormal];
            [tagButton addTarget:self action:@selector(tagButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            [tagButton setAttributedTitle:tag forState:UIControlStateNormal];
            //            [tags addObject:tag];
            [self.tagViews addSubview:tagButton];

        }];
        [self setNeedsLayout];
    }
    _tags = tags;
}

- (void)tagButtonClick:(SAGhostButton *)btn{
    if (self.tagBtnClick) {
        self.tagBtnClick(btn.tag);
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.label0 sizeToFit];
    [self.label0 setFrame:(CGRect){k_padding_15,(self.height - self.label0.height) / 2,self.label0.width, self.label0.height}];
    
    CGSize size = [self.tagViews sizeThatFits:CGSizeMake(self.width-k_padding_15*2-140, 25)];
    [self.tagViews setFrame:(CGRect){self.width-size.width-k_padding_15,(self.height-size.height)/2,size}];
}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize resultSize = size;
    
    CGSize label0size = [self.label0 sizeThatFits:(CGSize){size.width - k_padding_15 * 2, CGFLOAT_MAX}];
    CGSize tagViewsSize = [self.tagViews sizeThatFits:(CGSize){size.width - label0size.width - k_padding_10, 40}];
    
//    CGFloat resultWidth = label0size.width + tagViewsSize.width;
    resultSize.width = size.width;
    
    CGFloat resultHeight = fmax(k_padding_10 + label0size.height + k_padding_20 , k_padding_10 + tagViewsSize.height + k_padding_15) ;
    resultSize.height = resultHeight;
    
    return resultSize;
}

@end
