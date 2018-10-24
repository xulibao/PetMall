//
//  STUrlPathMacro.h
//  SnailTruck
//
//  Created by 木鱼 on 15/11/9.
//  Copyright © 2015年 GhGh. All rights reserved.
//

#ifndef STUrlPathMacro_h
#define STUrlPathMacro_h
#import "STNetworking.h"

/**************************用户信息****************************/
//注册
static NSString * const API_user_regist = @"pet/index.php/index/user/register";
//注册时发送验证码
static NSString * const API_user_sendRegistCode =  @"pet/index.php/index/user/verification";
//登录
static NSString * const API_user_login =  @"pet/index.php/index/user/login";
//登录时发送验证码
static NSString * const API_user_sendLoginCode =  @"api/user/sendLoginCode";
//绑定宠物种类
static NSString * const API_user_choice =  @"pet/index.php/index/user/choice";
//注册
static NSString * const API_user_register =  @"pet/index.php/index/user/register";
//修改密码
static NSString * const API_user_changepassword =  @"pet/index.php/index/user/changepassword";

/**************************分类****************************/
//左侧分类列表
static NSString * const API_Classification_fication =  @"pet/index.php/index/Classification/fication";
//右侧分类列表
static NSString * const API_Classification_ficationa =  @"pet/index.php/index/Classification/ficationa";
//关键词搜索
static NSString * const API_Classification_search =  @"pet/index.php/index/Classification/search";
//条件排序
static NSString * const API_Classification_sort =  @"pet/index.php/index/Classification/sort";
//立即购买
//立即参团
//立即兑换
static NSString * const API_Classification_purchase =  @"pet/index.php/index/Classification/purchase";

/**************************分类****************************/

//首页信息
static NSString * const API_Goods_broadcast =  @"pet/index.php/index/Goods/broadcast";
//首页优惠券立即领取
static NSString * const API_Classification_receive =  @"pet/index.php/index/Goods/ receive";
//首页狗粮零食玩具出行医疗保健
static NSString * const API_Dogfood_specifications =  @"pet/index.php/index/Dogfood/specifications";
//条件查询后商品
static NSString * const API_Dogfood_condition =  @"pet/index.php/index/Dogfood/condition";
//限时秒杀
//潮品预售
//团购活动
//特价清仓
static NSString * const API_Dogfood_presale =  @"pet/index.php/index/Dogfood/presale";
//限时秒杀时段商品查询
static NSString * const API_Dogfood_interval =  @"pet/index.php/index/Dogfood/interval";
//加入购物车
static NSString * const API_Dogfood_cart =  @"pet/index.php/index/Dogfood/cart";
//商品详情
static NSString * const API_Dogfood_details =  @"pet/index.php/index/Dogfood/details";
//商品收藏
static NSString * const API_Dogfood_collection =  @"pet/index.php/index/Dogfood/collection";
//商品评价
static NSString * const API_Dogfood_evaluation =  @"pet/index.php/index/Dogfood/evaluation";
//商品删除
static NSString * const API_Dogfood_deletion =  @"pet/index.php/index/Dogfood/deletion";
//购物车列表
static NSString * const API_Dogfood_cartlist =  @"pet/index.php/index/Dogfood/cartlist";
//确认订单
static NSString * const API_Dogfood_confirmation =  @"pet/index.php/index/Dogfood/confirmation";
//提交订单
static NSString * const API_Dogfood_placeorder =  @"pet/index.php/index/Dogfood/placeorder";
//团购活动
static NSString * const API_Dogfood_grouppurchase =  @"pet/index.php/index/Dogfood/grouppurchase";
//我的团购
static NSString * const API_Dogfood_goupbuy =  @"pet/index.php/index/Dogfood/goupbuy";

/**************************我的/个人中心****************************/

//添加收货地址
static NSString * const API_user_address =  @"pet/index.php/index/user/address";

//我的地址
static NSString * const API_user_useraddress =  @"pet/index.php/index/user/useraddress";

//修改地址
static NSString * const API_user_addressdel =  @"pet/index.php/index/user/addressdel";

//优惠券信息
static NSString * const API_user_coupon =  @"pet/index.php/index/user/coupon";

//帮助/问题
static NSString * const API_user_help =  @"pet/index.php/index/user/help";

//帮助/问题详情
static NSString * const API_user_helpxq =  @"pet/index.php/index/user/helpxq";

//联系我们
static NSString * const API_user_contactus =  @"pet/index.php/index/user/contactus";

//联系我们提交
static NSString * const API_user_submission =  @"pet/index.php/index/user/submission";

//我的收藏
static NSString * const API_user_collection =  @"pet/index.php/index/user/collection";

//我的收藏删除
static NSString * const API_user_collectiondel =  @"pet/index.php/index/user/collectiondel";

//新人专享
static NSString * const API_user_newlyweds =  @"pet/index.php/index/user/newlyweds";

//我的
static NSString * const API_user_groupbuy =  @"pet/index.php/index/user/groupbuy";

//发表评论
static NSString * const API_Goods_comment =  @"pet/index.php/index/Goods/comment";

//发表评论图片获取
static NSString * const API_Goods_commenta =  @"pet/index.php/index/Goods/commenta";

//我的订单
static NSString * const API_Goods_myorde =  @"pet/index.php/index/Goods/myorde";

//申请退款信息
static NSString * const API_Goods_application =  @"pet/index.php/index/Goods/application";

//申请退款信息
static NSString * const API_Goods_refund =  @"pet/index.php/index/Goods/refund";
//退款/售后
static NSString * const API_Goods_aftersale =  @"pet/index.php/index/Goods/aftersale";
//取消订单
static NSString * const API_Goods_cancellation =  @"pet/index.php/index/Goods/cancellation";
//订单详情
static NSString * const API_user_details =  @"pet/index.php/index/user/details";
//确认收货
static NSString * const API_user_receip =  @"pet/index.php/index/user/receip";

/**************************积分商城****************************/

//我的积分
static NSString * const API_user_mypoints =  @"pet/index.php/index/user/mypoints";
//积分商城
static NSString * const API_user_integralmal =  @"pet/index.php/index/user/integralmal";
//我的兑换
static NSString * const API_user_myexchange =  @"pet/index.php/index/user/myexchange";
//我的评价
static NSString * const API_user_myevaluation =  @"pet/index.php/index/user/myevaluation";

/**************************消息及反馈****************************/

//客服消息
static NSString * const API_user_customer =  @"pet/index.php/index/user/customer";
//客服消息详情
static NSString * const API_user_customerl =  @"pet/index.php/index/user/customerl";
//系统通知
static NSString * const API_user_service =  @"pet/index.php/index/user/service";
//系统通知详情
static NSString * const API_user_servicel =  @"pet/index.php/index/user/servicel";
//消息通知
static NSString * const API_user_notification =  @"pet/index.php/index/user/notification";
#endif
