//
//  STMenuRecordView.h
//  SnailTruck
//
//  Created by 唐欢 on 16/5/28.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STMenuSelectRecordBtn.h"

typedef NS_ENUM(NSInteger, BtnClickType) {
    kBtnRestClick,// 点击重置
    kBtnSubscribeClick// 点击订阅
};

@class STMenuRecordView;
@protocol STMenuRecordViewDelegate <NSObject>

// 点击标签按钮
- (void)menuRecordView:(STMenuRecordView *)view didSelectBtn:(STMenuSelectRecordBtn *)btn;

// 点击重置
- (void)menuRecordViewDeleteAll:(STMenuRecordView *)view;

@end
@interface STMenuRecordView : UIView

@property(nonatomic, strong) NSMutableArray *recordArray;

@property(nonatomic, weak) id<STMenuRecordViewDelegate> delegate;

@end
