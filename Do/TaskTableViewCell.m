//
//  TaskTableViewCell.m
//  Do
//
//  Created by Franco Noack on 14/09/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "TaskTableViewCell.h"

@implementation TaskTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *bundleArray = [[NSBundle mainBundle] loadNibNamed:@"TaskTableViewCell" owner:self options:nil];
        self = [bundleArray objectAtIndex:0];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
