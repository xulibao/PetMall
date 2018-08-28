//
//  STUrlPathMacro.h
//  SnailTruck
//
//  Created by 木鱼 on 15/11/9.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#ifndef STUrlPathMacro_h
#define STUrlPathMacro_h

//竞拍规则
static NSString * const API_jingpaiguize =  @"http://pc3rpca5i.bkt.clouddn.com/html/auction_rule_1531993476.html";
//商户必读
static NSString * const API_shanghubidu =  @"http://pc3rpca5i.bkt.clouddn.com/html/user_instruction_1531993476.html";
//商户协议
static NSString * const API_shanghuxieyi =  @"http://pc3rpca5i.bkt.clouddn.com/html/user_protocol_1531993476.html";

//保证金规则
static NSString * const URL_baozhengjinguize =  @"http://www.woniuhuoche.com/activity/auctionActivity/auctionRule/auctionRule.html";


//更新
static NSString * const API_version_lastVersion = @"api/version/v1/lastVersion";

/**************蜗牛货车接口**************/
// 我的详情
static NSString * const STAPI_myDetails_Page = @"api/v2/truck/myDetails";
//已售接口
static NSString * const STAPI_truck_sale = @"api/v1/truck/sale";
/**************竞拍相关**************/

/**************竞拍相关**************/
//拍品列表
static NSString * const API_auction_lotList = @"api/auction/v1/lotList";
//竞拍场次列表
static NSString * const API_auction_list =  @"api/auction/v1/list";
//打包拍品详情
static NSString * const API_auction_lotDetail = @"api/auction/v1/lotDetail";
//出价
static NSString * const API_auction_bid = @"api/auction/v1/bid";
//车辆详情或拍品详情
static NSString * const API_auction_detail = @"api/auction/v1/truckDetail";
//添加关注拍品
static NSString * const API_auction_addAttention = @"api/auction/v1/addAttention";
/**************我的**************/
//我的钱包
static NSString * const API_bond_getBond = @"api/bond/getBond";

//我的订单
static NSString * const API_receiptOrder_orderList = @"api/receiptOrder/orderList";
//申请视频列表
static NSString * const API_mine_myApply =  @"api/video/v1/myApply";
//最后付款时间已过，修改状态
static NSString * const API_mine_payLate =  @"api/video/v1/payLate";
//我的出价
static NSString * const API_mine_bidList = @"api/bid/bidList";
//我的出价详情
static NSString * const API_mine_bidDetail = @"api/bid/biddetail";
//我的订单
static NSString * const API_mine_orderList = @"api/receiptOrder/orderList";
//订单详情
static NSString * const API_mine_orderDetail = @"api/receiptOrder/receiptDetail";
//我的关注
static NSString * const API_mine_myAttention = @"api/auction/v1/myAttention";
//我的车辆-同步蜗牛的车辆
static NSString * const API_userOwnTruck_userSysTrucks = @"api/userOwnTruck/userSysTrucks";
//我的出价
static NSString * const API_userOwnTruck_userAuctionTruck = @"api/userOwnTruck/userAuctionTruck";
//我的交易记录
static NSString * const API_bond_getBondLog = @"api/bond/getBondLog";
//我的充值记录
static NSString * const API_recharge_getRechargeRecord = @"api/recharge/getRechargeRecord";
//我的提现记录
static NSString * const API_withdrawCash_getWithdrawCash = @"api/withdrawCash/getWithdrawCash";

//我的优惠券
static NSString * const API_activity_myCouponList = @"api/activity/myCouponList";

//我的优惠券详情
static NSString * const API_activity_couponDetail = @"api/activity/couponDetail";

/**************用户消息**************/
//用户消息列表
static NSString * const API_message_list =  @"api/message/v1/list";
//删除消息
static NSString * const API_message_deleteMsg =  @"api/message/v1/deleteMsg";
//用户消息详情
static NSString * const API_message_details =  @"api/message/v1/details";

