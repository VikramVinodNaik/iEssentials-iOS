//
//  EssentialWebServiceStore.m
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "EssentialWebServiceStore.h"
#import "MyAppAFHTTPSessionManager.h"
#import "MyAppHTTPRequestSerializer.h"
#import "AppDelegate.h"


NSString * const EssentialStoreBaseURLString = @"http://10.236.10.63/hackathon/";

// Timeout intervals
NSTimeInterval const WPDefaultWISERequestTimeout = 60;
NSTimeInterval const WPLongerWISERequestTimeout =(WPDefaultWISERequestTimeout * 16 / 10);

NSString * const WPReachabilityChangedNotification = @"WPReachabilityChangedNotification";


@interface EssentialWebServiceStore ()
@property (nonatomic, strong) MyAppAFHTTPSessionManager *webservice_manager;
@end


@implementation EssentialWebServiceStore
{
    AppDelegate *appDelegate;
}

+ (instancetype)sharedStore
{
    static EssentialWebServiceStore *sharedStore = nil;
    static dispatch_once_t WPWISEOnceToken;
    dispatch_once(&WPWISEOnceToken, ^{
        sharedStore = [[EssentialWebServiceStore alloc] init];
    });
    return sharedStore;
}


- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        appDelegate = [[UIApplication sharedApplication]delegate];
        
        // Set up default timeout interval before we start any networking stuff
        self.timeoutInterval = WPDefaultWISERequestTimeout;
        [self configureNetworkManagers:@"DEV"];
    }
    
    return self;
}


- (void)configureNetworkManagers:(NSString *)serverConfigKey
{
    
    NSURL *baseURL = [NSURL URLWithString:EssentialStoreBaseURLString];
    
    self.webservice_manager = [[MyAppAFHTTPSessionManager alloc] initWithBaseURL:baseURL];
    self.webservice_manager.requestSerializer = [MyAppHTTPRequestSerializer serializer];
    self.webservice_manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    //     self.webservice_manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    // [self.webservice_manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    //#if defined (__DEV__)
    
    [self.webservice_manager.securityPolicy setValidatesDomainName:NO];
    [self.webservice_manager.securityPolicy setAllowInvalidCertificates:YES];
    
    //#endif
    
    
    // Set up the reachability manager
    NSOperationQueue *operationQueue = self.webservice_manager.operationQueue;
    [self.webservice_manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability status: %@", AFStringFromNetworkReachabilityStatus(status));
        
        NSDictionary *statusDict = @{@"status": [NSNumber numberWithInteger:status]};
        
        [[NSNotificationCenter defaultCenter] postNotificationName:WPReachabilityChangedNotification object:nil userInfo:statusDict];
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
    
    [self.webservice_manager.reachabilityManager startMonitoring];
    
    NSString *clientApp = [[NSBundle mainBundle] bundleIdentifier];
    NSString *clientPF =  [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleAppPlatformForHeader"];
    NSString *clientVer = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSLog(@"Client Info: appName=\"%@\", platform=\"%@\", version=\"%@\"",
          clientApp, clientPF, clientVer);
    
    
}


- (void)loginWithEmail:(NSString *)username
              password:(NSString *)password
            completion:(void (^)(EssentialMemberObject *member, NSError *error))completionHandler
{
    NSString *path = @"users/";
    NSDictionary *params = @{@"username"   : username,
                             @"pwd"        : password
                             };
    
    [self.webservice_manager GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSDictionary *responseJson = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
        NSLog(@"%@", responseJson);
        self.currentMember = [[EssentialMemberObject alloc] init];
        if(responseJson)
        {
            [self.currentMember readFromJSONDictionary:responseJson];
        }
        if (completionHandler) {
            completionHandler(self.currentMember, nil);
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];
}


@end
