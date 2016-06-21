//
//  EssentialMemberObject.h
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EssentialJSONObject.h"

@interface EssentialMemberObject : NSObject <EssentialJSONObject>

@property (nonatomic, copy) NSString *username;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, copy) NSNumber *memberID;
@property (nonatomic, copy) NSString *phoneNumber;

@end
