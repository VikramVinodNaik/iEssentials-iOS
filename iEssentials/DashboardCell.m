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
    self.trayDetailLabel.text = trayObject.name;
    
    TraySectionObject *section1 = (TraySectionObject *)[trayObject.sections objectAtIndex:0];
    TraySectionObject *section2 = (TraySectionObject *)[trayObject.sections objectAtIndex:1];
    TraySectionObject *section3 = (TraySectionObject *)[trayObject.sections objectAtIndex:2];
    
    self.item1DetailLabel.text = section1.itemName;
    self.item2DetailLabel.text = section2.itemName;
    self.item3DetailLabel.text = section3.itemName;
    
    self.item1QuantityLabel.text = section1.status;
    self.item2QuantityLabel.text = section2.status;
    self.item3QuantityLabel.text = section3.status;
    
    if([[section1.status lowercaseString] isEqualToString:@"full"] || [[section1.status lowercaseString] isEqualToString:@"high"])
    {
        self.item1QuantityLabel.text = @"Full/High";
    }
    
    if([[section2.status lowercaseString] isEqualToString:@"full"] || [[section2.status lowercaseString] isEqualToString:@"high"])
    {
        self.item2QuantityLabel.text = @"Full/High";
    }
    
    if([[section3.status lowercaseString] isEqualToString:@"full"] || [[section3.status lowercaseString] isEqualToString:@"high"])
    {
        self.item3QuantityLabel.text = @"Full/High";
    }
    
    if([[section1.status lowercaseString] isEqualToString:@"empty"] || [[section1.status lowercaseString] isEqualToString:@"low"])
    {
        self.item1QuantityLabel.text = @"Low/Empty";
        
        if(section1.currentQty == 0)
            self.item1QuantityLabel.text = @"Empty Tray";
    }
    
    if([[section2.status lowercaseString] isEqualToString:@"empty"] || [[section2.status lowercaseString] isEqualToString:@"low"])
    {
        self.item2QuantityLabel.text = @"Low/Empty";
        
        if(section1.currentQty == 0)
            self.item2QuantityLabel.text = @"Empty Tray";
    }
    
    if([[section3.status lowercaseString] isEqualToString:@"empty"] || [[section3.status lowercaseString] isEqualToString:@"low"])
    {
        self.item3QuantityLabel.text = @"Low/Empty";
        
        if(section1.currentQty == 0)
            self.item3QuantityLabel.text = @"Empty Tray";
    }
    
    self.item1QuantityLabel.textColor = [UIColor whirlpoolColorForStatus:section1.status];
    self.item2QuantityLabel.textColor = [UIColor whirlpoolColorForStatus:section2.status];
    self.item3QuantityLabel.textColor = [UIColor whirlpoolColorForStatus:section3.status];
    
    self.item1ImageView.image = [UIImage imageNamed:section1.status];
    self.item2ImageView.image = [UIImage imageNamed:section2.status];
    self.item3ImageView.image = [UIImage imageNamed:section3.status];
    
}

@end
