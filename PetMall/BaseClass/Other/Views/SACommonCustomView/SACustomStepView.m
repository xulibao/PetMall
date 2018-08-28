//
//  SACustomStepView.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/9.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SACustomStepView.h"

@interface SACustomStepView()

@property (nonatomic, strong)UIView *lineUndo;
@property (nonatomic, strong)UIView *lineDone;

@property (nonatomic, retain)NSMutableArray *cricleMarks;
@property (nonatomic, retain)NSMutableArray *titleLabels;

@property (nonatomic, strong)UILabel *lblIndicator;

@end


@implementation SACustomStepView

- (instancetype)initWithFrame:(CGRect)frame Titles:(nonnull NSArray *)titles
{
    if ([super initWithFrame:frame])
    {
        _stepIndex = 2;
        
        _titles = titles;
        
        _lineUndo = [[UIView alloc]init];
        _lineUndo.backgroundColor = kColorD8D8D8;
        
        _lineDone = [[UIView alloc]init];
        _lineDone.backgroundColor = kColorFF5554;
        
        [self addSubview:_lineUndo];
        [self addSubview:_lineDone];

        for (NSString *title in _titles)
        {
            UILabel *lbl = [[UILabel alloc]init];
            lbl.text = title;
            lbl.textColor = kColorTextBlack;
            lbl.font = [UIFont systemFontOfSize:14];
            lbl.textAlignment = NSTextAlignmentCenter;
            [self addSubview:lbl];
            [self.titleLabels addObject:lbl];
            
            UIView *cricle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
            cricle.backgroundColor = [UIColor whiteColor];
            cricle.layer.cornerRadius = 10.f / 2;
            cricle.layer.borderColor = [kColor979797 CGColor];
            cricle.layer.borderWidth = 1;
            cricle.layer.masksToBounds = YES;
            [self addSubview:cricle];
            [self.cricleMarks addObject:cricle];
        }
        
        _lblIndicator = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
        _lblIndicator.backgroundColor = kColorFF5554;
        _lblIndicator.layer.cornerRadius = 10.f / 2;
        _lblIndicator.layer.borderColor = [kColorFF5554 CGColor];
        _lblIndicator.layer.borderWidth = 1;
        _lblIndicator.layer.masksToBounds = YES;
        [self addSubview:_lblIndicator];
    }
    return self;
}

#pragma mark - method

- (void)layoutSubviews{
    [super layoutSubviews];
    NSInteger perWidth = self.frame.size.width / self.titles.count;
    
    _lineUndo.frame = CGRectMake(0, 0, self.frame.size.width - perWidth, 1.5);
    _lineUndo.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4);
    
    CGFloat startX = _lineUndo.frame.origin.x;
    
    for (int i = 0; i < _titles.count; i++)
    {
        UIView *cricle = [_cricleMarks objectAtIndex:i];
        if (cricle != nil)
        {
            cricle.center = CGPointMake(i * perWidth + startX, _lineUndo.center.y);
        }
        
        UILabel *lbl = [_titleLabels objectAtIndex:i];
        if (lbl != nil)
        {
            lbl.frame = CGRectMake(perWidth * i, self.frame.size.height / 2, self.frame.size.width / _titles.count, self.frame.size.height / 2);
        }
    }
    
    self.stepIndex = _stepIndex;
}

- (NSMutableArray *)cricleMarks
{
    if (_cricleMarks == nil)
    {
        _cricleMarks = [NSMutableArray arrayWithCapacity:self.titles.count];
    }
    return _cricleMarks;
}

- (NSMutableArray *)titleLabels
{
    if (_titleLabels == nil)
    {
        _titleLabels = [NSMutableArray arrayWithCapacity:self.titles.count];
    }
    return _titleLabels;
}

#pragma mark - public method

- (void)setStepIndex:(int)stepIndex
{
    if (stepIndex >= 0 && stepIndex < self.titles.count)  {
        _stepIndex = stepIndex;
        
         CGFloat perWidth = self.frame.size.width / _titles.count;
        
//        _lblIndicator.text = [NSString stringWithFormat:@"%d", _stepIndex + 1];
        _lblIndicator.center = ((UIView *)[_cricleMarks objectAtIndex:_stepIndex]).center;
        
        _lineDone.frame = CGRectMake(_lineUndo.frame.origin.x, _lineUndo.frame.origin.y, perWidth * _stepIndex, 1.5);
        
        for (int i = 0; i < _titles.count; i++)
        {
            UIView *cricle = [_cricleMarks objectAtIndex:i];
            if (cricle != nil)
            {
                if (i <= _stepIndex)
                {
                    cricle.backgroundColor = kColorFF5554;
                    cricle.layer.borderColor = [kColorFF5554 CGColor];
                }
                else{
                    cricle.layer.borderColor = [kColor979797 CGColor];
                    cricle.backgroundColor = [UIColor whiteColor];
                }
            }
            
            UILabel *lbl = [_titleLabels objectAtIndex:i];
            if (lbl != nil)
            {
                if (i <= stepIndex)
                {
                    lbl.textColor = kColorFF5554;
                }
                else
                {
                    lbl.textColor = kColorTextBlack;
                }
            }
        }
    }
}

- (void)setStepIndex:(int)stepIndex Animation:(BOOL)animation
{
    if (stepIndex >= 0 && stepIndex < self.titles.count){
        
        _stepIndex = stepIndex;
        
        CGFloat perWidth = self.frame.size.width / _titles.count;
        
        //        _lblIndicator.text = [NSString stringWithFormat:@"%d", _stepIndex + 1];
        _lblIndicator.center = ((UIView *)[_cricleMarks objectAtIndex:_stepIndex]).center;
        
        if (animation){
            [UIView animateWithDuration:0.7 animations:^{
                _lineDone.frame = CGRectMake(_lineUndo.frame.origin.x, _lineUndo.frame.origin.y, perWidth * _stepIndex, 1.5);

            } completion:^(BOOL finished) {
                [self fetchSubViewsChange:stepIndex];
            }];
 
        }else{
            _lineDone.frame = CGRectMake(_lineUndo.frame.origin.x, _lineUndo.frame.origin.y, perWidth * _stepIndex, 1.5);
            [self fetchSubViewsChange:stepIndex];
        }
    
        
    }
    
}

- (void)fetchSubViewsChange:(int)stepIndex{
    for (int i = 0; i < _titles.count; i++) {
        UIView *cricle = [_cricleMarks objectAtIndex:i];
        if (cricle != nil){
            if (i <= _stepIndex){
                cricle.backgroundColor = kColorFF5554;
                cricle.layer.borderColor = [kColorFF5554 CGColor];
            }else{
                cricle.layer.borderColor = [kColor979797 CGColor];
                cricle.backgroundColor = [UIColor whiteColor];
            }
        }
        UILabel *lbl = [_titleLabels objectAtIndex:i];
        if (lbl != nil){
            if (i <= stepIndex){
                lbl.textColor = kColorFF5554;
            }else{
                lbl.textColor = kColorTextBlack;
            }
        }
    }

}

@end
