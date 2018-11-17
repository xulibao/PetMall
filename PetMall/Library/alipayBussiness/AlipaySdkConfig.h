//
//  AlipaySdkConfig.h
//  SnailTruck
//
//  Created by GhGh on 16/1/8.
//  Copyright © 2016年 GhGh. All rights reserved.
//

#ifndef AlipaySdkConfig_h
#define AlipaySdkConfig_h
//  提示：如何获取安全校验码和合作身份者id
//  1.用您的签约支付宝账号登录支付宝网站(www.alipay.com)
//  2.点击“商家服务”(https://b.alipay.com/order/myorder.htm)
//  3.点击“查询合作者身份(pid)”、“查询安全校验码(key)”
//  光辉设置
//安全校验码(Key)
//默认加密： 74y5pgu0t3vsqoejemufw5b370xw60e1
//合作身份者id，以2088开头的16位纯数字
#define PartnerID @"2088921984145481"
//收款支付宝账号
#define SellerID  @"hzpgpm@163.com"
// AppID 2018022702282870
#define WoPaiCheAppID @"2018022702282870"
#define SALT_key @"woniu365"
//安全校验码（MD5）密钥，以数字和字母组成的32位字符
#define MD5_KEY  @"fi4bbo1hbzcxdnrlzctheh0d628v2nz4"
// 支付宝不支持https协议 - 使用后端返回
#define kALPayServerAddress   @"http://www.woniuhuoche.com:8008/truck"// 蜗牛正式
//商户私钥，自助生成
#define PartnerPrivKey @"MIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCKu3xb0hzxGxiDEqY3gTkPPdgyrLkWVPtZ3D4S0DvHoUNaMPjBz6Z2pzfRiN51OQIDJ9WyLA/fzK28zwZpsrR5lMOEomZHTXyHnYb4sdHzUlgQIEMS4R+lHvumDcULlVgOSLWWCu8nOsmy6AKQIcZA+qoyVWFDDOsBHbbYOhRmshKzi+RBcSkwQlzLZyKC3s9gvyE6lWIAToTytvBurHUFqnQpQwHt2PrIs9eFo/snp7HY6grByZCP9IQbaL11qdtGZa+7l37mYYvzEXMhDp5AucuTObtEK2kO/e+CnHidPNisJfnY2rmmo1iiMk1J2AS0S0US7+bJhVZeRChwBhXVAgMBAAECggEAB4EWu/zElgIqNETY+t2hkYJ95FfVdzDHm9e+/9OFuEmv0/wcKJer4HUxHsNxjRO1WShZddbOUQPIThNAvIzvGDiEzvLd53N4jflmaKNtwOSuYMjt9+J3jL39TMEn7HV6muMx91jGEPAsIuJL6TH6gF9Ov4RAy5iySZAq6M1Tdy6MSLkJ6bos2IQ9h/jGfEg+JIG6iB2Bor/g+hVW/7fPZanIy5ul7FBcBQ4lZnTfFaeNIqtHt1x5hJEnO8Pvu726Ly4S0XHoGnnNaoRtu4e+82kTNdAmlnXdi8djPfjGmUBz+OnJpfwONHPEhKqXEQb1hJqgebL1u/0vKMSAjeb5QQKBgQDItk9WG6YXDhly2Hfp+np90NRe3i9lD/d15scQiTkAaSWjdi1B2lt63eWskFSurGK12M9Obl+ICqAk27I8TrpbgenNbWsbJZPBru+mKbkAr/eVE0vJBZmO5kagYQ8mNlgBVegwoRbZeQA/7N5TdErFQiZVKdHih6oFo7x8LnZqxQKBgQCw8oaHctbx4DjMLmq/IuDJGFbcg4ksp3BIBslzWpi1tu+ozxJ2WRWhnINSIIvrdam9FfSUINmvejt49owmnlhJnQlHqCwiJ6TaM9KiuUSJxHZXzHNemBU1rixLfpAY2FbHftfZ1/VBtAexe4x3g82fqr/5x8uEOY7UYQIyi6/v0QKBgF5WKfXr6uW9L8Ll8X6cxwPpqleokJgsp//XZ0rjZFJIGXO58M2Z5xNZxkCUWej7hy23aMCRaf9UFy8bv6tOyZKG/jAatJO+1rLbGTJ9O8IR8wkzV5R1OFaM7zckR22Lb1O5X/ezTz0J/U8OcvTAnQAX9lJi5I5Xe1dJPScU432NAoGAfnKBgm+lfKmfzQFqlPYmrm3vPJvevgNVcJMxCHb4Y/q7nuWDKwGUPK4tBdZuRrAJwS7cXbJv/T8bGuEM3FgRfWF0DTn3d9zeqHOaFWDRwqWbcDiRRUrm9TpnOvfRn3+R2/Qf6fOytuYhDUrd4VZV7cDGeYe2PuIm2EwOlvJNotECgYBPKCFzZf6jnOpJT7/L8VbNYwlpldsauorZh0aAgaaeefp0Zz50TjbsYDfsJjEKqKK1TP8rhwvY+6UdSv5auwLPfSDop3AxnRQjy7JzMefqIDHRjdmP+l49mj3d7Qbu+2i1Qd3u932rmqZH6EXx/uac1iz5+XU7YVX9Yx0dSa29Ag=="


//支付宝公钥
#define AlipayPubKey  @"MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAjgfPh3yxqT9+/jUuNhi9G5O93Zno4u0k+W+18iHaOndjMemjEnkckg70M1fQ8HPfEs5icUo0bImonzF2a9lU4gDhsosVb+LnuhjrgZIQxCF1c+IeRQ/6kWwqNfQw4afJ9Jfrbm4EJGFccx8bxRk9WAX6qdWCwzykYWrl0oqYn4R/9eWSdrNbzqWuT8wLLEXGMV8BAhLuRqqCzaj1bq/uaxmQ6G/uB0QcYKj0QDQ/EOfKG7qs5++mwWf3TMAH9IaSX41LaEWW5W/vgC0/K6T+uanDXe0son4+uOxc5Esj/JjtxUk25/m/dicdiCLcalPbpqqmhx25ubmr+33wUuedHQIDAQAB"

#endif /* AlipaySdkConfig_h */
