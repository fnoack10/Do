//
//  List.h
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Item;

@interface List : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * itemType;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSSet *items;
@end

@interface List (CoreDataGeneratedAccessors)

- (void)addItemsObject:(Item *)value;
- (void)removeItemsObject:(Item *)value;
- (void)addItems:(NSSet *)values;
- (void)removeItems:(NSSet *)values;

@end
