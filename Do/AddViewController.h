//
//  AddViewController.h
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeViewController.h"

@interface AddViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>

@property (strong, nonatomic) id<doProtocol> delegate;

@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *containerView;
@property (weak, nonatomic) IBOutlet UITextField *itemTextField;
@property (weak, nonatomic) IBOutlet UITableView *itemDetailsTableView;
@property (weak, nonatomic) IBOutlet UIView *timePickerContainer;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;

- (IBAction)closeTimePickerContainer:(UIButton *)sender;

@end
