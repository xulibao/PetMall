#import "STAPIBaseResponse.h"

@interface STAPIResponse : STAPIBaseResponse

@property (nonatomic, strong) id data;
@property (nonatomic, assign) NSInteger resCode;
@property (nonatomic, strong) NSString * resMsg;

@end

