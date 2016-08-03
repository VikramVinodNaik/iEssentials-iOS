//
//  TrayObject.h
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TraySectionObject : NSObject  <EssentialJSONObject, NSCopying>

@property (nonatomic, copy) NSString *genericIdentifier;
@property (nonatomic, copy) NSString *itemName;
@property (nonatomic, copy) NSString *sectionName;
@property(nonatomic) float originalQty;
@property(nonatomic) float currentQty;
@property(nonatomic) float userItemQty;
@property(nonatomic) float threshold;
@property (nonatomic, copy) NSString *unit;;
@property (nonatomic, copy) NSString *status;;
@property (nonatomic) long trayId;
@property (nonatomic) long sectionId;
@property (nonatomic, copy) UIImageView *sectionImageView;
@property(nonatomic) BOOL showEditButtonForSection;

@end
