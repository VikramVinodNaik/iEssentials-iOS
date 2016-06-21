//
//  CameraVC.m
//  iEssentials
//
//  Created by Vikram Naik on 17/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "CameraVC.h"

@interface CameraVC ()

@end

@implementation CameraVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tiledBackground = YES;
    UITabBarItem *tbi = [[UITabBarItem alloc] initWithTitle:@""
                                                      image:[UIImage imageNamed:@"tabbarcameraactive"]
                                                        tag:0];
    [tbi setImage:[[UIImage imageNamed:@"tabbarcamerainactive"]
                   imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
    [tbi setSelectedImage:[[UIImage imageNamed:@"tabbarcameraactive"]
                           imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];

    self.tabBarItem = tbi;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
