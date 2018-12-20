//
//  SADropDownMenu.m
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SADropDownMenu.h"
#import "SAButton.h"
#import "SPInfoListFilterViewController.h"
#define BackColor [UIColor whiteColor]
// 选中颜色加深
#define SelectColor [UIColor whiteColor]

@interface NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode;

@end

@implementation NSString (Size)

- (CGSize)textSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size lineBreakMode:(NSLineBreakMode)lineBreakMode
{
    CGSize textSize;
    
    if (CGSizeEqualToSize(size, CGSizeZero))
    {
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        
        textSize = [self sizeWithAttributes:attributes];
    }
    else
    {
        NSStringDrawingOptions option = NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
        //NSStringDrawingTruncatesLastVisibleLine如果文本内容超出指定的矩形限制，文本将被截去并在最后一个字符后加上省略号。 如果指定了NSStringDrawingUsesLineFragmentOrigin选项，则该选项被忽略 NSStringDrawingUsesFontLeading计算行高时使用行间距。（字体大小+行间距=行高）
        NSDictionary *attributes = [NSDictionary dictionaryWithObject:font forKey:NSFontAttributeName];
        CGRect rect = [self boundingRectWithSize:size
                                         options:option
                                      attributes:attributes
                                         context:nil];
        
        textSize = rect.size;
    }
    return textSize;
}

@end

@interface SATableViewCell : UITableViewCell

@property(nonatomic,readonly) UILabel *cellTextLabel;
@property(nonatomic,strong) UIImageView *cellAccessoryView;

-(void)setCellText:(NSString *)text align:(NSString*)align;

@end

@implementation SATableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _cellTextLabel = [[UILabel alloc] init];
        _cellTextLabel.textAlignment = NSTextAlignmentCenter;
        _cellTextLabel.font = [UIFont systemFontOfSize:14.0f];
        [self addSubview:_cellTextLabel];
    }
    return self;
}

-(void)setCellText:(NSString *)text align:(NSString*)align{
    
    _cellTextLabel.text = text;
    // 只取宽度
    CGSize textSize = [text textSizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 14) lineBreakMode:NSLineBreakByWordWrapping];
    //    CGSize textSize = [text sizeWithFont:[UIFont systemFontOfSize:14.0f] constrainedToSize:CGSizeMake(MAXFLOAT, 14)];
    
    CGFloat marginX = 20;
    
    if (![@"left" isEqualToString:align]) {
        marginX = (self.frame.size.width-textSize.width)/2;
    }
    
    _cellTextLabel.frame = CGRectMake(marginX, 0, textSize.width, self.frame.size.height);
    
    if(_cellAccessoryView){
        _cellAccessoryView.frame = CGRectMake(_cellTextLabel.frame.origin.x+_cellTextLabel.frame.size.width+10, (self.frame.size.height-12)/2, 16, 12);
    }
}

-(void)setCellAccessoryView:(UIImageView *)accessoryView{
    
    if (_cellAccessoryView) {
        [_cellAccessoryView removeFromSuperview];
    }
    
    _cellAccessoryView = accessoryView;
    
    _cellAccessoryView.frame = CGRectMake(_cellTextLabel.frame.origin.x+_cellTextLabel.frame.size.width+10, (self.frame.size.height-12)/2, 16, 12);
    
    [self addSubview:_cellAccessoryView];
}

@end

@implementation SADropDownIndexPath
- (instancetype)initWithColumn:(NSInteger)column leftOrRight:(NSInteger)leftOrRight  leftRow:(NSInteger)leftRow row:(NSInteger)row {
    self = [super init];
    if (self) {
        _column = column;
        _leftOrRight = leftOrRight;
        _leftRow = leftRow;
        _row = row;
    }
    return self;
}

+ (instancetype)indexPathWithCol:(NSInteger)col leftOrRight:(NSInteger)leftOrRight leftRow:(NSInteger)leftRow row:(NSInteger)row {
    SADropDownIndexPath *indexPath = [[self alloc] initWithColumn:col leftOrRight:leftOrRight leftRow:leftRow row:row];
    return indexPath;
}
@end
#pragma mark - menu implementation

@interface SADropDownMenu ()
@property (nonatomic, assign) NSInteger currentSelectedMenudIndex;
@property (nonatomic, assign) BOOL show;
@property (nonatomic, assign) NSInteger numOfMenu;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) UIView *backGroundView;
@property (nonatomic, strong) UIView *bottomShadow;
//data source
@property (nonatomic, copy) NSArray *array;
//layers array
@property (nonatomic, copy) NSArray *titles;
@property (nonatomic, copy) NSArray *indicators;
@property (nonatomic, copy) NSArray *bgLayers;
@property (nonatomic, assign) BOOL hadSelected;
@property(nonatomic, strong) NSMutableArray *recordArray;

