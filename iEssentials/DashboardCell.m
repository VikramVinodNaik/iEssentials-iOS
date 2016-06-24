//
//  DashboardCell.m
//  iEssentials
//
//  Created by Vikram Naik on 20/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "DashboardCell.h"
#import "TrayDataObject.h"
#import "TraySectionObject.h"


@implementation DashboardCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)desiredHeight
{
    if(UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
        return 254;
    return 254;
}

- (void)configDashBoardCell:(TrayDataObject *)trayObject
{
    self.trayDetailLabel.text = trayObject.detailLabel;
    
    
    TraySectionObject *section1 = (TraySectionObject *)[trayObject.sections objectAtIndex:0];
    TraySectionObject *section2 = (TraySectionObject *)[trayObject.sections objectAtIndex:1];
    TraySectionObject *section3 = (TraySectionObject *)[trayObject.sections objectAtIndex:2];
    
    self.item1DetailLabel.text = section1.sectionDetailLabel;
    self.item2DetailLabel.text = section2.sectionDetailLabel;
    self.item3DetailLabel.text = section3.sectionDetailLabel;
    self.item1QuantityLabel.text = section1.sectionStatus;
    self.item2QuantityLabel.text = section2.sectionStatus;
    self.item3QuantityLabel.text = section3.sectionStatus;
    
    self.item1ImageView.image = section1.sectionImageView.image;
    self.item2ImageView.image = section1.sectionImageView.image;
    self.item3ImageView.image = section1.sectionImageView.image;
    
}

@end
