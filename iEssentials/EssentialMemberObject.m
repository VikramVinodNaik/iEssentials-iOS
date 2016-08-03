//
//  EssentialMemberObject.m
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "EssentialMemberObject.h"

@implementation EssentialMemberObject

- (void)readFromJSONDictionary:(NSDictionary *)attrs
{
    self.username = (attrs[@"Username"] ?: self.username);
    self.password = (attrs[@"Password"] ?: self.password);
    self.memberID = (long)[attrs[@"id"] intValue];;
    self.phoneNumber = (attrs[@"Phone"] ?: self.phoneNumber);
    
    self.profileImage = [self decodeBase64ToImage: (attrs[@"Image"] ?: nil)];
}

- (UIImage *)decodeBase64ToImage:(NSString *)strEncodeData {
    
    if(strEncodeData && ![strEncodeData isKindOfClass:[NSNull class]])
    {
        NSData *data = [[NSData alloc]initWithBase64EncodedString:strEncodeData options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *img = [UIImage imageWithData:data];
        return img;
    }
    else
    {
        return nil;
    }
}

-(NSString *)getPlainPhoneNumber
{
    NSString *mobileNumber = _phoneNumber;
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"(" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@")" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@" " withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];
    mobileNumber = [mobileNumber stringByReplacingOccurrencesOfString:@"+" withString:@""];
    
    NSLog(@"%@", mobileNumber);
    
    int length = (int)[mobileNumber length];
    if(length > 10)
    {
        mobileNumber = [mobileNumber substringFromIndex: length-10];
        NSLog(@"%@", mobileNumber);
        
    }
    
    return mobileNumber;
}
@end
