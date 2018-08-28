//
//  STGroupPlainTextView.h
//  SnailAuction
//
//  Created by imeng on 26/02/2018.
//  Copyright © 2018 GhGh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "STGroupSectionView.h"

@interface STGroupPlainTextView : UIView

@property(nonatomic, strong) STGroupSectionView *section;
@property(nonatomic, strong) UILabel *textLabel;

@property(nonatomic, copy) NSString *sectionTitle;
@property(nonatomic, copy) NSAttributedString *sectionDesc;

@property(nonatomic, copy) NSAttributedString *text;

@end
