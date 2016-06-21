//
//  EssentialMemberObject.m
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "EssentialMemberObject.h"

@implementation EssentialMemberObject

- (void)readFromJSONDictionary:(NSDictionary *)attrs
{
    self.username = (attrs[@"Username"] ?: self.username);
    self.password = (attrs[@"Password"] ?: self.password);
    self.memberID = (attrs[@"id"] ?: self.memberID);
    self.phoneNumber = (attrs[@"Phone"] ?: self.phoneNumber);
}

@end
