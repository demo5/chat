//
//  NSString+Extension.m
//  RongYun
//
//  Created by YoKing on 16/7/6.
//  Copyright © 2016年 YQ. All rights reserved.
//

#import "NSString+Extension.h"
#import "CommonCrypto/CommonDigest.h"
@implementation NSString (Extension)



- (NSString *)sha1WithNSString:(NSString *)string
{
    
    NSData *data = [string dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}



@end