@end


@implementation SADropDownMenu

#pragma mark - getter
- (NSMutableArray *)recordArray{
    if (_recordArray == nil) {
        _recordArray = [NSMutableArray array];
    }
    return _recordArray;
}

- (UIColor *)indicatorColor {
    if (!_indicatorColor) {
        _indicatorColor = [UIColor blackColor];
    }
    return _indicatorColor;
}

- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor blackColor];
    }
    return _textColor;
}

- (UIColor *)separatorColor {
    if (!_separatorColor) {
        _separatorColor = [UIColor colorWithHexStr:@"#CCCCD2"];
    }
    return _separatorColor;
}

- (SADropDownCollectionModel *)titleForRowAtIndexPath:(SADropDownIndexPath *)indexPath {
    return [self.dataSource menu:self titleForRowAtIndexPath:indexPath];
}

#pragma mark - setter
- (void)setIsSaled:(BOOL)isSaled{
    _isSaled = isSaled;
}

- (void)setDataSource:(id<SADropDownMenuDataSource>)dataSource {
    _btnArray = [NSMutableArray array];
    _dataSource = dataSource;
    if ([_dataSource respondsToSelector:@selector(numberOfColumnsInMenu:)]) {
        _numOfMenu = [_dataSource numberOfColumnsInMenu:self];
    } else {
        _numOfMenu = 1;
    }
    
    CGFloat width = kMainBoundsWidth / _numOfMenu;
    for (int i = 0; i < _numOfMenu; i++) {
        SAButton * btn = [[SAButton alloc] init];
        if (i == 0) {
            btn.selected = YES;
        }
        [_btnArray addObject:btn];
        btn.titleLabel.font = [UIFont systemFontOfSize:14];
        [btn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [btn setTitleColor:kColorFF3945 forState:UIControlStateSelected];
        btn.imagePosition = SAButtonImagePositionRight;
        btn.spacingBetweenImageAndTitle = 3;
         NSString *titleString = [_dataSource menu:self titleForColumn:i];
        SPInfoListFilterModel * filterModel = [_dataSource menu:self modelForColumn:i];
        [btn setImage:IMAGE(filterModel.imageNomalStr) forState:UIControlStateNormal];
        [btn setImage:IMAGE(filterModel.imageSelectStr) forState:UIControlStateSelected];        [btn setImage:IMAGE(filterModel.imageSelectStr) forState:UIControlStateHighlighted];
        [self addSubview:btn];
        btn.tag = i;
        [btn setTitle:titleString forState:UIControlStateNormal];
        [btn setTitle:titleString forState:UIControlStateHighlighted];
        [btn setTitleColor:kColor333333 forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(menuTapped:) forControlEvents:UIControlEventTouchUpInside];
        [btn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(i * width);
            make.top.bottom.mas_equalTo(self);
            make.width.mas_equalTo(width);
        }];
    }
}
#pragma mark - action
- (void)menuTapped:(UIButton *)selectBtn {
    
    
    if(selectBtn.tag == 0) {
        if (!selectBtn.selected) {
            selectBtn.selected = YES;
        }
        for (SAButton *btn in self.btnArray) {
            if (btn.tag == 2) {
                [btn setTitleColor:kColor333333 forState:UIControlStateNormal];
                [btn setImage:IMAGE(@"home_shangxia_nomal") forState:UIControlStateNormal];
            }
            if (selectBtn.tag != btn.tag) {
                btn.selected = NO;
            }
        }
    }else if(selectBtn.tag == 1) {
        selectBtn.selected = !selectBtn.selected;
        for (SAButton *btn in self.btnArray) {
            if (btn.tag == 2) {
                 [btn setTitleColor:kColor333333 forState:UIControlStateNormal];
                [btn setImage:IMAGE(@"home_shangxia_nomal") forState:UIControlStateNormal];
            }
            if (selectBtn.tag != btn.tag) {
                btn.selected = NO;
            }
        }
    }else if(selectBtn.tag == 2) {
         [selectBtn setTitleColor:kColorFF3945 forState:UIControlStateNormal];
        [selectBtn setImage:IMAGE(@"home_shangxia_select") forState:UIControlStateNormal];
        [selectBtn setImage:IMAGE(@"home_shangxia_shang") forState:UIControlStateSelected];        [selectBtn setImage:IMAGE(@"home_shangxia_shang") forState:UIControlStateHighlighted];
        selectBtn.selected = !selectBtn.selected;
        for (SAButton * btn in self.btnArray) {
            if (selectBtn.tag != btn.tag) {
                btn.selected = NO;
            }
        }
    }
    NSInteger tapIndex = selectBtn.tag;
    self.currentSelectedMenudIndex = tapIndex;
    self.isBtnSelected = selectBtn.selected;
    if ([self.delegate respondsToSelector:@selector(menu:tabIndex:)]) {
        [self.delegate menu:self tabIndex:tapIndex];
    }else{
        [self showOrDismissWithIndex:tapIndex];
    }
}

