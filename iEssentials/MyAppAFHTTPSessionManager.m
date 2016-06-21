//
//  WPHTTPRequestOperationManager.m
//  BaseApp
//
//  Created by Vikram Naik on 09/06/16.
//  Copyright © 2016 Vikram Naik. All rights reserved.
//

#import "MyAppAFHTTPSessionManager.h"

@interface MyAppAFHTTPSessionManager()
// Master switch to enable/disable HTTP operations (e.g. if the application's end-of-life has been detected)
@property (nonatomic) BOOL networkingEnabled;

@end

@implementation MyAppAFHTTPSessionManager

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    self.networkingEnabled = true;
    
    return self;
}


- (void)isNetworkingEnabled:(BOOL)isEnabled
{
    self.networkingEnabled = isEnabled;
}

@end
