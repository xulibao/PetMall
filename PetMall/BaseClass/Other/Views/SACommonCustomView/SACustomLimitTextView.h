//
//  SACustomLimitTextView.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SACustomLimitTextView,DescTextView;
@protocol SACustomLimitTextViewDelegate <NSObject>

@optional
- (void)textViewDidEditWithText:(SACustomLimitTextView *)textView;

@end

@protocol DescTextViewDelegate <NSObject>

@optional
- (void)textViewEditWithText:(DescTextView *)textView;

@end


@interface DescTextView : UITextView

@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, copy) NSString * placeString;
@property (nonatomic, weak) UIColor * placeLabelColor;
@property (nonatomic, assign) NSInteger maxNumber;//最大位数
@property (nonatomic, weak) id <DescTextViewDelegate> textViewDelegate;

@end

typedef NS_ENUM(NSInteger,TextViewBackGroundModel) {
    /** 无背景 */
    TextViewBackGroundModelForNone,
    /** 有框 */
    TextViewBackGroundModelForRect,
    
};


@interface SACustomLimitTextView : UIView
@property (nonatomic, strong) UILabel *buttonPlaceLabel;
@property (nonatomic, copy) NSString *buttonPlaceText; // 底部文字
@property (nonatomic, copy) NSString * placeString;
@property (nonatomic, weak) UIColor * placeLabelColor;
@property (nonatomic, assign) NSInteger maxNumber;//最大位数
@property (nonatomic, strong) DescTextView * textView;

@property (nonatomic, strong) UIFont * font;
@property (nonatomic, copy)   NSString * text;
@property (nonatomic, strong) UIColor * textColor;
@property (nonatomic, assign) TextViewBackGroundModel backGroundModel;
@property (nonatomic, weak) id <SACustomLimitTextViewDelegate> textViewDelegate;
@property(nonatomic, copy)void (^textViewCallBack)(NSString *text);
@property(nonatomic, copy)void (^textViewBeginEdit)(void);
@end
