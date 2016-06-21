//
//  AccountSettingVC.m
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "AccountSettingVC.h"

#define SAVE_TRAY_BUTTON_TAG 103

@implementation AccountSettingVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"Account Settings";
    self.tiledBackground = YES;
    
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"whitearrow"] forBarPosition:UIBarPositionTopAttached barMetrics:UIBarMetricsDefault];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)setUpDefaultToolBar
{
    [super setUpDoneBtnToolBar];
}

- (void)toolBarButtonClicked:(id)sender
{
    UIButton *clickedButton = sender;
    if(clickedButton.tag == SAVE_TRAY_BUTTON_TAG)
    {
        NSLog(@"Save tray Btn Clicked captured in Settings Controller ");
        [self.navigationController popViewControllerAnimated:YES];
    }
}
@end
