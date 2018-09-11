//
//  SAMessageButton.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SAMessageButton.h"

@interface SAMessageButton()

@property (nonatomic, strong) UILabel *messageCountL;

@end

@implementation SAMessageButton

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setImage:IMAGE(@"mine_message") forState:UIControlStateNormal];
        _messageCountL = [UILabel creatLable:CGRectZero andWithString:@"" andFontNum:7];
        _messageCountL.textColor = [UIColor whiteColor];
        _messageCountL.backgroundColor = kColorBGRed;
        [self addSubview:_messageCountL];
    }
    return self;
}
- (void)setMessageCount:(NSString *)messageCount{
    _messageCount = messageCount;
    if (messageCount && messageCount.integerValue > 99) {
        messageCount = @"99+";
    }
    if (messageCount && messageCount.integerValue < 1) {
        _messageCountL.hidden = YES;
    }else{
        _messageCountL.hidden = NO;
    }
    CGSize tempSize = [messageCount sizeWithFont:[UIFont systemFontOfSize:7] MaxSize:CGSizeMake(100, 100)];
    _messageCountL.text = messageCount;
    _messageCountL.frame = CGRectMake(self.width - tempSize.width, -3, tempSize.width + 2, tempSize.height + 2);
    [_messageCountL setLayerWithCornerRadius:(tempSize.height + 2)*0.5 borderWidth:1 borderColor:[UIColor clearColor] masksToBounds:YES];
}

@end
