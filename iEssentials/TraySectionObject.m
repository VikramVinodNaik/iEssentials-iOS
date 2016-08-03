//
//  TrayObject.m
//  iEssentials
//
//  Created by Vikram Naik on 24/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import "TraySectionObject.h"

@implementation TraySectionObject

- (void)readFromJSONDictionary:(NSDictionary *)attrs
{
    _genericIdentifier = attrs[@"GenericIdentifier"];
    _itemName = attrs[@"ItemName"];
    _sectionName = attrs[@"Name"];
    _originalQty = (float)[attrs[@"OriginalQty"] floatValue];
    _userItemQty = (float)[attrs[@"UserItemQty"] floatValue];
    _currentQty = (float)[attrs[@"Quantity"] floatValue];
    _status = attrs[@"Status"];
    _threshold = (float)[attrs[@"Threshold"] floatValue];
    _unit = attrs[@"Unit"];
    _sectionId = (float)[attrs[@"section_id"] floatValue];
    _trayId = (float)[attrs[@"tray_id"] floatValue];
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    TraySectionObject *copy = [[[self class] alloc] init];
    
    if (copy) {
        
        copy.genericIdentifier = [self.genericIdentifier copyWithZone:zone];
        copy.itemName = [self.itemName copyWithZone:zone];
        copy.sectionName = [self.sectionName copyWithZone:zone];
        copy.originalQty = self.originalQty;
        copy.userItemQty = self.userItemQty;
        copy.currentQty = self.currentQty;
        copy.status = [self.status copyWithZone:zone];
        copy.threshold = self.threshold;
        copy.unit = [self.unit copyWithZone:zone];
        copy.sectionId = self.sectionId;
        copy.trayId = self.trayId;
    }
    
    return copy;
}

@end
