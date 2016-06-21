//
//  EssentialJSONObject.h
//  iEssentials
//
//  Created by Vikram Naik on 21/06/16.
//  Copyright © 2016 whirlpool. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EssentialJSONObject <NSObject>
- (void)readFromJSONDictionary:(NSDictionary *)attrs;
@end