#pragma mark - init method
- (instancetype)initWithOrigin:(CGPoint)origin andHeight:(CGFloat)height {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    self = [self initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, height)];
    if (self) {
        _origin = origin;
        _currentSelectedMenudIndex = -1;
        _show = NO;
        _hadSelected = NO;
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.frame.size.width, self.frame.origin.y + self.frame.size.height, 0, 0) style:UITableViewStylePlain];
        
        _tableView.rowHeight = 38;
        _tableView.separatorColor = [UIColor colorWithRed:220.f/255.0f green:220.f/255.0f blue:220.f/255.0f alpha:1.0];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.autoresizesSubviews = NO;
        self.autoresizesSubviews = NO;
        //self tapped
        self.backgroundColor = [UIColor whiteColor];
        
        //background init and tapped
        _backGroundView = [[UIView alloc] initWithFrame:CGRectMake(origin.x, origin.y, screenSize.width, screenSize.height)];
        _backGroundView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        _backGroundView.opaque = NO;
        UIGestureRecognizer *gesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTapped:)];
        [_backGroundView addGestureRecognizer:gesture];
        
        //add bottom shadow
        _bottomShadow = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-0.5, screenSize.width, 0.5)];
        [self addSubview:_bottomShadow];
    }
    return self;
}


#pragma mark - init support
- (CALayer *)createBgLayerWithColor:(UIColor *)color andPosition:(CGPoint)position {
    CALayer *layer = [CALayer layer];
    
    layer.position = position;
    layer.bounds = CGRectMake(0, 0, self.frame.size.width/self.numOfMenu, self.frame.size.height-1);
    layer.backgroundColor = color.CGColor;
    
    return layer;
}

- (CAShapeLayer *)createIndicatorWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(0, 0)];
    [path addLineToPoint:CGPointMake(5, 5)];
    [path addLineToPoint:CGPointMake(10, 0)];
//    [path closePath];
    [path stroke];
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = [UIColor blackColor].CGColor;
    layer.fillColor = [UIColor whiteColor].CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetPathBoundingBox(bound);
//
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}

- (CAShapeLayer *)createSeparatorLineWithColor:(UIColor *)color andPosition:(CGPoint)point {
    CAShapeLayer *layer = [CAShapeLayer new];
    
    UIBezierPath *path = [UIBezierPath new];
    [path moveToPoint:CGPointMake(self.frame.size.width,10)];
    [path addLineToPoint:CGPointMake(self.frame.size.width, self.frame.size.height -10)];
    
    layer.path = path.CGPath;
    layer.lineWidth = 0.5;
    layer.strokeColor = color.CGColor;
    
    CGPathRef bound = CGPathCreateCopyByStrokingPath(layer.path, nil, layer.lineWidth, kCGLineCapButt, kCGLineJoinMiter, layer.miterLimit);
    layer.bounds = CGPathGetBoundingBox(bound);
    
    CGPathRelease(bound);
    
    layer.position = point;
    
    return layer;
}

- (CATextLayer *)createTextLayerWithNSString:(NSString *)string withColor:(UIColor *)color andPosition:(CGPoint)point {
    
    CGSize size = [self calculateTitleSizeWithString:string];
    
    CATextLayer *layer = [CATextLayer new];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    layer.bounds = CGRectMake(0, 0, sizeWidth + 5, size.height + 0.5);
    layer.string = string;
    layer.fontSize = 15.0;
    layer.alignmentMode = kCAAlignmentCenter;
    layer.foregroundColor = color.CGColor;
    
    layer.contentsScale = [[UIScreen mainScreen] scale];
    
    layer.position = point;
    
    return layer;
}

- (CGSize)calculateTitleSizeWithString:(NSString *)string
{
    CGFloat fontSize = 14.0;
    NSDictionary *dic = @{NSFontAttributeName: [UIFont systemFontOfSize:fontSize]};
    CGSize size = [string boundingRectWithSize:CGSizeMake(280, 0) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:dic context:nil].size;
    return size;
}

