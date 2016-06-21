//
//  MyAppHTTPRequestSerializer.m
//  BaseApp
//
//  Created by Vikram Naik on 09/06/16.
//  Copyright © 2016 Vikram Naik. All rights reserved.
//

#import "MyAppHTTPRequestSerializer.h"
#import "EssentialWebServiceStore.h"

@implementation MyAppHTTPRequestSerializer

- (NSMutableURLRequest *)requestWithMethod:(NSString *)method
                                 URLString:(NSString *)URLString
                                parameters:(NSDictionary *)parameters
                                     error:(NSError *__autoreleasing *)error
{
    NSMutableURLRequest *request = [super requestWithMethod:method
                                                  URLString:URLString
                                                 parameters:parameters
                                                      error:error];
    
//#ifdef _LOGGING_
    NSLog(@"%@ %@ %@", method, URLString, parameters);
//#endif
    
    // Set the timeout to the current WPWISEStore timeout
    request.timeoutInterval = [EssentialWebServiceStore sharedStore].timeoutInterval;
    
    return request;
}

@end
