//
//  TrayDetailCell.m
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "TrayDetailCell.h"

@implementation TrayDetailCell


+ (CGFloat)desiredHeight
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 200;
    return 100;
}
@end
