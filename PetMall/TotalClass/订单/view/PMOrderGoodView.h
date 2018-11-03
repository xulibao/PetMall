//
//  PMOrderGoodView.h
//  PetMall
//
//  Created by 徐礼宝 on 2018/10/28.
//  Copyright © 2018 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PMOrderListItem.h"

@interface PMOrderGoodView : UIView

@property(nonatomic, strong) PMOrderListItem *data;
@property(nonatomic, strong) UIImageView * cartImageView;
@property(nonatomic, strong) UILabel *cartTitleLabel;
@property(nonatomic, strong) UILabel *cartNatureLabel;
@property(nonatomic, strong) UILabel *cartPriceLabel;
@property(nonatomic, strong) UILabel *cartCountLabel;
@end

