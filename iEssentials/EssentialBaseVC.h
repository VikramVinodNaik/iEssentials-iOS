//
//  EssentialBaseVC.h
//  iEssentials
//
//  Created by Vikram Naik on 17/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <UIKit/UIKit.h>

#define isPhone568 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 568)
#define isPhone480 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 480)
#define isPhone667 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 667)
#define isPhone736 ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone && [UIScreen mainScreen].bounds.size.height == 736)


@interface EssentialBaseVC : UIViewController

@property (nonatomic) BOOL tiledBackground;

-(void)setUpDefaultToolBar;
-(void)setUpDoneBtnToolBar;
-(void)setUpAddTrayToolBar;
-(void)setUpSaveBtnToolBar;
-(void)setUpCreateBtnToolBar;

- (void)toolBarButtonClicked:(id)sender;
- (void)updateUI:(NSNotification *)note;
-(void)logout;

@end
