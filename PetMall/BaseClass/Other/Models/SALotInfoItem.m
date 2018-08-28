//
//  SALotInfoItem.m
//  SnailAuction
//
//  Created by imeng on 2018/2/12.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import "SALotInfoItem.h"
#import "SAPriceUpdateEpisode.h"

//#import "SALotViewController.h"//拍品
//#import "SALotPackageViewController.h"//拍品组
#import "SACommonInfoCell.h"
#import "SACountdownEpisode.h"

#ifdef DEBUG
//#define DEBUGCOUNTDOWN
#endif

static NSDictionary * kDefaultAttributes0 = nil;
static NSDictionary * kDefaultAttributes1 = nil;

@interface SALotInfoItem ()

@property(nonatomic, strong) NSArray *tagsText;

@end

@implementation SALotInfoItem
@synthesize cellClass = _cellClass;

+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        kDefaultAttributes0 = @{NSFontAttributeName:UIFontMake(13),
                               NSForegroundColorAttributeName:kColorFF5554};
        kDefaultAttributes1 = @{NSFontAttributeName:UIFontMake(13),
                                      NSForegroundColorAttributeName:kColorTextGay};

    });
}

#pragma mark - Override

- (Class)cellClass {
    if (!_cellClass) {
        _cellClass = [SACommonInfoCell class];
    }
    return _cellClass;
}

- (UIViewController *)createDetailViewController {
    id vc = nil;
    if (self.truckNum > 1) {
//        SALotPackageViewController *aVC = [[SALotPackageViewController alloc] init];
//        aVC.ID = self.lotId;
//        aVC.truckID = self.truckId;
//        vc = aVC;
    } else {
//        SALotViewController *aVC = [[SALotViewController alloc] init];
//        aVC.lotID = self.lotId;
//        aVC.truckID = self.truckId;
//        vc = aVC;
    }
    return vc;
}

#pragma mark - SACountdownEpisodeDelegate

//- (void)episodeExpiredEvent:(SACountdownEpisode *)episode {
//    if (SAAuctionStatusNotBegin == self.status && SAAuctionStatusInProgress != self.status && 0 != self.status) {
//        self.status = SAAuctionStatusInProgress;
//    } else {
//        [super episodeExpiredEvent:episode];
//    }
//}

#pragma mark - Setter

//- (void)setCountDown:(long long)countDown {
//#ifdef DEBUGCOUNTDOWN
//    _countDown = (arc4random_uniform(30)) * 1000;
//    NSLog(@"countDown:%zd",_countDown);
//#else
//    _countDown = countDown;
//#endif
//}

- (void)setStartCountDown:(long long)startCountDown {
#ifdef DEBUGCOUNTDOWN
//    _startCountDown = (arc4random_uniform(30)) * 1000;
    _startCountDown = (10) * 1000;
    NSLog(@"countDown:%zd",_startCountDown);
#else
    _startCountDown = startCountDown;
#endif
}

- (void)setStatus:(SAAuctionStatus)status {
#ifdef DEBUGCOUNTDOWN
    //    _endCountDown = (arc4random_uniform(30)) * 1000;
    NSLog(@"countDown:%zd",_endCountDown);
    if (SAAuctionStatusNotBegin == self.status) {
        _endCountDown = (100) * 1000;
    } else {
        _endCountDown = (65) * 1000;
    }
#endif
    if (SAAuctionStatusInProgress == status && SAAuctionStatusNotBegin == _status) {
//        [[SAApplication sharedApplication] addPriceUpdateDelegate:self];
    }

    _status = status;
    
    switch (_status) {
        case SAAuctionStatusNotBegin:
            self.countdownEpisode.countDown = self.startCountDown;
            break;
        case SAAuctionStatusInProgress:
            self.countdownEpisode.countDown = self.endCountDown;
            break;
        default:
            break;
    }
}

- (void)setEndCountDown:(long long)endCountDown {
    _endCountDown = endCountDown;
}

#pragma mark - Getter

- (long long)countDown {
    if (SAAuctionStatusNotBegin == self.status) {
        return self.startCountDown;
    }
    return self.endCountDown;
}

- (NSAttributedString *)uiEndTime {
    return [NSAttributedString timeTextWithString:self.endTime fontSize:13 needHour:NO];
}

#pragma mark - SAPriceUpdateDelegate

- (NSString *)priceInfoUpdateIdentifier {
//    if (self.truckNum > 1) {
//        return @"5a9fd3fc128fe100680b41a5";
//    } else {
//        return @"5a9fd3a00b6160004408200b";
//    }
//    return @"5aa4d3875b90c830ff7cc4ce";
    if (self.convId && self.convId.length > 0 && ![self.convId isEqualToString:@"0"]) {
        return self.convId;
    }
    return nil;
}

- (void)updatePriceInfo:(SALotPriceInfoEntity *)price {
//    self.maxPrice = price.maxPrice;
//    self.finalPrice = price.finalPrice;
    [self callDelegateUpdateInfo];
}

#pragma mark - SACommonListInfoItem

- (NSURL *)imageURL {
    return [NSURL URLWithString:self.showImgUrl];
}

//  标题 （北京 中国重汽 HOKA ）牵引车 590 匹 6X4
- (NSAttributedString *)label0Text {
    return [self.title attributedStingWithAttributes:nil];
}

