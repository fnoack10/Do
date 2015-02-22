//
//  TaskTableViewCell.h
//  Do
//
//  Created by Franco Noack on 14/09/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *deadlineView;
@property (weak, nonatomic) IBOutlet UILabel *daysLabel;
@property (weak, nonatomic) IBOutlet UILabel *monthsLabel;

@property (weak, nonatomic) IBOutlet UILabel *taskLabel;

@property (weak, nonatomic) IBOutlet UIView *priorityView;
@property (weak, nonatomic) IBOutlet UIView *priorityValue;

@end
