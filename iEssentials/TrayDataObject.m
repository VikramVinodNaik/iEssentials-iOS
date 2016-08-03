//
//  TrayDataObject.m
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "TrayDataObject.h"
#import "TraySectionObject.h"

@implementation TrayDataObject

- (void)readFromJSONDictionary:(NSDictionary *)attrs
{
    _name = attrs[@"Name"];
    _trayId = (long)[attrs[@"id"] intValue];
    _userId = (long)[attrs[@"UserId"] intValue];
    
    if(![attrs[@"sections"] isKindOfClass:[NSNull class]])
    {
        _sections = [[NSMutableArray alloc] init];
        
        for (NSDictionary *dict in attrs[@"sections"]) {
            
            TraySectionObject *section = [[TraySectionObject alloc] init];
            [section readFromJSONDictionary:dict];
            
            [_sections addObject:section];
            
        }
    }
    
    
}

@end
