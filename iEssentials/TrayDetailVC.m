//
//  TrayDetailVC.m
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "TrayDetailVC.h"
#import "TrayDataObject.h"
#import "TrayDetailCell.h"
#import "TraySectionObject.h"

@interface TrayDetailVC ()
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *trayImageView;
@end

@implementation TrayDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    if(self.trayObject)
    self.title = self.trayObject.detailLabel;
    
    
    //Configure Table View Cell
        self.tableView.rowHeight = [TrayDetailCell desiredHeight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    cell.backgroundColor = [UIColor clearColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"TrayDetailCell";
    TrayDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    TraySectionObject *traySection = [self.trayObject.sections objectAtIndex:indexPath.row];
    
    if (cell == nil) {
        cell = [[TrayDetailCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    if(self.trayObject)
    {
        [cell configTrayDetailCell:traySection];
        
    }
    
    return cell;
}

@end
