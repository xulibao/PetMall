
//  SACommonInfoCell.m
//  SnailAuction
//
//  Created by imeng on 2018/2/8.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SACommonInfoCell.h"

#import "SATruckInfoConstValue.h"
#import "CALayer+SALayer.h"

#import <UITableView+FDTemplateLayoutCell/UITableView+FDTemplateLayoutCell.h>

#import "SAInfoItemProtocol.h"
//#import <YYWebImage/YYWebImage.h>
#import <SDWebImage/UIImageView+WebCache.h>

#import "SALotInfoItem.h"

@interface SACommonInfoCell () <STCommonTableViewItemUpdateDelegate>

@property(nonatomic, assign) SAAuctionStatus status;    //拍卖状态    number    1.预展中(竞拍未开始) 2.竞拍中

@end

@implementation SACommonInfoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIView *selectedBackgroundView = [[UIView alloc] init];
        selectedBackgroundView.backgroundColor = [UIColor colorWithRed:238.0/255.0 green:239.0/255.0 blue:241.0/255.0 alpha:1];
        selectedBackgroundView.userInteractionEnabled = YES;
        self.selectedBackgroundView = selectedBackgroundView;

        self.fd_enforceFrameLayout = YES;
        self.backgroundColor = [UIColor clearColor];
        
        _whiteBackground = [[UIView alloc] init];
        _whiteBackground.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:_whiteBackground];
        
        _infoView = [[SATruckInfoBaseView alloc] init];
        [self.contentView addSubview:_infoView];
        
        _bottomView = [[SATruckInfoBaseBottomView alloc] init];
        [self.contentView addSubview:_bottomView];
        
        _dashLayer = [CALayer sa_seperatorDashLayerWithLineLength:3
                                                      lineSpacing:2
                                                        lineWidth:PixelOne
                                                        lineColor:UIColorFromRGB(0xE0E0E0).CGColor
                                                     isHorizontal:YES];
        [self.contentView.layer addSublayer:_dashLayer];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGSize infoSize = [_infoView sizeThatFits:self.size];
    _infoView.frame = (CGRect){CGPointZero, infoSize};

    _dashLayer.frame = (CGRect){k_padding_15, CGRectGetMaxY(_infoView.frame) , self.width - k_padding_15, PixelOne};
    
    CGSize bottomSize = [_bottomView sizeThatFits:self.size];
    _bottomView.frame = (CGRect){0, CGRectGetMaxY(_infoView.frame), bottomSize};
  
            _whiteBackground.frame = (CGRect){CGPointZero, self.width, CGRectGetMaxY(_bottomView.frame)};

}

- (CGSize)sizeThatFits:(CGSize)size {
    CGSize resultSize = size;
    
    CGSize infoSize = [self.infoView sizeThatFits:size];
    CGSize bottomSize = [self.bottomView sizeThatFits:size];

    CGFloat resultWidth = size.width;
    resultSize.width = fmin(resultWidth, size.width);
    
    CGFloat resultHeight = infoSize.height + bottomSize.height + k_padding_10;
    resultSize.height = resultHeight;
    
    return resultSize;
}

- (void)updateViewData:(id<SACommonListInfoItem>)viewData {
    NSURL *imageURL = [viewData respondsToSelector:@selector(imageURL)] ? viewData.imageURL : nil;
    NSAttributedString *label0Text = [viewData respondsToSelector:@selector(label0Text)] ? viewData.label0Text : nil;//  标题 （北京 中国重汽 HOKA ）牵引车 590 匹 6X4
    NSAttributedString *label1Text = [viewData respondsToSelector:@selector(label1Text)] ? viewData.label1Text : nil;//  地址和日期 （北京 2019年7月）
    NSAttributedString *label3Text = [viewData respondsToSelector:@selector(label3Text)] ? viewData.label3Text : nil;//  国三
    NSAttributedString *label4Text = [viewData respondsToSelector:@selector(label4Text)] ? viewData.label4Text : nil;//  已下架
    
    SATruckInfoBaseView *infoView0 = self.infoView;
    [infoView0.imageView sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"empty_icon"]];
//    [infoView0.imageView yy_setImageWithURL:imageURL placeholder:[UIImage imageNamed:@"empty_icon"]];
    infoView0.label0.text = label0Text.string;//  标题 （北京 中国重汽 HOKA ）牵引车 590 匹 6X4
    infoView0.label1.text = label1Text.string;//  地址和日期 （北京 2019年7月）
    infoView0.label3.text = label3Text.string;//  国三
    infoView0.label4.text = label4Text.string;//  已下架
    
    infoView0.label3.hidden = infoView0.label3.text.length > 0 ? NO : YES;
    infoView0.label4.hidden = !infoView0.label4.text;
    
    [infoView0 setNeedsLayout];

    NSArray<NSAttributedString*> *tagsText = [viewData respondsToSelector:@selector(tagsText)] ? viewData.tagsText : nil;//标签
    
    SATruckInfoBaseBottomView *infoView1 = self.bottomView;
    infoView1.tags = tagsText;
    
    [self updateHotData:viewData];
    [infoView1 setNeedsLayout];
    
    if ([viewData isKindOfClass:[SALotInfoItem class]]) {
        SALotInfoItem *item = (id)viewData;
        self.status = item.status;
    }
}

- (void)updateHotData:(id<SACommonListInfoItem>)viewData {
    NSAttributedString *countDownLabelText = [viewData respondsToSelector:@selector(countDownLabelText)] ? viewData.countDownLabelText : nil;//时间
    self.bottomView.label0.attributedText = countDownLabelText;
    [self.bottomView setNeedsLayout];
    
    NSAttributedString *label2Text = [viewData respondsToSelector:@selector(label2Text)] ? viewData.label2Text : nil;//  当前最高价：29万 当前最高出价：25.9万
    self.infoView.label2.attributedText = label2Text;//  当前最高价：29万
}

#pragma mark - STCommonTableViewItemConfigProtocol

- (void)tableView:(UITableView *)tableView configViewWithData:(id<SACommonListInfoItem>)data AtIndexPath:(NSIndexPath *)indexPath {
    [super tableView:tableView configViewWithData:data AtIndexPath:indexPath];
    [self updateViewData:data];
    [self.infoView setNeedsLayout];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath withViewData:(id<SACommonListInfoItem>)viewData {
    if ([viewData respondsToSelector:@selector(shouldDisplayCountDown)] && viewData.shouldDisplayCountDown) {
        [self updateHotData:viewData];
        if ([viewData respondsToSelector:@selector(addDelegate:)]) {
            [viewData addDelegate:self];
        }
    }
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath*)indexPath withViewData:(id<SACommonListInfoItem>)viewData {
    if ([viewData respondsToSelector:@selector(removeDelegate:)]) {
        [viewData removeDelegate:self];
    }
}

#pragma mark - STCommonTableViewItemUpdateDelegate

- (void)objectDidUpdate:(id<SACommonListInfoItem>)object {
    if ([object isKindOfClass:[SALotInfoItem class]]) {
        SALotInfoItem *item = (id)object;
        if (self.status == item.status) {
            [self updateHotData:object];
        } else {
            [self updateViewData:object];
        }
    }
}

- (void)objectDidExpired:(id)object {
//    [self.parentTableView deleteRowAtIndexPath:self.indexPath withRowAnimation:UITableViewRowAnimationTop];
}

@end

@implementation SACommonInfo1Cell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.infoView.label2.hidden = YES;
    }
    return self;
}

@end
