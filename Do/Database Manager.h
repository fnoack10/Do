//
//  Database Manager.h
//  DriverLog
//
//  Created by Franco Noack on 7/28/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "List.h"
#import "List+Do.h"
#import "Item.h"
#import "Item+Do.h"
#import "ItemTemplate.h"

@interface Database_Manager : NSObject

@property (strong, nonatomic) UIManagedDocument *document;
@property (strong, nonatomic) NSManagedObjectContext *context;

- (void) initializeDocumentAndContext;

- (void) addItem:(NSDictionary *)item;
- (void) addListWithDictionary:(NSDictionary *)listDictionary;

- (NSMutableArray *)fetchAllTasks;
- (NSMutableArray *)fetchTasksByPriority;

@end
