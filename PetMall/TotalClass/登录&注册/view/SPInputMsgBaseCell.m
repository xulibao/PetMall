//
//  SPInputMsgBaseCell.m
//  SnailPlatform
//
//  Created by 徐礼宝 on 2018/5/8.
//  Copyright © 2018年 guangan. All rights reserved.
//

#import "SPInputMsgBaseCell.h"
#import "SABaseInputValidTextField.h"
#import "NSString+STValid.h"

@interface SPInputMsgBaseCell()
@property(nonatomic, strong) SABaseInputValidTextField * bottomTextField;
@property (nonatomic, strong) SPInputMsgBaseModel * model;

@end

@implementation SPInputMsgBaseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self fecthSubViews];
    }
    return self;
}
- (void)fecthSubViews{
    
    self.contentView.backgroundColor = [UIColor whiteColor];
    UIView * bottomView = [[UIView alloc] init];
    bottomView.backgroundColor = kColorBackground;
    [self.contentView addSubview:bottomView];
    
    SABaseInputValidTextField * bottomTextField = [[SABaseInputValidTextField alloc] init];
    self.bottomTextField = bottomTextField;
    bottomTextField.backgroundColor = [UIColor clearColor];
    bottomTextField.textContainerInset = UIEdgeInsetsMake(0, 0, 0, 20);
    bottomTextField.textAlignment = NSTextAlignmentLeft;
    bottomTextField.textColor = kColorTextBlack;
    bottomTextField.font = [UIFont systemFontOfSize:14];
    [bottomTextField addTarget:self action:@selector(handleTextFieldDidChange:) forControlEvents:UIControlEventEditingDidEnd];
    [bottomView addSubview:bottomTextField];
    
    [bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView);
        make.height.mas_equalTo(45);
        make.right.mas_equalTo(self.contentView).mas_offset(-20);
        make.left.mas_equalTo(self.contentView).mas_offset(20);
    }];
    
    
    [bottomTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(bottomView).mas_offset(15);
        make.centerY.mas_equalTo(bottomView);
        make.width.mas_equalTo(200);

    }];
}


- (void)handleTextFieldDidChange:(SABaseInputValidTextField *)baseField{
    self.model.severValue = baseField.text;
    self.model.titleText = baseField.text;
}
#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(SPInputMsgBaseModel *)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    self.model = data;
    self.bottomTextField.keyboardType = data.keyBoardType;
    self.bottomTextField.inputHandle = data.handle;
    self.bottomTextField.placeholder = data.placeholderStr;
 
}



@end
