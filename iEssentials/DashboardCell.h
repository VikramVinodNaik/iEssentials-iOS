//
//  DashboardCell.h
//  iEssentials
//
//  Created by Vikram Naik on 20/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DashboardCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *trayImageView;
@property (weak, nonatomic) IBOutlet UILabel *trayDetailLabel;
@property (weak, nonatomic) IBOutlet UIButton *trayDetailsButton;
@property (weak, nonatomic) IBOutlet UIImageView *item1ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *item2ImageView;
@property (weak, nonatomic) IBOutlet UIImageView *item3ImageView;

@property (weak, nonatomic) IBOutlet UILabel *item1DetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *item2DetailLabel;
@property (weak, nonatomic) IBOutlet UILabel *item3DetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *item1QuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *item2QuantityLabel;
@property (weak, nonatomic) IBOutlet UILabel *item3QuantityLabel;


// Override this if needed
+ (CGFloat)desiredHeight;

@end
