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


NSString * const EssentialStoreBaseURLString = @"http://52.41.97.190/hackathon/iEssentials/";

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
    self.webservice_manager.responseSerializer = [AFJSONResponseSerializer serializer];
    

    
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
    NSString *path = @"user/";
    NSDictionary *params = @{@"username"   : username,
                             @"pwd"        : password
                             };
    
    [self.webservice_manager GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        NSLog(@"%@", responseObject);
         if (responseObject[@"Error"]) {
             NSError *custError = [NSError errorWithDomain:@"com.whirlpool.iessential" code:10 userInfo:responseObject];
               completionHandler(nil, custError);
             return;
        }

        self.currentMember = [[EssentialMemberObject alloc] init];
        if(responseObject)
        {
            [self.currentMember readFromJSONDictionary:responseObject];
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
