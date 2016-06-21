//
//  ViewController.m
//  iEssentials
//
//  Created by Vikram Naik on 17/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "LoginVC.h"



@interface LoginVC ()<UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UIButton *checkbox;
@property (nonatomic, weak) IBOutlet UILabel *rememberMeLabel;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *forgotPWButton;


@end

@implementation LoginVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpBasicUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) setUpBasicUI
{
    // Set up the UI
    UIFont *font = [UIFont whirlpoolR3Font];
    self.rememberMeLabel.font = font;
    self.forgotPWButton.titleLabel.font = font;
    self.email.font = [UIFont whirlpoolR2Font];
    self.password.font = [UIFont whirlpoolR2Font];
    self.loginButton.enabled = YES;
    
    
    UIColor *color = [UIColor whiteColor];
    self.email.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LOGIN_EMAIL_PLACEHOLDER attributes:@{NSForegroundColorAttributeName: color}];
    
    self.password.attributedPlaceholder = [[NSAttributedString alloc] initWithString:LOGIN_PASSWORD_PLACEHOLDER attributes:@{NSForegroundColorAttributeName: color}];
    
    [self.forgotPWButton setTitle:LOGIN_FORGOT_PASSWORD_TEXT forState:UIControlStateNormal];
    self.forgotPWButton.titleLabel.adjustsFontSizeToFitWidth = YES;
    [self.rememberMeLabel setText:LOGIN_REMEMBER_TEXT];
}

- (IBAction)rememberMe:(id)sender
{
    self.checkbox.selected = !self.checkbox.selected;
}

#pragma mark - Actions
- (IBAction)textFieldDidChange:(UITextField *)sender
{
    BOOL nonEmptyEmail = self.email.text.length > 0;
    BOOL nonEmptyPassword = self.password.text.length > 0;
    self.loginButton.enabled = nonEmptyEmail && nonEmptyPassword;
    
}

@end