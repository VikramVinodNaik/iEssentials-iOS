//
//  TrayDataObject.h
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TrayDataObject : NSObject
@property (nonatomic, copy) NSString *detailLabel;

@property (nonatomic, copy) NSString *item1Label;
@property (nonatomic, copy) NSString *item2Label;
@property (nonatomic, copy) NSString *item3Label;

@property (nonatomic, copy) NSString *item1qnty;
@property (nonatomic, copy) NSString *item2qnty;
@property (nonatomic, copy) NSString *item3qnty;

@end
