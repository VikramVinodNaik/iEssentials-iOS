//
//  WPHTTPRequestOperationManager.h
//  BaseApp
//
//  Created by Vikram Naik on 09/06/16.
//  Copyright © 2016 Vikram Naik. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface MyAppAFHTTPSessionManager : AFHTTPSessionManager


/**
 Overloaded initializer for our networkingEnabled flag (default: true)
 */
- (instancetype)initWithBaseURL:(NSURL *)url;
/**
 
 
 Overloaded operation factory for wrapping client callbacks and applying
 the networkingEnabled switch to allow/prevent network traffic.
 */
//- (AFHTTPRequestOperation *)HTTPRequestOperationWithRequest:(NSURLRequest *)request
//                                                    success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
//                                                    failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;



/**
 API for enabling/disabling subsequent network traffic.
 */
- (void)isNetworkingEnabled:(BOOL)isEnabled;




@end
