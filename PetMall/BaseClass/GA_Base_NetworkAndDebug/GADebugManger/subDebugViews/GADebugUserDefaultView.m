//
//  GADebugUserDefaultView.m
//  GADebugManger
//
//  Created by 王光辉 on 15/11/7.
//  Copyright © 2015年 WGH. All rights reserved.
//
// UserDefault
#import "GADebugUserDefaultView.h"
#import "NSString+JSON.h"
//#import "GA_Log_Anything.h"
@interface GADebugUserDefaultView()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *crashes;
@property (nonatomic,strong) UITableView *udTableView;
@property (nonatomic,strong) UITextView *detailTextView;
@property (nonatomic, copy) NSString *PreferenceStr;
@end
@implementation GADebugUserDefaultView

- (id) initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        // UD列表
        self.udTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.contentView.frame.size.width, self.contentView.frame.size.height - 50) style:UITableViewStylePlain];
        self.udTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.udTableView.delegate = self;
        self.udTableView.dataSource = self;
        self.udTableView.rowHeight = 100;
        self.udTableView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:self.udTableView];
        
        // crash详情页
        // 详情页
        self.detailTextView = [[UITextView alloc] initWithFrame:self.contentView.bounds];
        self.detailTextView.editable = NO;
        self.detailTextView.textColor = [UIColor whiteColor];
        self.detailTextView.backgroundColor = [UIColor clearColor];
        self.detailTextView.font = [UIFont systemFontOfSize:14.0];
        self.detailTextView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
        [self.contentView addSubview:self.detailTextView];
        self.detailTextView.hidden = YES;
        
        //清除按钮
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.udTableView.frame.size.width, 40)];
        
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = headerView.bounds;
        clearBtn.titleLabel.font = [UIFont boldSystemFontOfSize:14.0];
        [clearBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [clearBtn setTitle:@"点击查看偏好设置,没有对NSData解析" forState:UIControlStateNormal];
        [clearBtn addTarget:self action:@selector(clearBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:clearBtn];
        self.udTableView.tableHeaderView = headerView;
        [self.udTableView reloadData];
    }
    return self;
}

#pragma mark -
#pragma mark UITableViewDataSource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellIdentifier = @"RequestCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
        cell.textLabel.textColor = [UIColor whiteColor];
        cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
        cell.backgroundColor = [UIColor clearColor];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.backgroundView = [[UIView alloc] init];
        cell.textLabel.numberOfLines = 0;
        [cell.textLabel adjustsFontSizeToFitWidth];
        cell.textLabel.lineBreakMode = NSLineBreakByCharWrapping;
        cell.selectedBackgroundView = [[UIView alloc] init];
        
        cell.detailTextLabel.textColor = [UIColor redColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.0f];
    }
    cell.textLabel.text = [self documentsPreferences];
    return cell;
}

- (NSString *)documentsPreferences{
    if (_PreferenceStr == nil) {
    NSArray *paths1 = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
    NSMutableString *strM = [NSMutableString stringWithString:[paths1 firstObject]];
    [strM appendString:@"/Preferences"];
    NSString *identifier = [[NSBundle mainBundle] bundleIdentifier];
    [strM appendString:[NSString stringWithFormat:@"/%@.plist",identifier]];
        _PreferenceStr = [strM copy];
    }
    return _PreferenceStr;
}


#pragma mark -
#pragma mark UITableViewDelegate
- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableString *text = [NSMutableString stringWithFormat:@""];
    [text appendFormat:@"偏好设置所有内容如下：\n\n\n"];
    NSDictionary *DICT = [NSDictionary dictionaryWithContentsOfFile:[self documentsPreferences]];

    [text appendFormat:@"\n%@\n",[NSString jsonStringWithDictionary:DICT]];
// 以下通过字符串替换,不起作用
    __block NSMutableString *textM = [NSMutableString stringWithFormat:@""];
    
    NSArray *arrayT = [text componentsSeparatedByString:@"{"];
    [arrayT enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * stop) {
        [textM appendString:[NSString stringWithFormat:@"%@\n{\n",str]];
    }];
    
    __block NSMutableString *textM1 = [NSMutableString stringWithFormat:@""];
    NSArray *arrayT1 = [textM componentsSeparatedByString:@"}"];
    [arrayT1 enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * stop) {
        [textM1 appendString:[NSString stringWithFormat:@"%@\n}",str]];
    }];
    
    __block NSMutableString *textM2 = [NSMutableString stringWithFormat:@""];
    NSArray *arrayT2 = [textM1 componentsSeparatedByString:@","];
    [arrayT2 enumerateObjectsUsingBlock:^(NSString *str, NSUInteger idx, BOOL * stop) {
        [textM2 appendString:[NSString stringWithFormat:@"%@,\n",str]];
    }];
    