/**************用户信息**************/
//设置接口
static NSString * const API_set_setInfo =  @"api/set/setInfo";
//个人中心-待确认订单数量
static NSString * const API_user_personalCenter =  @"api/user/personalCenter";
//城市--查询所有省市区
static NSString * const API_city_getAll =  @"api/city/getAll";
//修改经营地址
static NSString * const API_user_updateBusinessArress =  @"api/user/updateBusinessArress";
//修改联系人
static NSString * const API_user_updateContactName =  @"api/user/updateContactName";

//修改车商名称
static NSString * const API_user_updateCarDealer =  @"api/user/updateCarDealer";
//首页
static NSString * const API_user_homePage = @"api/user/v1/homePage";

//获取竞拍时间
static NSString * const API_auction_getEndTime = @"api/auction/v1/getEndTime";
//删除银行卡
static NSString * const API_bankCard_deleteBankCard =  @"api/bankCard/deleteBankCard";
//新增银行卡
static NSString * const API_bankCard_addBankCard =  @"api/bankCard/addBankCard";
//银行卡列表
static NSString * const API_bankCard_bankCardList =  @"api/bankCard/bankCardList";
//银行列表
static NSString * const API_bankCard_bankList =  @"api/bankCard/bankList";
//意见反馈
static NSString * const API_feedback_addFeedback =  @"api/feedback/addFeedback";
//更换手机号--新号发短信
static NSString * const API_set_sendNewCode=  @"api/set/sendNewCode";
//更换手机号--新号码验证
static NSString * const API_set_checkNewCode=  @"api/set/checkNewCode";
//更换手机号--旧号发短息
static NSString * const API_set_sendOldCode =  @"api/set/sendOldCode";
//更换手机号--旧号码验证
static NSString * const API_set_checkOldCode =  @"api/set/checkOldCode";
//注册
static NSString * const API_user_regist =  @"api/user/regist";
//注册时发送验证码
static NSString * const API_user_sendRegistCode =  @"api/user/sendRegistCode";
//登录
static NSString * const API_user_login =  @"api/user/login";
//蜗牛账号登录
static NSString * const API_user_loginByWoniu =  @"api/user/loginByWoniu";
//登录时发送验证码
static NSString * const API_user_sendLoginCode =  @"api/user/sendLoginCode";
//申请--个人申请提交接口
static NSString * const API_user_personApply =  @"api/user/personApply";
//申请--商家申请提交接口
static NSString * const API_user_businessApply =  @"api/user/BusinessApply";
//申请--审核不通过
static NSString * const API_user_auditRefused =  @"api/user/auditRefused";
//申请--修改资质信息（回显）
static NSString * const API_user_updateApply =  @"api/user/updateApply";

//看车申请
static NSString * const API_video_apply =  @"api/video/v1/apply";

//支付看车申请
static NSString * const API_video_payOrder =  @"api/video/v1/payOrder";

//七牛获取token
static NSString * const API_auction_token =  @"api/auction/token";
#endif /* STUrlPathMacro_h */

/**************支付**************/
//充值-获得回调地址、订单编号（通联、支付宝）
static NSString * const API_recharge_getRechargeAndCallback =  @"api/recharge/getRechargeAndCallback";

//充值-微信下单（回调地址、订单编号)
static NSString * const API_recharge_wxPayUnifiedOrder =  @"api/recharge/wxPayUnifiedOrder";

//提现接口
static NSString * const API_withdrawCash_toWithdrawCash =  @"api/withdrawCash/toWithdrawCash";

//上架
static NSString * const API_userOwnTruck_putAway =  @"api/userOwnTruck/putAway";


/**************字典数据**************/
//获取品牌
static NSString * const API_dictionaries_getAllBrand =  @"api/dictionaries/v1/getAllBrand";
//获取车型
static NSString * const API_dictionaries_getAllModel =  @"api/dictionaries/v1/getAllModel";

