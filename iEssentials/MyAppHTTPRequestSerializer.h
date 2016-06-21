//
//  MyAppHTTPRequestSerializer.h
//  BaseApp
//
//  Created by Vikram Naik on 09/06/16.
//  Copyright © 2016 Vikram Naik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFURLRequestSerialization.h"

@interface MyAppHTTPRequestSerializer : AFHTTPRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                     error:(NSError *__autoreleasing *)error;


@end
