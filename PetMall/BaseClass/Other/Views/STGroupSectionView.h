//
//  STGroupSectionView.h
//  SnailTruck
//
//  Created by imeng on 8/16/17.
//  Copyright © 2017 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STGroupSectionView : UIView

@property(nonatomic, strong) UIView *iconView;
@property(nonatomic, strong) UILabel *titleLabel;
@property(nonatomic, strong) UIView *lineView;
@property(nonatomic, strong) UILabel *descLabel;

- (void)setTitle:(NSString *)title;
- (void)setIconColor:(UIColor *)color;

- (void)setDesc:(NSAttributedString *)desc;

@end
