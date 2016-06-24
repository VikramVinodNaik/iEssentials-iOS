//
//  TrayDetailCell.m
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "TrayDetailCell.h"
#import "TraySectionObject.h"

@interface TrayDetailCell()

@end

@implementation TrayDetailCell


+ (CGFloat)desiredHeight
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 200;
    return 100;
}

- (void)configTrayDetailCell:(TraySectionObject *)trayObject
{
    self.sectionDetailLabel.text = trayObject.sectionDetailLabel;
    self.setionStatusLabel.text = trayObject.sectionStatus;
    
}

@end
