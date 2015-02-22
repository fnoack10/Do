//
//  itemDetailTableViewCell.m
//  Do
//
//  Created by Franco Noack on 21/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "itemDetailTableViewCell.h"

@implementation itemDetailTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *bundleArray = [[NSBundle mainBundle] loadNibNamed:@"itemDetailTableViewCell" owner:self options:nil];
        self = [bundleArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
