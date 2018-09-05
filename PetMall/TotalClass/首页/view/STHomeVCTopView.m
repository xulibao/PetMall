//
//  STHomeVCTopView.m
//  SnailTruck
//
//  Created by GhGh on 16/6/2.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import "STHomeVCTopView.h"
@interface STHomeVCTopView()
@property (nonatomic, strong) UIView *bgView; // 背景颜色
@property (nonatomic, strong) UIButton *cityBtn;
@property (nonatomic, strong) STHomeVCTopViewMessageBtn *messageBtn;
/* 搜索 */
@property (strong , nonatomic)UIView *topSearchView;
/* 搜索按钮 */
@property (strong , nonatomic)UIButton *searchButton;
@end
@implementation STHomeVCTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        // 消息
        _messageBtn = [[STHomeVCTopViewMessageBtn alloc] init];
        [_messageBtn addTarget:self action:@selector(messageClick) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_messageBtn];
        //
        _cityBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cityBtn addTarget:self action:@selector(cityBtnClick) forControlEvents:UIControlEventTouchUpInside];
        [_cityBtn setTitle:@"狗站" forState:UIControlStateNormal];
        [_cityBtn setTitleColor:[UIColor colorWithHexStr:@"#333333"] forState:UIControlStateNormal];
        _cityBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
        _cityBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self addSubview:_cityBtn];
       
        
        _topSearchView = [[UIView alloc] init];
        _topSearchView.backgroundColor = kColorFAFAFA;
        [self addSubview:_topSearchView];
        
        _searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_searchButton setTitle:@"搜索关键词" forState:UIControlStateNormal];
        [_searchButton setTitleColor:[UIColor colorWithHexStr:@"#C2C2C2"] forState:UIControlStateNormal];
        _searchButton.titleLabel.font = [UIFont systemFontOfSize:12];
        [_searchButton setImage:[UIImage imageNamed:@"home_search"] forState:UIControlStateNormal];
        [_searchButton adjustsImageWhenHighlighted];
        _searchButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _searchButton.titleEdgeInsets = UIEdgeInsetsMake(0, 2 * 10, 0, 0);
        _searchButton.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        [_searchButton addTarget:self action:@selector(searchButtonClick) forControlEvents:UIControlEventTouchUpInside];
        [_topSearchView addSubview:_searchButton];
        
        [_cityBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.centerY.mas_equalTo(self);
            make.width.mas_equalTo(50);
        }];
        
        [_messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.centerY.mas_equalTo(self);
            make.width.mas_equalTo(70);
        }];
        
        [_topSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
            [make.left.mas_equalTo(self.cityBtn.mas_right)setOffset:5];
            [make.right.mas_equalTo(self.messageBtn.mas_left)setOffset:5];
            make.height.mas_equalTo(@(32));
            make.centerY.mas_equalTo(self.cityBtn);
            
        }];
        
        [_searchButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.topSearchView);
            make.top.mas_equalTo(self.topSearchView);
            make.height.mas_equalTo(self.topSearchView);
            [make.right.mas_equalTo(self.topSearchView)setOffset:-2*10];
        }];
    }
    return self;
}
- (void)setMessageCount:(NSString *)messageCount{
    _messageCount = messageCount;
    _messageBtn.messageCount = messageCount;
}


// 点击搜索按钮
- (void)searchButtonClick{
    
}

- (void)messageClick{
    
}

@end


@interface STHomeVCTopViewMessageBtn()
@property (nonatomic, strong) UILabel *messageCountL;
@end

@implementation STHomeVCTopViewMessageBtn
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setImage:IMAGE(@"home_message") forState:UIControlStateNormal];
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
