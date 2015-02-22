//
//  Database Manager.m
//  DriverLog
//
//  Created by Franco Noack on 7/28/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "Database Manager.h"

@implementation Database_Manager

- (void) initializeDocumentAndContext {
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSURL *documentsDirectory = [[fileManager URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] firstObject];
    NSString *documentName = @"DoDocument";
    NSURL *url = [documentsDirectory URLByAppendingPathComponent:documentName];
    self.document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    BOOL fileExists = [[NSFileManager defaultManager] fileExistsAtPath:[url path]];
    
    if (fileExists) {
        [self.document openWithCompletionHandler:^(BOOL success) {
            if (success) {
                [self getContextForDo];
            } else {
                NSLog(@"Coudn't open the document at %@", url);
            }
        }];
    } else {
        [self.document saveToURL:url forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success) {
            
            if (success) {
                [self getContextForDo];
            } else {
                NSLog(@"Coudn't open the document at %@", url);
            }
        }];
    }
}


- (void) getContextForDo {
    
    if (self.document.documentState == UIDocumentStateNormal) {
        self.context = self.document.managedObjectContext;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"DatabaseReady" object:nil];
        NSLog(@"Document is ready");
        
        
    }
}

- (void) addItem:(NSDictionary *) newItem;
{    
    if (newItem) {
        Item *item = [Item item:newItem inManagedObjectContext:self.context];
        
        if (item && [item isKindOfClass:[Item class]]) {
            NSLog(@"ITEM CREATED");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateTableView" object:nil];
        } else {
            NSLog(@"NO RESULT FOR ITEM IN DATABASE MANAGER");
        }
    } else {
        NSLog(@"BAD REQUEST IN DATABASE MANAGER");
    }
}

- (void) addListWithDictionary:(NSDictionary *)listDictionary
{
    if (listDictionary) {
        List *list = [List listWithDictionary:listDictionary inManagedObjectContext:self.context];

        if (list && [list isKindOfClass:[List class]]) {
            NSLog(@"LIST CREATED");
        } else {
            NSLog(@"NO RESULT FOR LIST IN DATABASE MANAGER");
        }
    } else {
        NSLog(@"BAD REQUEST IN DATABASE MANAGER");
    }
}


- (NSMutableArray *)fetchAllTasks
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    request.fetchBatchSize = 100;
    request.fetchLimit = 100;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO selector:nil];
    request.sortDescriptors = @[sortDescriptor];
    request.predicate = nil;
    
    NSError *error;
    NSMutableArray *items = [[self.context executeFetchRequest:request error:&error] mutableCopy];
    
    if (items) {
        return items;
    } else {
        return nil;
    }
}

- (NSMutableArray *)fetchTasksByPriority
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Item"];
    request.fetchBatchSize = 100;
    request.fetchLimit = 100;
    
    NSSortDescriptor *prioritySortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"estimation" ascending:NO selector:nil];
    NSSortDescriptor *dateSortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO selector:nil];
    request.sortDescriptors = @[prioritySortDescriptor, dateSortDescriptor];
    request.predicate = nil;
    
    NSError *error;
    NSMutableArray *items = [[self.context executeFetchRequest:request error:&error] mutableCopy];
    
    if (items) {
        return items;
    } else {
        return nil;
    }
}

- (NSArray *)fetchUserWithName: (NSString *)name
{
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"User"];
    request.fetchBatchSize = 20;
    request.fetchLimit = 100;
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES selector:@selector(localizedStandardCompare:)];
    request.sortDescriptors = @[sortDescriptor];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    request.predicate = predicate;

    NSError *error;
    NSArray *users = [self.context executeFetchRequest:request error:&error];
    
    if (users) {
        return users;
        
    } else {
        return nil;
    }
    
    
    //get count
    //@"photos.@count > 5"
    // @avg
    
    //example
    
    //NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name contains %@", name];
    // name = %@
    // name contains[c] %@ contains case insensitive
    // view > %@ NSDate
    // who.Took.name = %@ get photos from photographer
    // any photos.title contains %@ gets any photographer that one of it's photos has %@
    
    //request.predicate = nil;
    
    // NSCompoundPredicate
    // @"(name = %@) OR (title = %@)
    //NSArray *array = @[predicate, predicate];
    //NSPredicate *predicate1 = [NSCompoundPredicate andPredicateWithSubpredicates:array];
    //NSLog(@"compound predicate %@", predicate1);
    
    //    NSFetchRequest *advancedRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    //    [advancedRequest setResultType:NSDictionaryResultType];
    //    [advancedRequest setPropertiesToFetch:@[@"name", expresion, etc]];
    
    // execute fetch
    
    
    // NSManagedObjectContext is not thread safe, use this method to perform actions with managedobjectcontext
    //    [self.context performBlock:^{
    //        // do whatever with the context
    //    }];
    
}



- (void) save
{
    NSError *error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Can't Save! %@ %@", error, [error localizedDescription]);
    }
    
}




@end
