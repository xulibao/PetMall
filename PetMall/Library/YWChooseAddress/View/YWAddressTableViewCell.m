//
//  YWAddressTableViewCell.m
//  YWChooseAddressView
//
//  Created by 90Candy on 17/12/26.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "YWAddressTableViewCell.h"
#import "YWAddressModel.h"

static  CGFloat  const  YWFontH = 22; //地址字体高度限制

@interface YWAddressTableViewCell ()

@property (strong, nonatomic) UILabel       *addressNameLabel;    // 地址名称
@property (strong, nonatomic) UIImageView   *selectFlagImageView; // 选中标志

@end

@implementation YWAddressTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self addSubview:self.addressNameLabel];
        [self addSubview:self.selectFlagImageView];
    }
    return self;
}


- (void)setItem:(YWAddressModel *)item {
    
    _item = item;
    _addressNameLabel.text = item.name;
    CGSize fontSize = [self getSizeByString:item.name sizeConstraint:CGSizeMake(kMainBoundsWidth, 22) font:[UIFont systemFontOfSize:14]];
    _addressNameLabel.frame = CGRectMake(20, 10, fontSize.width, YWFontH);
    _addressNameLabel.textColor = item.isSelected ? kColorFF3945 : [UIColor blackColor];
    _selectFlagImageView.hidden = !item.isSelected;
    _selectFlagImageView.frame = CGRectMake(CGRectGetMaxX(_addressNameLabel.frame) + 5, 14.5, 11, 8);
}

- (UILabel *)addressNameLabel {
    if (!_addressNameLabel) {
        _addressNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 10, 100, YWFontH)];
        _addressNameLabel.font = [UIFont systemFontOfSize:14];
        _addressNameLabel.textColor = [UIColor blackColor];
    }
    return _addressNameLabel;
}

- (UIImageView *)selectFlagImageView {
    if (!_selectFlagImageView) {
        _selectFlagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine_address_duigou"]];
        _selectFlagImageView.frame = CGRectMake(CGRectGetMaxX(self.addressNameLabel.frame) + 5, 14.5, 15, 15);
        _selectFlagImageView.hidden = YES;
    }
    return _selectFlagImageView;
}
// 传入字符串，计算大小2
- (CGSize)getSizeByString:(NSString *)string sizeConstraint:(CGSize)sizeConstraint font:(UIFont *)font {
    CGSize size = [string boundingRectWithSize:sizeConstraint
                                       options:NSStringDrawingTruncatesLastVisibleLine
                   | NSStringDrawingUsesLineFragmentOrigin
                   | NSStringDrawingUsesFontLeading
                                    attributes:@{NSFontAttributeName:font}
                                       context:nil].size;
    size.width += 8;
    return size;
}
@end

