//
//  DCCommentsCntCell.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//Copyright © 2018年 RocketsChen. All rights reserved.
//

#import "DCCommentsCntCell.h"

// Controllers

// Models
#import "DCCommentsItem.h"
// Views
#import "DCComImagesView.h"
#import <SDWebImage/UIImageView+WebCache.h>
// Vendors

// Categories

// Others

@interface DCCommentsCntCell ()

@property (weak, nonatomic) IBOutlet UIImageView *comBgImageView;
@property (weak, nonatomic) IBOutlet UILabel *rebackLabel;
@property (weak, nonatomic) IBOutlet UILabel *comTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *comContentLabel;
@property (weak, nonatomic) IBOutlet UILabel *comNameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *comIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *specificationsLabel;

/* 图片数组 */
@property (strong , nonatomic)DCComImagesView *comImagesView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomCons;

@end

@implementation DCCommentsCntCell

#pragma mark - Intial

- (void)awakeFromNib {
    [super awakeFromNib];

    [self setUpUI];
}

- (void)setUpUI
{
    _comImagesView = [DCComImagesView new];
    _comImagesView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_comImagesView];
    
    _comIconImageView.layer.cornerRadius = 15;
    _comIconImageView.clipsToBounds = YES;
}



#pragma mark - Setter Getter Methods
- (void)setCommentsItem:(DCCommentsItem *)commentsItem
{
    _commentsItem = commentsItem;
    
    [_comIconImageView sd_setImageWithURL:[NSURL URLWithString:@"https://pic4.zhimg.com/383179a483ae1074efaf091c89c8a103_l.jpg"]];
    
    _comBgImageView.hidden = YES;
    _bottomCons.constant = 4; //label有响应尺寸的默认高24；-29 = -24-5；
    _rebackLabel.hidden = _comBgImageView.hidden;
    _comNameLabel.text = [DCSpeedy dc_encryptionDisplayMessageWith:commentsItem.comName WithFirstIndex:2];
    _comTimeLabel.text = commentsItem.comTime;
    _comContentLabel.text = commentsItem.comContent;
//    _specificationsLabel.text = [NSString stringWithFormat:@"规格：%@",commentsItem.comSpecifications];
//    _rebackLabel.text = [NSString stringWithFormat:@"店家回复：%@",commentsItem.comReBack];
    
    if (commentsItem.imgsArray != nil){
        //传输图片
        _comImagesView.frame = commentsItem.imagesFrames;
        _comImagesView.picUrlArray = commentsItem.imgsArray;
        _comImagesView.comContent = commentsItem.comContent; //评论
        _comImagesView.comSpecifications = commentsItem.comSpecifications; //规格
        _comImagesView.hidden = NO;
    }else{
        _comImagesView.hidden = YES;
    }
}

@end
