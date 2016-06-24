//
//  TrayDetailVC.h
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TrayDataObject;

@interface TrayDetailVC : EssentialBaseVC  <UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong) TrayDataObject *trayObject;

@end
