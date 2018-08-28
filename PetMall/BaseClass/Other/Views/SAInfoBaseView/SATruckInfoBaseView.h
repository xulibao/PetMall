//
//  SATruckInfoBaseView.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/5.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SATruckInfoBaseView : UIView

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *label0;//  标题 （北京 中国重汽 HOKA ）牵引车 590 匹 6X4
@property (nonatomic,strong) UILabel *label1;//  地址和日期 （北京 2019年7月）
@property (nonatomic,strong) UILabel *label2;//  当前最高价：29万
@property (nonatomic,strong) UILabel *label3;//  国三
@property (nonatomic,strong) UILabel *label4;//  已下架
@property (nonatomic,copy)   NSString *imageURLStr;
@property (nonatomic,strong) NSAttributedString *attStr_label0;
@property (nonatomic,strong) NSAttributedString *attStr_label1;
@property (nonatomic,strong) NSAttributedString *attStr_label2;

@end
