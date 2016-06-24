//
//  TrayDetailCell.h
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TraySectionObject;

@interface TrayDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *sectionDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *setionStatusLabel;
@property (weak, nonatomic) IBOutlet UIImageView *sectionImageView;
@property (weak, nonatomic) IBOutlet UIButton *sectionEditButton;

// Override this if needed
+ (CGFloat)desiredHeight;
- (void)configTrayDetailCell:(TraySectionObject *)trayObject;
@end
