//
//  ItemTemplate.h
//  Do
//
//  Created by Franco Noack on 21/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemTemplate : NSObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * estimation;
@property (nonatomic, retain) NSString * listIdentifier;

@end
