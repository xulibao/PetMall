//
//  STGroupPlainTextView.m
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import "STGroupPlainTextView.h"

@implementation STGroupPlainTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        _section = [[STGroupSectionView alloc] init];
        [self addSubview:_section];
        
        [_section mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(self);
        }];
        
        _textLabel = [[UILabel alloc] init];
        _textLabel.numberOfLines = 0;
        [self addSubview:_textLabel];
        
        [_textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(self.section.mas_bottom).mas_offset(10);
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-15);
            make.bottom.mas_equalTo(-10);
        }];
        
    }
    return self;
}

- (void)setSectionTitle:(NSString *)sectionTitle {
    _sectionTitle = sectionTitle;
    [self.section setTitle:_sectionTitle];
}

- (void)setSectionDesc:(NSAttributedString *)sectionDesc {
    _sectionDesc = sectionDesc;
    [self.section setDesc:_sectionDesc];
}

- (void)setText:(NSAttributedString *)text {
    _text = text;
    [self.textLabel setAttributedText:_text];
}

@end
