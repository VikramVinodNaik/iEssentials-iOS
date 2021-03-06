//
//  TrayDataObject.h
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrayDataObject : NSObject  <EssentialJSONObject>

@property (nonatomic, copy) NSString *name;
@property (nonatomic) long trayId;
@property (nonatomic) long userId;
@property (nonatomic,copy)  NSMutableArray *sections;

@end
