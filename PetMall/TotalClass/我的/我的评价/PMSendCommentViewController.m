//
//  PMSendCommentViewController.m
//  PetMall
//
//  Created by 徐礼宝 on 2018/9/17.
//  Copyright © 2018年 ios@xulibao. All rights reserved.
//

#import "PMSendCommentViewController.h"
#import <ZYQAssetPickerController.h>
#import "WWStarView.h"
#import "SAButton.h"
#import "YYTextView.h"
@interface PMSendCommentViewController() <ZYQAssetPickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>
{
    UIView               *_editv;
    UIButton             *_addPic;
    NSMutableArray       *_imageArray;
    NSArray *arr;
    
    YYTextView *_textView;
}
@end






@implementation PMSendCommentViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发表评论";
    UIBarButtonItem * button = [self setupNavRightCSBarButtonWithAction:@selector(send)];
    [button setTitle:@"发表"];
//    UIButton *button =[[UIButton alloc]initWithFrame:CGRectMake(100, kMainBoundsWidth - 120, 100, 100)];
//    [button setTitle:@"发送" forState:UIControlStateNormal];
//    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    button.layer.borderWidth = 2;
//    button.backgroundColor = [UIColor redColor];
//    [button addTarget:self action:@selector(pushSec) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:button];
    
    WWStarView *vc=[[WWStarView alloc]initWithFrame:CGRectMake(0, 10, 200, 40) numberOfStars:5 currentStar:2.11 rateStyle:WholeStar isAnination:YES andamptyImageName:@"comment_star_no" fullImageName:@"comment_star" finish:^(CGFloat currentStar) {
  
    }];
    [self.view addSubview:vc];
    

    UIImageView * goodsImage = [UIImageView new];
    goodsImage.image = IMAGE(@"12312321");
    [self.view addSubview:goodsImage];
    
    UILabel * label= [UILabel new];
    label.text = @"物品评价";
    label.font = [UIFont boldSystemFontOfSize:14];
    [self.view addSubview:label];

    UILabel * statuslabel= [UILabel new];
    statuslabel.text = @"很好";
    statuslabel.font = [UIFont boldSystemFontOfSize:14];
    statuslabel.textColor = kColor999999;
    [self.view addSubview:statuslabel];
    
    [goodsImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(12);
    }];
    
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(goodsImage);
        make.left.mas_equalTo(goodsImage.mas_right).mas_offset(10);
    }];
    
    [vc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(goodsImage);
        make.size.mas_equalTo(CGSizeMake(160, 30));
        make.left.mas_equalTo(label.mas_right).mas_offset(20);
    }];
    
    [statuslabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(goodsImage);
        make.left.mas_equalTo(vc.mas_right).mas_offset(10);
    }];
    
    _textView = [[YYTextView alloc]initWithFrame:CGRectMake(12, 55, kMainBoundsWidth-24, 100)];
    _textView.placeholderText = @"说说你对商品的使用心得，分享给想买的TA们";
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_textView];
    
    
    _imageArray = [NSMutableArray array];
    _editv = [[UIView alloc] init];
    _editv.backgroundColor = [UIColor whiteColor];
    
    _addPic = [UIButton buttonWithType:UIButtonTypeCustom];
    [_addPic setImage:[UIImage imageNamed:@"mine_add_photo"] forState:UIControlStateNormal];
    
    _addPic.frame = CGRectMake(15, 10, 55, 55);
    [_addPic addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
//    _editv.frame = CGRectMake(15, 240, kMainBoundsWidth-15*2, CGRectGetMaxY(_addPic.frame)+20);
    [_editv addSubview:_addPic];
    
    [self.view addSubview:_editv];
    [_editv sp_addBottomLineWithLeftMargin:0 rightMargin:0];
    
    [_editv mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(12);
        make.right.mas_equalTo(-12);
        make.top.mas_equalTo(_textView.mas_bottom);
        make.height.mas_equalTo(70);

    }];
    
    SAButton * select = [SAButton new];
    [select setTitle:@"匿名" forState:UIControlStateNormal];
    select.spacingBetweenImageAndTitle = 5;
    [select setTitleColor:kColor333333 forState:UIControlStateNormal];
    select.titleLabel.font = [UIFont systemFontOfSize:12];
    [select addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
    [select setImage:IMAGE(@"comment_select_no") forState:UIControlStateNormal];
     [select setImage:IMAGE(@"comment_select") forState:UIControlStateSelected];
    [self.view addSubview:select];
    
    UILabel *label1 =  [UILabel new];
    label1.font = [UIFont boldSystemFontOfSize:10];
    label1.text = @"你写的评价会以匿名的形式展示";
    label1.textColor = kColor999999;
    [self.view addSubview:label1];
    [select mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_editv.mas_bottom).mas_offset(10);
        make.left.mas_equalTo(12);
    }];
    
    [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.centerY.mas_equalTo(select);
    }];

}
- (void)select:(SAButton * )btn{
    btn.selected = !btn.selected;
}
-(void)pushSec{
    
}
-(void)click{
    
    ZYQAssetPickerController *pickerController = [[ZYQAssetPickerController alloc] init];
    pickerController.maximumNumberOfSelection = 8;
    //    pickerController.nowCount = _imageArray.count;
    pickerController.assetsFilter = ZYQAssetsFilterAllAssets;
    pickerController.showEmptyGroups=NO;
    pickerController.delegate=self;
    pickerController.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        if ([(ZYQAsset*)evaluatedObject mediaType]==ZYQAssetMediaTypeVideo) {
            NSTimeInterval duration = [(ZYQAsset*)evaluatedObject duration];
            return duration >= 5;
        } else {
            return YES;
        }
    }];
    
    
    [self presentViewController:pickerController animated:YES completion:nil];
}
- (void)assetPickerController:(ZYQAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^
                   {
                       for (int i=0; i<assets.count; i++)
                       {
                           
                           ZYQAsset *asset = assets[i];
                           
                           [asset setGetFullScreenImage:^(UIImage *result){
                               
                               if (result == nil) {
                                   NSLog(@"空空以控控");
                               }
                               if(_imageArray.count >8){
                                   NSLog(@"超了");
                               }else{
                                   [_imageArray addObject:result];
                                   dispatch_async(dispatch_get_main_queue(), ^{
                                       [self nineGrid];
                                   });
                               }
                               
                               NSLog(@"---%ld",_imageArray.count);
                               
                               
                           }];
                           
                       }
                       NSLog(@"现在剩余是多少%ld",_imageArray.count);
                   });
}
// 删除照片
- (void)deleteEvent:(UIButton *)sender
{
    UIButton *btn = (UIButton *)sender;
    [_imageArray removeObjectAtIndex:btn.tag-10];
    
    [self nineGrid];
    
    if (_imageArray.count == 0)
    {
        _addPic.frame = CGRectMake(15, 10, 70, 70);
        _editv.frame = CGRectMake(15, 240, kMainBoundsWidth-15*2, CGRectGetMaxY(_addPic.frame)+20);
    }
}
// 9宫格图片布局
- (void)nineGrid
{
    NSLog(@"九宫格%ld",_imageArray.count);
    for (UIImageView *imgv in _editv.subviews)
    {
        if ([imgv isKindOfClass:[UIImageView class]]) {
            [imgv removeFromSuperview];
        }
    }
    
    CGFloat width = 70;
    CGFloat widthSpace = (kMainBoundsWidth - 15*4 - 70*4) / 3.0;
    CGFloat heightSpace = 10;
    
    NSInteger count = _imageArray.count;
    _imageArray.count > 9 ? (count = 9) : (count = _imageArray.count);
    
    for (int i=0; i<count; i++)
    {
        UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(15+(width+widthSpace)*(i%4), (i/4)*(width+heightSpace) + 10, width, width)];
        imgv.image = _imageArray[i];
        imgv.userInteractionEnabled = YES;
        [_editv addSubview:imgv];
        
        UIButton *delete = [UIButton buttonWithType:UIButtonTypeCustom];
        delete.frame = CGRectMake(width-16, -5, 16, 16);
        //        delete.backgroundColor = [UIColor greenColor];
        [delete setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
        [delete addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
        delete.tag = 10+i;
        [imgv addSubview:delete];
        
        if (i == _imageArray.count - 1)
        {
            if (_imageArray.count % 4 == 0) {
                _addPic.frame = CGRectMake(15, CGRectGetMaxY(imgv.frame) + heightSpace, 70, 70);
            } else {
                _addPic.frame = CGRectMake(CGRectGetMaxX(imgv.frame) + widthSpace, CGRectGetMinY(imgv.frame), 70, 70);
            }
            
            [_editv mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(12);
                make.right.mas_equalTo(-12);
                make.top.mas_equalTo(_textView.mas_bottom);
                make.height.mas_equalTo(CGRectGetMaxY(_addPic.frame)+20);
                
            }];
            
//            _editv.frame = CGRectMake(15, 155, kMainBoundsWidth-15*2, );
        }
    }
}

-(UIImage*) OriginImage:(UIImage *)image scaleToSize:(CGSize)size
{
    UIGraphicsBeginImageContext(size);  //size 为CGSize类型，即你所需要的图片尺寸
    
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return scaledImage;   //返回的就是已经改变的图片
}

- (void)send{
    [self showSuccess:@"发表成功！"];
    [self.navigationController popViewControllerAnimated:YES];
}

@end