//  地址和日期 （北京 2019年7月）
- (NSAttributedString *)label1Text {
    NSMutableString *text = [NSMutableString string];\
    if (self.registAddress) {
        [text appendString:self.registAddress];
    }
    
    if (text.length > 0) {[text appendString:@" "];}

    if (self.registDate) {
        [text appendString:self.registDate];
    }
    return [text attributedStingWithAttributes:nil];
}

//  当前最高价：29万 当前最高出价：25.9万
- (NSAttributedString *)label2Text {
    
    NSAttributedString *text = nil;
    NSDictionary *attributes0 = SADefaultNormalAttributes(13);
    NSDictionary *attributes1 = SADefaultHighlightedAttributes(18);
    
    if (self.finalPrice && self.status > SAAuctionStatusInProgress) {
        NSAttributedString *text = nil;
        NSString *price = [self.finalPrice stringByAppendingString:@"万"];
        text = [NSAttributedString stringWithStrings:@[[@"合手价：" attributedStingWithAttributes:attributes0],
                                                       [price  attributedStingWithAttributes:attributes1]]];
        return text;
    }
    
    if (!self.maxPrice) return nil;
    switch (self.status) {
        case SAAuctionStatusNotBegin: {
            NSString *price = [self.maxPrice stringByAppendingString:@"万"];
            text = [NSAttributedString stringWithStrings:@[[@"起拍价：" attributedStingWithAttributes:attributes0],
                                                           [price  attributedStingWithAttributes:attributes1]]];
        }
            break;
        case SAAuctionStatusInProgress: {
            NSString *price = [self.maxPrice stringByAppendingString:@"万"];

                text = [NSAttributedString stringWithStrings:@[[@"当前最高出价：" attributedStingWithAttributes:attributes0],
                                                               [price  attributedStingWithAttributes:attributes1]]];

        }
            break;
        default:
            break;
    }
    return text;
}

//  国三
- (NSAttributedString *)label3Text {
    return [self.emission attributedStingWithAttributes:nil];
}

//  已下架
- (NSAttributedString *)label4Text {
    if (!(UI_SCREEN_WIDTH > 320)) {
        switch (self.status) {
            case SAAuctionStatusNotBegin: {
                return [@"即将开始" attributedStingWithAttributes:nil];
            }
                break;
            case SAAuctionStatusInProgress:
                return [@"竞拍中" attributedStingWithAttributes:nil];
                break;
            default:
                return [self.statusText attributedStingWithAttributes:nil];
                break;
        }
    }
    return nil;
}

//时间
- (NSAttributedString *)countDownLabelText {
    NSAttributedString *text = nil;
    CGFloat fontSize = 13;
    if (self.endTime && self.status > SAAuctionStatusInProgress) {
        text = [NSAttributedString stringWithStrings:@[[@"结束时间:" attributedStingWithAttributes:kDefaultAttributes1],
                                                       [self uiEndTime]]];
    }
    
    switch (self.status) {
        case SAAuctionStatusNotBegin: {
            long long seconds = self.countdownEpisode.countDownSecond;
            text = [NSAttributedString stringWithStrings:@[[@"距开始:" attributedStingWithAttributes:kDefaultAttributes1],
                                                           [NSAttributedString countDownTextWithSecond:seconds fontSize:fontSize]]];
//            text = [NSAttributedString stringWithStrings:@[[@"开始时间:" attributedStingWithAttributes:kDefaultAttributes1],
//                                                           [NSAttributedString timeTextWithString:self.startTime fontSize:fontSize needHour:NO]]];

        }
            break;
        case SAAuctionStatusInProgress: {
            long long seconds = self.countdownEpisode.countDownSecond;
            text = [NSAttributedString stringWithStrings:@[[@"距结束:" attributedStingWithAttributes:kDefaultAttributes1],
                                                           [NSAttributedString countDownTextWithSecond:seconds fontSize:fontSize]]];
            
        }
            break;
        default:
            break;
    }
    return text;
}

//标签
- (NSArray<NSAttributedString*> *)tagsText {
//    if (_tagsText ) {return _tagsText;}
    NSMutableArray *aTags = [NSMutableArray array];
    if (self.truckNum>1) {
        NSString *string = [NSString stringWithFormat:@"%lld辆", self.truckNum];
        [aTags addObject:[string attributedStingWithAttributes:kDefaultAttributes0]];
    }
    if (self.checkGrade.length > 0) {
        [aTags addObject:[self.checkGrade attributedStingWithAttributes:kDefaultAttributes0]];
    }
    if (UI_SCREEN_WIDTH > 320) {
        switch (self.status) {
            case SAAuctionStatusNotBegin: {
                NSDictionary *attributes1 = @{NSFontAttributeName:UIFontMake(13),
                                              NSForegroundColorAttributeName:UIColorFromRGB(0x88B397)};
                [aTags addObject:[@"即将开始" attributedStingWithAttributes:attributes1]];
            }
                break;
            case SAAuctionStatusInProgress:
                [aTags addObject:[@"竞拍中" attributedStingWithAttributes:kDefaultAttributes0]];
                break;
                
            default: {
            }
                break;
        }
    }
    _tagsText = aTags;
    return aTags;
}

- (BOOL)shouldDisplayCountDown {
    return self.status <= SAAuctionStatusInProgress;
}

@end
