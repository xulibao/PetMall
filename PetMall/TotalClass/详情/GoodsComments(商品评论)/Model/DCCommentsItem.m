//
//  DCCommentsItem.m
//  CDDStoreDemo
//
//  Created by 陈甸甸 on 2018/2/23.
//  Copyright © 2018年 RocketsChen. All rights reserved.
//
/** 回复帖子宽高 */
#define MiddleImageH (ScreenW - 50)/4
#define MiddleImageW  MiddleImageH



#import "DCCommentsItem.h"

@implementation DCCommentsItem

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
    if (self.imgsArray.count) {
        if (self.imgsArray.count > 5) return 0;
        //中间内容的Frame
        CGRect middleF = CGRectMake(DCMargin, top , ScreenW - 20, MiddleImageH);
        self.imagesFrames = middleF;
        
        imagesH = imagesH + MiddleImageH + DCMargin * 0.8;
    }
    _cellHeight = top + imagesH + 30;
    return _cellHeight;
}

- (NSMutableArray *)imgsArray{
    if (_imgsArray == nil) {
        
        NSArray *picArray;
        picArray = [self.user_images componentsSeparatedBySthString:@"|"];
        _imgsArray = [@[] mutableCopy];
        for (NSString * imageStr in picArray) {
            if (![imageStr hasPrefix:[STNetworking host]]) {
                [_imgsArray addObject:[NSString stringWithFormat:@"%@/%@",[STNetworking host],imageStr]];
            }
        }
    }
    return _imgsArray;
}
@end