#pragma mark - tool
- (void)showOrDismissWithIndex:(NSInteger)tapIndex{
    for (int i = 0; i < _numOfMenu; i++) {
        if (i != tapIndex) {
            [self animateIndicator:_indicators[i] Forward:NO complete:^{
                [self animateTitle:_titles[i] show:NO complete:^{
                    
                }];
            }];
            [(CALayer *)self.bgLayers[i] setBackgroundColor:BackColor.CGColor];
        }
    }
    
    if (tapIndex == _currentSelectedMenudIndex && _show) { // 闭合

        [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView  title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _show = NO;
            _currentSelectedMenudIndex = tapIndex;
        }];
        
        [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:BackColor.CGColor];
    } else { //展开
        _hadSelected = NO;
        _currentSelectedMenudIndex = tapIndex;
      
        self.tableView.tableFooterView = [[UIView alloc] init];
        [_tableView reloadData];
        
        if (_tableView) {
            _tableView.frame = CGRectMake(_tableView.frame.origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        }
            [self animateIdicator:_indicators[tapIndex] background:_backGroundView tableView:_tableView  title:_titles[tapIndex] forward:YES complecte:^{
                _show = YES;
            }];
        [(CALayer *)self.bgLayers[tapIndex] setBackgroundColor:SelectColor.CGColor];
    }
}


- (void)backgroundTapped:(UITapGestureRecognizer *)paramSender{
    [self animateIdicator:_indicators[_currentSelectedMenudIndex] background:_backGroundView tableView:_tableView  title:_titles[_currentSelectedMenudIndex] forward:NO complecte:^{
            _show = NO;
        }];
    [(CALayer *)self.bgLayers[_currentSelectedMenudIndex] setBackgroundColor:BackColor.CGColor];
}

#pragma mark - animation method
- (void)animateIndicator:(CAShapeLayer *)indicator Forward:(BOOL)forward complete:(void(^)())complete {
    [CATransaction begin];
    [CATransaction setAnimationDuration:0.25];
    [CATransaction setAnimationTimingFunction:[CAMediaTimingFunction functionWithControlPoints:0.4 :0.0 :0.2 :1.0]];
    
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation"];
    anim.values = forward ? @[ @0, @(M_PI) ] : @[ @(M_PI), @0 ];
    
    if (!anim.removedOnCompletion) {
        [indicator addAnimation:anim forKey:anim.keyPath];
    } else {
        [indicator addAnimation:anim forKey:anim.keyPath];
        [indicator setValue:anim.values.lastObject forKeyPath:anim.keyPath];
    }
    
    [CATransaction commit];
    
    complete();
}

- (void)animateBackGroundView:(UIView *)view show:(BOOL)show complete:(void(^)())complete {
    if (show) {
        [self.superview addSubview:view];
        [view.superview addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.3];
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.0];
        } completion:^(BOOL finished) {
            [view removeFromSuperview];
        }];
    }
    complete();
}

/**
 *动画显示下拉菜单
 */
- (void)animateTableView:(UITableView *)tableView  show:(BOOL)show complete:(void(^)())complete {
    
    if (show) {
        tableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
        [self.superview addSubview:tableView];
        CGFloat  tableViewHeight = [tableView numberOfRowsInSection:0] * tableView.rowHeight > kMainBoundsHeight - 45 - 64 ? kMainBoundsHeight - 45 - 64 - 50 : [tableView numberOfRowsInSection:0] * tableView.rowHeight;
        [UIView animateWithDuration:0.2 animations:^{
            if (tableView) {
                tableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, tableViewHeight);
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            
            if (tableView) {
                tableView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
            }
            
        } completion:^(BOOL finished) {
            
            if (tableView) {
                [tableView removeFromSuperview];
            }
        }];
    }
    complete();
}

/**
 *动画显示下拉菜单
 */
- (void)animateCollectionView:(UICollectionView *)collectionView show:(BOOL)show complete:(void(^)())complete {
    
    if (show) {
        
        CGFloat collectionViewHeight = 0;
        
        if (collectionView) {
            
            collectionView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
            [self.superview addSubview:collectionView];
            
//            collectionViewHeight = ([collectionView numberOfItemsInSection:0] > 10) ? (5 * 38) : (ceil([collectionView numberOfItemsInSection:0]/2.0) * 38);
            collectionViewHeight = kMainBoundsHeight - 152;
        }
        
        [UIView animateWithDuration:0.2 animations:^{
            if (collectionView) {
                collectionView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, collectionViewHeight);
            }
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            
            if (collectionView) {
                collectionView.frame = CGRectMake(_origin.x, self.frame.origin.y + self.frame.size.height, self.frame.size.width, 0);
            }
        } completion:^(BOOL finished) {
            
            if (collectionView) {
                [collectionView removeFromSuperview];
            }
        }];
    }
    complete();
}

