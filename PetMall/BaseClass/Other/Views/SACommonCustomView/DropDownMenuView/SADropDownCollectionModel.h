//
//  SADropDownCollectionModel.h
//  SnailAuction
//
//  Created by 徐礼宝 on 2018/2/27.
//  Copyright © 2018年 GhGh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SADropDownCollectionModel : NSObject

@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) NSString *serveID;
@property (nonatomic,copy) NSString *serveKey;
@property (nonatomic,assign) BOOL isSelect;

@end
