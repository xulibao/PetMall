//
//  SATuckInfoBaseBottomView.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAEventHandleLabel.h"
#import "SAFloatLayoutView.h"

@interface SATruckInfoBaseBottomView : UIView

@property (nonatomic,strong) SAEventHandleLabel *label0;
@property (nonatomic, strong) SAFloatLayoutView *tagViews;

@property(nonatomic, copy) NSArray<NSAttributedString*> *tags;

@end
