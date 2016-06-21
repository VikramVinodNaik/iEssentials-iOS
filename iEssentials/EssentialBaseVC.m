//
//  EssentialBaseVC.m
//  iEssentials
//
//  Created by Vikram Naik on 17/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "EssentialBaseVC.h"
#import "AppDelegate.h"



@interface EssentialBaseVC ()

@end

@implementation EssentialBaseVC
{
    AppDelegate *appDelegate;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpToolBar];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.tiledBackground) {
        UIColor* color = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ViewBG_image"]];
        self.view.backgroundColor = color;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setUpToolBar
{
    
    self.navigationController.toolbarHidden=NO;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.toolbar setBarTintColor:[UIColor whirlpoolToolBarColor]];
    
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIImage *background = [UIImage imageNamed:@"toolbaraddicon"];
    UIButton *addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [addButton addTarget:self action:@selector(addTrayButtonTapped:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [addButton setBackgroundImage:background forState:UIControlStateNormal];
    addButton.frame = CGRectMake(0 ,0,background.size.width-20,background.size.height-30);
    UIBarButtonItem *toolBarButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:addButton];
    
    background = [UIImage imageNamed:@"toolbarcameraicon"];
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cameraButton addTarget:self action:@selector(cameraButtonTapped:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [cameraButton setBackgroundImage:background forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(0 ,0,background.size.width-20,background.size.height-20);
    UIBarButtonItem *toolBarButtonCamera = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    background = [UIImage imageNamed:@"toolbarcarticon"];
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cartButton addTarget:self action:@selector(cartButtonTapped:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [cartButton setBackgroundImage:background forState:UIControlStateNormal];
    cartButton.frame = CGRectMake(0 ,0,background.size.width-20,background.size.height-20);
    UIBarButtonItem *toolBarButtonCart = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    NSArray *items = [NSArray arrayWithObjects:toolBarButtonCamera,flexiableItem, toolBarButtonAdd,flexiableItem, toolBarButtonCart, nil];
    self.toolbarItems = items;
    
    
}

- (void)addTrayButtonTapped:(id)sender
{
    NSLog(@"Add tray Btn Clicked ");
}

- (void)cameraButtonTapped:(id)sender
{
    NSLog(@"Camera Btn Clicked ");
}

- (void)cartButtonTapped:(id)sender
{
    NSLog(@"Camera Btn Clicked ");
}


@end
