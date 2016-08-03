//
//  EssentialWebServiceStore.h
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EssentialMemberObject.h"
#import "TrayDataObject.h"
#import "TraySectionObject.h"

// Notifications
extern NSString * const WPReachabilityChangedNotification;


@interface EssentialWebServiceStore : NSObject

@property (nonatomic, strong) EssentialMemberObject *currentMember;
@property (nonatomic) NSTimeInterval timeoutInterval;
+ (instancetype)sharedStore;

//WebServices
- (void)loginWithEmail:(NSString *)username
              password:(NSString *)password
            completion:(void (^)(EssentialMemberObject *member, NSError *error))completionHandler;

- (void)updateMember:(EssentialMemberObject *)member completion:(void (^)(EssentialMemberObject *member, NSError *error))completionHandler;
- (void)saveDeviceTokenForCurrentUser:(NSData *)deviceToken;
- (void)createMember:(EssentialMemberObject *)member completion:(void (^)(EssentialMemberObject *member, NSError *error))completionHandler;

- (void)getTrayListWithCompletionHandler:(void (^)(NSMutableArray *trayObjects, NSError *error))completionHandler;

- (void)updateSection:(TraySectionObject *)section completion:(void (^)(TraySectionObject *section, NSError *error))completionHandler;
- (void)createTray:(NSString *)trayName SectionsDict:(NSDictionary *)sections completion:(void (^)(TrayDataObject *tray, NSError *error))completionHandler;

@end
