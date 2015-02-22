//
//  List+Do.h
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "List.h"

@interface List (Do)

+ (List *)listWithDictionary: (NSDictionary *)listDictionary inManagedObjectContext: (NSManagedObjectContext *) context;

@end