//    [textM stringByReplacingOccurrencesOfString:@"}" withString:@"\n}"];
//    [textM stringByReplacingOccurrencesOfString:@"," withString:@"\n,"];
//    NSRange ran = [textM rangeOfString:@"}"];
//    [textM insertString:@"\n\n\n\n\n" atIndex:ran.location];
    
    self.detailTextView.text = textM2;
    CGContextRef context = UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.contentView cache:YES];
    
    self.detailTextView.hidden = NO;
    self.udTableView.hidden = YES;
    
    [UIView commitAnimations];
}
- (void)clearBtnClick:(id)sender{
    
}

- (void) closeBtnClick:(id)sender{
    if (self.detailTextView.hidden == NO) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        [UIView beginAnimations:nil context:context];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromRight forView:self.contentView cache:YES];
        
        self.detailTextView.hidden = YES;
        self.udTableView.hidden = NO;
        
        [UIView commitAnimations];
    }else{
        self.udTableView = nil;
        self.detailTextView = nil;
        self.crashes = nil;
        [super closeBtnClick:sender];
    }
}
#pragma mark - 以下是转Json
//- (NSString *)DataTOjsonString:(NSDictionary *)dic
//{
////    NSData *jsonData = [dic dataUsingEncoding:NSUTF8StringEncoding];
//    
//}
//- (NSString *)DataTOjsonString2:(id)object
//{
//    if (object == nil) {
//        return @"";
//    }
//    NSString *jsonString = nil;
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:object
//    options:NSJSONWritingPrettyPrinted                                                          error:&error];
//    if (! jsonData) {
//        NSLog(@"Got an error: %@", error);
//    } else {
//        jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//    }
//    return jsonString;
//}
//- (NSString *)jsonStringWithDictionary:(NSDictionary *)dictionary{
//    NSArray *keys = [dictionary allKeys];
//    NSMutableString *reString = [NSMutableString string];
//    [reString appendString:@"{"];
//    NSMutableArray *keyValues = [NSMutableArray array];
//    for (int i=0; i<[keys count]; i++) {
//        NSString *name = [keys objectAtIndex:i];
//        id valueObj = [dictionary objectForKey:name];
//        NSString *value = [self jsonStringWithObject:valueObj];
//        if (value) {
//            [keyValues addObject:[NSString stringWithFormat:@"%@:%@",name,value]];
//        }
//    }
//    [reString appendFormat:@"%@",[keyValues componentsJoinedByString:@","];
//    [reString appendString:@"}"];
//    return reString;
//}
//-(NSString *)jsonStringWithObject:(id) object{
//     NSString *value = nil;
//     if (!object) {
//         return value;
//     }
//     if ([object isKindOfClass:[NSString class]]) {
//         value = [self jsonStringWithString:object];
//     }else if([object isKindOfClass:[NSDictionary class]]){
//         value = [NSString jsonStringWithDictionary:object];
//     }else if([object isKindOfClass:[NSArray class]]){
//         value = [NSString jsonStringWithArray:object];
//     }
//     return value;
//}
//+(NSString *)jsonStringWithString:(NSString *) string{
//   return [NSString stringWithFormat:@"%@",
//             [[string stringByReplacingOccurrencesOfString:@"\n" withString:@"\\n"] stringByReplacingOccurrencesOfString:@"withString:"]
//             ];
//}
//     
//     
//- (NSString *)jsonStringWithArray:(NSArray *)array{
//     NSMutableString *reString = [NSMutableString string];
//     [reString appendString:@"["];
//     NSMutableArray *values = [NSMutableArray array];
//     for (id valueObj in array) {
//         NSString *value = [self jsonStringWithObject:valueObj];
//         if (value) {
//             [values addObject:[NSString stringWithFormat:@"%@",value]];
//         }
//     }
//     [reString appendFormat:@"%@",[values componentsJoinedByString:@","]];
//     [reString appendString:@"]"];
//     return reString;
//}
//     
     


@end
