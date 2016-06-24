//
//  TrayObject.h
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TraySectionObject : NSObject  <EssentialJSONObject>

@property (nonatomic, copy) NSString *sectionDetailLabel;
@property (nonatomic, copy) NSString *sectionStatus;
@property (nonatomic, copy) UIImageView *sectionImageView;

@end
