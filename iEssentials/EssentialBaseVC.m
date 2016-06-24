//
//  EssentialBaseVC.m
//  iEssentials
//
//  Created by Vikram Naik on 17/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "EssentialBaseVC.h"
#import "AppDelegate.h"


#define CAMERA_BUTTON_TAG 100
#define ADD_TRAY_BUTTON_TAG 101
#define CART_BUTTON_TAG 102
#define SAVE_TRAY_BUTTON_TAG 103



@interface EssentialBaseVC ()

@end

@implementation EssentialBaseVC
{
    AppDelegate *appDelegate;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self setUpDefaultToolBar];
    
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

-(void)setUpDefaultToolBar
{
    
    self.navigationController.toolbarHidden=NO;
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController.toolbar setBarTintColor:[UIColor whirlpoolToolBarColor]];
    
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    
    UIImage *background = [UIImage imageNamed:@"toolbaraddicon"];
    UIButton *addTrayButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addTrayButton.tag = ADD_TRAY_BUTTON_TAG;
    [addTrayButton addTarget:self action:@selector(toolBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [addTrayButton setBackgroundImage:background forState:UIControlStateNormal];
    addTrayButton.frame = CGRectMake(0 ,0,background.size.width-25,background.size.height-30);
    UIBarButtonItem *toolBarButtonAdd = [[UIBarButtonItem alloc] initWithCustomView:addTrayButton];
    
    background = [UIImage imageNamed:@"toolbarcameraicon"];
    UIButton *cameraButton = [UIButton buttonWithType:UIButtonTypeCustom];
     cameraButton.tag = CAMERA_BUTTON_TAG;
    [cameraButton addTarget:self action:@selector(toolBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [cameraButton setBackgroundImage:background forState:UIControlStateNormal];
    cameraButton.frame = CGRectMake(0 ,0,background.size.width-20,background.size.height-20);
    
    UIBarButtonItem *toolBarButtonCamera = [[UIBarButtonItem alloc] initWithCustomView:cameraButton];
    
    background = [UIImage imageNamed:@"toolbarcarticon"];
    UIButton *cartButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cartButton.tag =  CART_BUTTON_TAG;
    [cartButton addTarget:self action:@selector(toolBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    [cartButton setBackgroundImage:background forState:UIControlStateNormal];
    cartButton.frame = CGRectMake(0 ,0,background.size.width-20,background.size.height-20);
    UIBarButtonItem *toolBarButtonCart = [[UIBarButtonItem alloc] initWithCustomView:cartButton];
    
    NSArray *items = [NSArray arrayWithObjects:toolBarButtonCamera,flexiableItem, toolBarButtonAdd,flexiableItem, toolBarButtonCart, nil];
    self.toolbarItems = items;
}


-(void)setUpDoneBtnToolBar
{
    
    self.navigationController.toolbarHidden=NO;
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *flexiableItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIButton *saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
    saveButton.tag = SAVE_TRAY_BUTTON_TAG;
    [saveButton addTarget:self action:@selector(toolBarButtonClicked:) forControlEvents:UIControlEventTouchUpInside]; //adding action
    
    [saveButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [saveButton setTitle:@"Done" forState:UIControlStateNormal];
    
    CGRect frame = self.navigationController.toolbar.frame;
     saveButton.frame = CGRectMake(0 ,0,frame.size.width,frame.size.height);
    [saveButton.titleLabel setFont:[UIFont whirlpoolB1Font]];
    UIBarButtonItem *toolBarButtonSaveTray = [[UIBarButtonItem alloc] initWithCustomView:saveButton];
    
     NSArray *items = [NSArray arrayWithObjects:flexiableItem, toolBarButtonSaveTray,flexiableItem, nil];
    
    [self setToolbarItems:items animated:YES];

    
}

-(void)setUpAddTrayToolBar
{
    
}

- (void)toolBarButtonClicked:(id)sender
{
    UIButton *clickedButton = sender;
    if(clickedButton.tag == CAMERA_BUTTON_TAG)
    {
        NSLog(@"Camera Btn Clicked ");
    }if(clickedButton.tag == ADD_TRAY_BUTTON_TAG)
    {
        NSLog(@"Add tray Btn Clicked ");
        
    }
    else if(clickedButton.tag == CART_BUTTON_TAG)
    {
        NSLog(@"CART Btn Clicked ");
        
    }else if(clickedButton.tag == SAVE_TRAY_BUTTON_TAG)
    {
        NSLog(@"Save tray Btn Clicked ");
        
    }


}

@end
