//
//  ActionTableViewCell.h
//  Do
//
//  Created by Franco Noack on 09/12/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionTableViewCell : UITableViewCell

@property (assign, nonatomic) NSInteger priority;

// Priority Values
@property (weak, nonatomic) IBOutlet UIView *priority0;
@property (weak, nonatomic) IBOutlet UIView *priority1;
@property (weak, nonatomic) IBOutlet UIView *priority2;
@property (weak, nonatomic) IBOutlet UIView *priority3;
@property (weak, nonatomic) IBOutlet UIView *priority4;

// Priority Buttons
@property (weak, nonatomic) IBOutlet UIButton *priorityButton0;
@property (weak, nonatomic) IBOutlet UIButton *priorityButton1;
@property (weak, nonatomic) IBOutlet UIButton *priorityButton2;
@property (weak, nonatomic) IBOutlet UIButton *priorityButton3;
@property (weak, nonatomic) IBOutlet UIButton *priorityButton4;

// Priority Selector
@property (weak, nonatomic) IBOutlet UIView *prioritySelector;
@property (weak, nonatomic) IBOutlet UIView *prioritySelectorForground;

// Priority Description
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;

- (IBAction)definePriorityAction:(UIButton *)sender;

@end
