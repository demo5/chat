//
//  GetToken.m
//  RongYun
//
//  Created by YoKing on 16/7/7.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "GetToken.h"
#import "NSString+Extension.h"

#define AppKey  @"cpj2xarljlvpn"
#define RCSecret  @"CztCQW6KwJ6wB"

@implementation GetToken

+(NSString *)getTokenWithUserId:userId userName:(NSString *)username portraitUri:(NSString *)portraitUri{
    int value = (arc4random() % 1000);//随机数
    NSString *valueString = [NSString stringWithFormat:@"%d",value];//随机数字符串
    
    NSDate* timeData = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval interval=[timeData timeIntervalSince1970] * 1000; //时间戳  java时间戳在后面 *1000
    NSString *intervalString = [NSString stringWithFormat:@"%0.f",interval];//时间戳字符串
    
    NSString *signature = [NSString stringWithFormat:@"%@%@%@",RCSecret,valueString,intervalString];//拼接字符串
    
    NSString *sha1signature = [[NSString alloc] sha1WithNSString:signature];//生成哈希字符串
    
    //    NSLog(@"【\nvalueString:%@\nintervalString:%@\nsignature:%@\n】",valueString,intervalString,signature);
    //    NSLog(@"sha1signature--------:%@",sha1signature);
    
    
    
    NSString *urlString = @"https://api.cn.ronghub.com/user/getToken.json";
    
    NSURL *url=[[NSURL alloc]initWithString:urlString];
    
//    NSString *bodyString = @"userId=8003&name=8001&portraitUri=http%3A%2F%2Fabc.com%2Fmyportrait.jpg";
    NSString *bodyString = [NSString stringWithFormat:@"userId=%@&name=%@&portraitUri=%@",userId,username,portraitUri];
    NSData *bodyData = [bodyString dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request=[[NSMutableURLRequest alloc]initWithURL:url
                                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                                         timeoutInterval:20.0f];
    [request setHTTPMethod: @"POST"];
    
    
    [request setValue:AppKey forHTTPHeaderField:@"App-Key"];
    [request setValue:valueString forHTTPHeaderField:@"Nonce"];
    [request setValue:intervalString forHTTPHeaderField:@"Timestamp"];
    [request setValue:sha1signature forHTTPHeaderField:@"Signature"];
    [request setValue: @"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)bodyString.length] forHTTPHeaderField:@"Content-Length"];
    
    [request setHTTPBody:bodyData];
    
    //    NSLog(@"头：headers-----%@\n请求体-:%@",request.allHTTPHeaderFields,[[NSString alloc]initWithData:request.HTTPBody encoding:NSUTF8StringEncoding]);
    
    
    NSError *error = nil;
    NSHTTPURLResponse* urlResponse = nil;
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request
                                                 returningResponse:&urlResponse error:&error];
    //    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
    
    
    if ([json objectForKey:@"token"]) {
        return [json objectForKey:@"token"];
    }else{
        return nil;
    }
    
    
   return nil;

}
@end
