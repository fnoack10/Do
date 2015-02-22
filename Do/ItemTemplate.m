//
//  ItemTemplate.m
//  Do
//
//  Created by Franco Noack on 21/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "ItemTemplate.h"

@implementation ItemTemplate

- (instancetype) init
{
    self = [super init];
    if(self)
    {
        self.identifier = @"";
        self.name = @"";
    }
    return self;
}

@end
