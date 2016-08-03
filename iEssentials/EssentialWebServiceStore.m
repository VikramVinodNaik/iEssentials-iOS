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

NSString * const EssentialStoreBaseURLString = @"http://52.32.176.237/hackathon/iEssentials/";

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
        
        NSString *myString = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        
        NSLog(@"Error string: %@", myString);
        
        NSLog(@"Error: %@", error);
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];
}


- (void)updateMember:(EssentialMemberObject *)member completion:(void (^)(EssentialMemberObject *member, NSError *error))completionHandler
{
 
    NSData *data = UIImagePNGRepresentation(member.profileImage);
    NSString *base64 = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];

    NSString *path = @"user/";
    NSDictionary *params = @{@"user_id" : [NSString stringWithFormat:@"%ld", member.memberID],
                             @"username"   : member.username,
                             @"pwd"        : member.password,
                             @"imagedata"  : base64,
                             @"phone"      : member.getPlainPhoneNumber,
                             @"action"     : @"update"
                             };

    [self.webservice_manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        NSLog(@"Progress: %lld", uploadProgress.completedUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject)
        {
            [self.currentMember readFromJSONDictionary:responseObject];
        }
        
        if(completionHandler)
            completionHandler(self.currentMember, nil);

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error);
        
        if(completionHandler)
            completionHandler(nil, error);
    }];
}

- (void)saveDeviceTokenForCurrentUser:(NSData *)deviceToken
{
    NSString *path = @"user/";
    NSDictionary *params = @{@"user_id" : [NSString stringWithFormat:@"%ld", self.currentMember.memberID],
                             @"device_type"   : @"iOS",
                             @"device_token"  : deviceToken,
                             @"action"     : @"SaveDeviceToken"
                             };
    
    [self.webservice_manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject && [responseObject[@"Result"] isEqualToString:@"Success"])
        {
            //Device token save successfully
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSLog(@"Error: %@", error);
        
    }];
}


- (void)createMember:(EssentialMemberObject *)member completion:(void (^)(EssentialMemberObject *member, NSError *error))completionHandler
{
    NSData *data = UIImagePNGRepresentation(member.profileImage);
    NSString *base64 = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    NSString *path = @"user/";
    NSDictionary *params = @{@"username"   : member.username,
                             @"pwd"        : member.password,
                             @"phone"      : member.phoneNumber,
                             @"imagedata"  : base64,
                             @"action"     : @"create"
                             };

    
    [self.webservice_manager POST:path parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //        NSLog(@"Progress: %lld", uploadProgress.completedUnitCount);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if(responseObject)
        {
            
            [member readFromJSONDictionary:responseObject];
        }
        
        if(completionHandler)
            completionHandler(member, nil);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *myString = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];

        NSLog(@"Progress: %@", myString);
        
        if(completionHandler)
            completionHandler(nil, error);

        
    }];
}


- (void)getTrayListWithCompletionHandler:(void (^)(NSMutableArray *trayObjects, NSError *error))completionHandler
{
    NSString *path = @"tray/";
    
    NSDictionary *params = @{@"user_id": [NSString stringWithFormat:@"%ld", self.currentMember.memberID]};

    
    [self.webservice_manager GET:path parameters:params progress:nil success:^(NSURLSessionTask *task, id responseObject) {
        
        if([responseObject isKindOfClass:[NSDictionary class]] && [responseObject objectForKey:@"Error"])
        {
            if (completionHandler) {
                completionHandler(nil, [NSError errorWithDomain:@"" code:3001 userInfo:@{@"ERROR": responseObject[@"Error"]}]);
            }
        }
        else
        {
        NSMutableArray *arrTrays = [NSMutableArray new];
        
        for (NSDictionary *dict in responseObject) {
            
            TrayDataObject *tray  = [[TrayDataObject alloc] init];
            [tray readFromJSONDictionary:dict];
            [arrTrays addObject:tray];
            
        }

        if (completionHandler) {
            completionHandler(arrTrays, nil);
        }
        }
        
    } failure:^(NSURLSessionTask *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];
}


- (void)updateSection:(TraySectionObject *)section completion:(void (^)(TraySectionObject *section, NSError *error))completionHandler
{
    NSString *path = @"sections/";
    NSDictionary *params = @{@"user_id": [NSString stringWithFormat:@"%ld", self.currentMember.memberID],
                             @"tray_id": [NSString stringWithFormat:@"%ld", section.trayId],
                             @"section_id" : [NSString stringWithFormat:@"%ld", section.sectionId],
                             @"name"   : section.sectionName,
                             @"item_name"        : section.itemName,
                             @"userItemQty"     : [NSString stringWithFormat:@"%.2f", section.userItemQty]
                             };
    
    
    [self.webservice_manager POST:path parameters:params constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (completionHandler) {
            completionHandler(section, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        NSString *myString = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        
        NSLog(@"Error: %@", myString);
        
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];

}


- (void)createTray:(NSString *)trayName SectionsDict:(NSDictionary *)sections completion:(void (^)(TrayDataObject *tray, NSError *error))completionHandler
{
    NSString *path = @"tray/";
    NSDictionary *params = @{@"user_id": [NSString stringWithFormat:@"%ld", self.currentMember.memberID],
                             @"tray_name": [NSString stringWithFormat:@"%@", trayName],
                             @"sections" : sections};
    
    
    [self.webservice_manager POST:path parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        
        TrayDataObject *tray = [[TrayDataObject alloc] init];
        [tray readFromJSONDictionary:responseObject];
        
        if (completionHandler) {
            completionHandler(tray, nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        NSString *myString = [[NSString alloc] initWithData:error.userInfo[@"com.alamofire.serialization.response.error.data"] encoding:NSUTF8StringEncoding];
        
        NSLog(@"Error: %@", myString);
        
        if (completionHandler) {
            completionHandler(nil, error);
        }
    }];
    
}
@end







