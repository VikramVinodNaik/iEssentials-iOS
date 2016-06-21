//
//  EssentialWebServiceStore.h
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EssentialMemberObject.h"


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


@end
