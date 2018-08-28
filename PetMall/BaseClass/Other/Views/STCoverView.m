//
//  STCoverView.m
//  SnailTruck
//
//  Created by 唐欢 on 15/11/5.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#import "STCoverView.h"

@interface STCoverView()
@property(nonatomic, copy)void(^clickBlock)(UIView*);
@end
@implementation STCoverView

- (instancetype)initWithSuperView:(UIView *)container complete:(void (^)(UIView *))clickBlock{
    if (self = [super init]) {
        self.frame = container.bounds;
        self.clickBlock = clickBlock;
            UIButton* coverBtn = [[UIButton alloc] init];
            coverBtn.backgroundColor = RGBA(0, 0, 0, 0.3);
            [coverBtn addTarget:self action:@selector(coverBtnClick:) forControlEvents:UIControlEventTouchUpInside];
            coverBtn.frame = CGRectMake(0, 0, container.width, container.height);
            [self addSubview:coverBtn];

//        }
        [container addSubview:self];

    }
    return self;
}

- (void)coverBtnClick:(UIButton*)btn{
    if (self.clickBlock) {
        self.clickBlock(self);
    }

}

- (void)blockClick:(UIGestureRecognizer*)ges{
   
    if (self.clickBlock) {
        self.clickBlock(self);
    }
}

@end
