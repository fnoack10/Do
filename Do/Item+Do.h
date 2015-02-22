//
//  Item+Do.h
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "Item.h"

@interface Item (Do)

+ (Item *)item: (NSDictionary *)item inManagedObjectContext: (NSManagedObjectContext *) context;



@end
