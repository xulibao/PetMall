//
//  PMMyCommentItem.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMMyCommentItem.h"
#import "PMMyCommentCell.h"
#define MiddleImageH (ScreenW - 50)/4
#define MiddleImageW  MiddleImageH

@implementation PMMyCommentItem
@synthesize cellClass = _cellClass;
- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [PMMyCommentCell class];
    }
    return _cellClass;
}
+ (NSDictionary *)mj_replacedKeyFromPropertyName{
    return @{@"goodId":@"id"};
}

- (NSString *)goods_logo{
    if (![_goods_logo hasPrefix:[STNetworking host]]) {
        _goods_logo = [NSString stringWithFormat:@"%@%@",[STNetworking host],_goods_logo];
    }
    return _goods_logo;
}

//- (NSString *)img{
//    if (![_img hasPrefix:[STNetworking host]]) {
//        _img = [NSString stringWithFormat:@"%@%@",[STNetworking host],_img];
//    }
//    return _img;
//}

- (NSMutableArray *)goodsImageArray{
    if (_goodsImageArray == nil) {
        NSArray *picArray = [self.user_images componentsSeparatedBySthString:@"|"];
        _goodsImageArray = [@[] mutableCopy];
        for (NSString * imageStr in picArray) {
            if (![imageStr hasPrefix:[STNetworking host]]) {
                [_goodsImageArray addObject:[NSString stringWithFormat:@"%@%@",[STNetworking host],imageStr]];
            }
        }
    }
    return _goodsImageArray;
}

- (CGFloat)cellHeight
{
    if (_cellHeight) return _cellHeight;
    
    CGFloat top = 50;
    CGFloat contentH = [DCSpeedy dc_calculateTextSizeWithText:_user_comment WithTextFont:14 WithMaxW:ScreenW - 20].height;
    
    CGFloat middle = contentH;
    
    //    //店家回复
    //    CGFloat comBackH = [DCSpeedy dc_calculateTextSizeWithText:_comReBack WithTextFont:13 WithMaxW:ScreenW - 40].height + DCMargin;
    CGFloat imagesH = middle;
    
    //图片数组
    if (self.goodsImageArray.count) {
        if (self.goodsImageArray.count > 5) return 0;
        //中间内容的Frame
        CGRect middleF = CGRectMake(DCMargin, top , ScreenW - 20, MiddleImageH);
        self.imagesFrames = middleF;
        
        imagesH = imagesH + MiddleImageH + DCMargin * 0.8;
    }
    _cellHeight = top + imagesH + 30;
    return _cellHeight;
}

@end
