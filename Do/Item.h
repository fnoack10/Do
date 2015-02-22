//
//  Item.h
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class List;

@interface Item : NSManagedObject

@property (nonatomic, retain) NSString * id;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * dueDate;
@property (nonatomic, retain) NSNumber * estimation;
@property (nonatomic, retain) NSDate * creationDate;
@property (nonatomic, retain) NSNumber * isDone;
@property (nonatomic, retain) List *list;

@end
