//
//  SACustomLimitTextView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SACustomLimitTextView.h"

@interface DescTextView ()


@end

@implementation DescTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpPlaceLabel];
    }
    return self;
}

- (void)setUpPlaceLabel
{
    self.layer.cornerRadius = 3.0f;
    
    
    UILabel * placeLabel = [[UILabel alloc] init];
    placeLabel.textColor = kColorTextLight;
    placeLabel.font = [UIFont systemFontOfSize:13];
    placeLabel.numberOfLines = 0;
    placeLabel.backgroundColor = [UIColor clearColor];
    self.font = placeLabel.font;
    placeLabel.numberOfLines = 0;
    [self addSubview:placeLabel];
    self.placeLabel = placeLabel;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
}

- (void)textChange{
    
    self.placeLabel.hidden = self.text.length != 0;
    
    ////    self.buttonPlaceLabel.text = [NSString stringWithFormat:@"%ld个字",self.text.length];
    //
    //    if (self.text.length > self.maxNumber && self.maxNumber > 0) {
    //        self.text = [self.text substringToIndex:self.maxNumber];
    //    }
    //
    if ([self.textViewDelegate respondsToSelector:@selector(textViewEditWithText:)]) {
        [self.textViewDelegate textViewEditWithText:self];
    }
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setText:(NSString *)text
{
    [super setText:text];
    
    [self textChange];
    if (text.length == 0) {
        self.placeLabel.hidden = NO;
    }
    
}

- (void)setPlaceString:(NSString *)placeString
{
    _placeString = placeString;
    
    self.placeLabel.text = placeString;
    
    [self getPlaceLabelFrame];
    
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeLabel.font = font;
    
    [self getPlaceLabelFrame];
    
    
}
- (void)getPlaceLabelFrame
{
    
    //    self.placeLabel.size = [_placeLabel boundingRectWithSize:CGSizeMake(self.width - 10, MAXFLOAT)];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeLabel.size = [_placeLabel boundingRectWithSize:CGSizeMake(self.width, MAXFLOAT)];
    self.placeLabel.y = 7;
    self.placeLabel.x = 15;
}

@end

@interface SACustomLimitTextView ()<DescTextViewDelegate, UITextViewDelegate>
@property (nonatomic, weak) UILabel *placeLabel;


@end

@implementation SACustomLimitTextView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setButtonPlaceLabel];
    }
    return self;
}

- (void)setButtonPlaceLabel
{
    self.backgroundColor = kColorCellground;
    self.textView = [[DescTextView alloc] init];
    self.textView.textColor = kColorTextGay;
    self.textView.textViewDelegate = self;
    self.textView.delegate = self;
    self.textView.backgroundColor = [UIColor clearColor];
    [self addSubview:self.textView];
    
    self.buttonPlaceLabel = [[UILabel alloc] init];
    self.buttonPlaceLabel.textColor = kColorTextGay;
    self.buttonPlaceLabel.font = [UIFont systemFontOfSize:10];
    self.buttonPlaceLabel.backgroundColor = [UIColor clearColor];
    self.buttonPlaceLabel.numberOfLines = 0;
    self.buttonPlaceLabel.textAlignment = NSTextAlignmentRight;
    self.buttonPlaceLabel.text = @"0/300字数";
    
    [self addSubview:self.buttonPlaceLabel];
}
- (void)setFont:(UIFont *)font
{
    _font = font;
    self.textView.font = font;
}

- (void)setPlaceString:(NSString *)placeString
{
    _placeString = placeString;
    self.textView.placeString = placeString;
}

- (void)setTextColor:(UIColor *)textColor
{
    _textColor = textColor;
    self.textView.textColor = textColor;
    
}
- (void)setMaxNumber:(NSInteger)maxNumber
{
    _maxNumber = maxNumber;
    self.textView.maxNumber = maxNumber;
    [self setButtonPlaceLabelFrame];
}

- (void)setBackGroundModel:(TextViewBackGroundModel)backGroundModel
{
    _backGroundModel = backGroundModel;
    if (backGroundModel) {
        self.layer.borderWidth = 0.5;
        self.layer.borderColor = kColorSeperateLine.CGColor;
        self.layer.cornerRadius = 3.0f;
    }
    
}
- (void)setText:(NSString *)text
{
    _text = text;
    if (![text isEqualToString:self.textView.text]) {
        self.textView.text = text;
        [self setButtonPlaceLabelFrame];
    }
}

#pragma mark 输入框正在编辑

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSString *new = [textView.text stringByReplacingCharactersInRange:range withString:text];
    
    if (new.length >self.maxNumber) {
        
        return NO;
    }
    NSInteger res = self.maxNumber - [new length];
    if(res >= 0){
        if (self.textViewCallBack) {
            self.textViewCallBack(new);
        }
        return YES;
    }
    else{
        NSRange rg = {0,[text length]+res};
        if (rg.length>0) {
            NSString *s = [text substringWithRange:rg];
            [textView setText:[textView.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if (self.textViewBeginEdit) {
        self.textViewBeginEdit();
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if (self.textViewCallBack) {
        self.textViewCallBack(textView.text);
    }
    if ([self.textViewDelegate respondsToSelector:@selector(textViewDidEditWithText:)]) {
        [self.textViewDelegate textViewDidEditWithText:self];
    }
}

- (void)textViewEditWithText:(DescTextView *)textView{
    [self setButtonPlaceLabelFrame];
    
    if ([self.textViewDelegate respondsToSelector:@selector(textViewDidEditWithText:)]) {
        [self.textViewDelegate textViewDidEditWithText:self];
    }
}


- (void)setButtonPlaceLabelFrame{
    self.text = self.textView.text;
    self.buttonPlaceLabel.text = [NSString stringWithFormat:@"%ld/%ld",self.textView.text.length,self.maxNumber];
    CGSize size = [self.buttonPlaceLabel boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT)];
    self.buttonPlaceLabel.frame = CGRectMake(self.width - size.width- 15, self.height - size.height - 10, size.width, size.height);
    
}


- (void)layoutSubviews
{
    NSLog(@"---%f----",self.buttonPlaceLabel.y);
    [self setButtonPlaceLabelFrame];
    self.textView.frame = CGRectMake(0, 0, self.width, self.buttonPlaceLabel.y);
}
@end
