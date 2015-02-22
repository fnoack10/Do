//
//  Item+Do.m
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "Item+Do.h"

@implementation Item (Do)

+ (Item *)item: (NSDictionary *)newItem inManagedObjectContext: (NSManagedObjectContext *) context
{
    Item *item = nil;
    
    // ADD IDENTIFIER
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Item"];
    request.predicate = [NSPredicate predicateWithFormat:@"id = %@",[newItem valueForKey:@"id"]];
    
    // SEARCH FOR LAST ID
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || [matches count] > 1) {
        // handle error
        NSLog(@"handle error in fetch request");
    } else if ([matches count]){
        item = [matches firstObject];
    } else {
        item = [NSEntityDescription insertNewObjectForEntityForName:@"Item" inManagedObjectContext:context];
        item.name = [newItem valueForKey:@"name"];
        item.creationDate= [NSDate date];
        item.dueDate = [newItem valueForKey:@"dueDate"];
        item.estimation = [newItem valueForKey:@"estimation"];
        item.isDone = [NSNumber numberWithBool:NO];
    }
    
    return item;
}


@end
