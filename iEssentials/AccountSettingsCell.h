//
//  AccountSettingsCell.h
//  iEssentials
//
//  Created by Krishna on 6/28/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomErrorTextField.h"

@interface AccountSettingsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet CustomErrorTextField *txtUsername;
@property (weak, nonatomic) IBOutlet CustomErrorTextField *txtPassword;
@property (weak, nonatomic) IBOutlet UIButton *btnPassword;
@property (weak, nonatomic) IBOutlet CustomErrorTextField *txtConfirmPassword;
@property (weak, nonatomic) IBOutlet CustomErrorTextField *txtPhone;

@property (nonatomic)BOOL isEditing;
@property (strong, nonatomic)void(^changePasswordClicked)(AccountSettingsCell *cell, BOOL hideConfirmPwdTextBox);
@end
