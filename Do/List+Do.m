//
//  List+Do.m
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "List+Do.h"

@implementation List (Do)

+ (List *)listWithDictionary: (NSDictionary *)listDictionary inManagedObjectContext: (NSManagedObjectContext *) context
{
    List *list = nil;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"List"];
    request.predicate = [NSPredicate predicateWithFormat:@"id = %@", [listDictionary valueForKey:@"id"]];
    
    NSError *error;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if (!matches || error || [matches count] > 1) {
        // handle error
        NSLog(@"handle error in fetch request");
    } else if ([matches count]){
        list = [matches firstObject];
    } else {
        list = [NSEntityDescription insertNewObjectForEntityForName:@"List" inManagedObjectContext:context];
        list.name = [listDictionary valueForKey:@"name"];
        list.itemType = [listDictionary valueForKey:@"itemType"];
    }
    
    return list;
}

@end
