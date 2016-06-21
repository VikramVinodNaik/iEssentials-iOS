//
//  EssentialEditTextVC.m
//  iEssentials
//
//  Created by Vikram Naik on 17/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "EssentialEditTextVC.h"

@implementation EssentialEditTextVC


- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    
    // Drawing code
    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, self.frame.size.height - 1, self.frame.size.width, 1.0f);
    bottomBorder.backgroundColor = [UIColor lightGrayColor].CGColor;
    [self.layer addSublayer:bottomBorder];
    
    
}

@end