- (void)animateTitle:(CATextLayer *)title show:(BOOL)show complete:(void(^)())complete {
    CGSize size = [self calculateTitleSizeWithString:title.string];
    CGFloat sizeWidth = (size.width < (self.frame.size.width / _numOfMenu) - 25) ? size.width : self.frame.size.width / _numOfMenu - 25;
    title.bounds = CGRectMake(0, 0, sizeWidth + 5, size.height + 0.5);
    complete();
}

- (void)animateIdicator:(CAShapeLayer *)indicator background:(UIView *)background tableView:(UITableView *)tableView title:(CATextLayer *)title forward:(BOOL)forward complecte:(void(^)())complete{
    
    [self animateIndicator:indicator Forward:forward complete:^{
        [self animateTitle:title show:forward complete:^{
            [self animateBackGroundView:background show:forward complete:^{
                [self animateTableView:tableView show:forward complete:^{
                }];
            }];
        }];
    }];
    
    complete();
}


#pragma mark - tableView Set


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSAssert(self.dataSource != nil, @"menu's dataSource shouldn't be nil");
    if ([self.dataSource respondsToSelector:@selector(menu:numberOfRowsInColumn:)]) {
        return [self.dataSource menu:self numberOfRowsInColumn:self.currentSelectedMenudIndex];
    } else {
        NSAssert(0 == 1, @"required method of dataSource protocol should be implemented");
        return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"SADropDownMenuTableCell";
    
    SADropDownMenuTableCell *cell = [SADropDownMenuTableCell cellWith:tableView WithIdentifier:identifier];
    
    if ([self.dataSource respondsToSelector:@selector(menu:modelForRowAtIndexPath:)]) {
        SAMenuRecordModel *model = [self.dataSource menu:self modelForRowAtIndexPath:[SADropDownIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:-1 leftRow:-1 row:indexPath.row]];
        cell.model = model;
    }
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
     SAMenuRecordModel *model = [self.dataSource menu:self modelForRowAtIndexPath:[SADropDownIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:-1 leftRow:-1 row:indexPath.row]];
     SAButton * selectBtn = self.btnArray[self.currentSelectedMenudIndex];
    [selectBtn setTitle:model.name forState:UIControlStateNormal];
    [selectBtn setTitle:model.name forState:UIControlStateSelected];
    [selectBtn setTitle:model.name forState:UIControlStateHighlighted];
    if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
        [self.delegate menu:self didSelectRowAtIndexPath:[SADropDownIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:-1 leftRow:-1 row:indexPath.row]];
    } else {
        //TODO: delegate is nil
    }
}



#pragma mark --UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    SADropDownCollectionModel * selectModel;
    if (0 == indexPath.section) {
        selectModel = self.qudongArray[indexPath.row];
        selectModel.isSelect = !selectModel.isSelect;
        if (selectModel.isSelect) {
            for (SADropDownCollectionModel * model in self.qudongArray) {
                if (![model.serveID isEqualToString:selectModel.serveID]){
                    model.isSelect = NO;
                }
            }
        }
    }else if (1 == indexPath.section){
        selectModel = self.ranliaoArray[indexPath.row];
        selectModel.isSelect = !selectModel.isSelect;
        if (selectModel.isSelect) {
            for (SADropDownCollectionModel * model in self.ranliaoArray) {
                if (![model.serveID isEqualToString:selectModel.serveID]){
                    model.isSelect = NO;
                }
            }
        }
    }else if (2 == indexPath.section){
        selectModel = self.paifangArray[indexPath.row];
        selectModel.isSelect = !selectModel.isSelect;
        if (selectModel.isSelect) {
            for (SADropDownCollectionModel * model in self.paifangArray) {
                if (![model.serveID isEqualToString:selectModel.serveID]){
                    model.isSelect = NO;
                }
            }
        }
    }
    [self.collectionView reloadData];
    
//    if (self.delegate || [self.delegate respondsToSelector:@selector(menu:didSelectRowAtIndexPath:)]) {
//
//        [self confiMenuWithSelectRow:indexPath.row];
//
//        [self.delegate menu:self didSelectRowAtIndexPath:[SADropDownIndexPath indexPathWithCol:self.currentSelectedMenudIndex leftOrRight:-1 leftRow:-1 row:indexPath.row]];
//    } else {
//        //TODO: delegate is nil
//    }
}


@end
