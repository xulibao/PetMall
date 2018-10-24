#import "STAPIBaseResponse.h"

@interface STAPIResponse : STAPIBaseResponse

@property (nonatomic, strong) id data;
@property (nonatomic, assign) NSInteger resCode;
@property (nonatomic, strong) NSString * resMsg;
@property (nonatomic, strong) id result;
@property (nonatomic, assign) NSInteger status;
@property (nonatomic, strong) NSString * msg;
@end

