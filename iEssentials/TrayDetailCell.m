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

@property (weak, nonatomic) IBOutlet UILabel *lblQtyRemaiming;
@end

@implementation TrayDetailCell



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
        return 200;
    return 100;
}

- (void)configTrayDetailCell:(TraySectionObject *)section
{
    self.sectionDetailLabel.text = section.itemName;
    self.setionStatusLabel.text = section.status;
    
    if([[section.status lowercaseString] isEqualToString:@"full"] || [[section.status lowercaseString] isEqualToString:@"high"])
    {
        self.setionStatusLabel.text = @"Full/High";
    }
    
    if([[section.status lowercaseString] isEqualToString:@"empty"] || [[section.status lowercaseString] isEqualToString:@"low"])
    {
        self.setionStatusLabel.text = @"Low/Empty";

        if(section.currentQty == 0)
            self.setionStatusLabel.text = @"Empty Tray";
    }
    
    self.setionStatusLabel.textColor = [UIColor whirlpoolColorForStatus:section.status];
    
    //(1*55)/100
    float qtyInHand = section.userItemQty * (section.currentQty/100);
    
    if(qtyInHand > .15 && qtyInHand < .50)
    {
        qtyInHand = 1;
    }
    else
    {
        qtyInHand = round(section.userItemQty * (section.currentQty/100));
    }
    
    _lblQtyRemaiming.text = [NSString stringWithFormat:@"%.0f out of %.0f remaining approximately", qtyInHand, section.userItemQty];
    
    _sectionImageView.image = [UIImage imageNamed:section.status];
    _lblSectionName.text = section.sectionName;
}
- (void)hideEditButtonForIndex:(BOOL)hideEditButton
{
    self.sectionEditButton.hidden = hideEditButton;
}

@end
