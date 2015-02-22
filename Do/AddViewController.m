//
//  AddViewController.m
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "AddViewController.h"
#import "itemDetailTableViewCell.h"
#import "ActionTableViewCell.h"

@interface AddViewController ()
{
    UIButton *addButton;
    
    UIView *prioritySelectorView;
    UILabel *priorityDescription;
}

@end

#define CONTAINER_WIGTH 280
#define MARGINS 40.0
#define TEXTFIELD_MARGINS 16.0
#define ADDITEM_HEIGHT 66.0

@implementation AddViewController

#pragma mark - Initializing Add View Controller

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self initializeController];

}

- (void) initializeController
{
    [self.itemDetailsTableView setDelegate:self];
    [self.itemDetailsTableView setDataSource:self];
    [self.itemDetailsTableView setScrollEnabled:NO];
    
    [self.itemTextField setDelegate:self];
    [self.itemTextField addTarget:self action:@selector(updateTextFieldInput:) forControlEvents:UIControlEventEditingChanged];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void) viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self prepareInterface];
}

- (void) prepareInterface
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    UIColor *lightGray = [UIColor lightGrayColor];
    self.itemTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Add task"
                                                                               attributes:@{NSForegroundColorAttributeName: lightGray}];

    [self.containerView setClipsToBounds:YES];
    [self.containerView.layer setCornerRadius:6.0];
    [self.containerView setFrame:CGRectMake(0, 0, CONTAINER_WIGTH, (ADDITEM_HEIGHT*2)+50)];
    [self.containerView setCenter:CGPointMake(self.backgroundView.center.x, self.backgroundView.frame.size.height*0.3)];
    
    [self.itemDetailsTableView setFrame:CGRectMake(0,ADDITEM_HEIGHT, CONTAINER_WIGTH, self.containerView.frame.size.height-ADDITEM_HEIGHT)];
    [self.itemTextField setFrame:CGRectMake(8, 8, CONTAINER_WIGTH-TEXTFIELD_MARGINS, self.itemTextField.frame.size.height)];


    
    [self.timePickerContainer setFrame:CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 250)];
    
    // Hidde Time Picker
    
    self.timePickerContainer.alpha = 0;
    [self.timePickerContainer setFrame:CGRectMake(0, self.view.frame.size.height, self.timePickerContainer.frame.size.width, self.timePickerContainer.frame.size.height)];
}


#pragma mark - Dismiss Add View Controller

- (void) dismissAddItemController {

    [self willMoveToParentViewController:self.parentViewController];
    [self beginAppearanceTransition:NO animated:YES];
    
    [UIView animateWithDuration:0.5 animations:^(void){
        self.view.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self endAppearanceTransition];
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
    }];
    
}

#pragma mark - Do Table View Protocol

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        static NSString *cellIdentifier = @"ActionTableViewCell";
        
        ActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[ActionTableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsZero;
            
        }
        return cell;
        
    } else {
        static NSString *cellIdentifier = @"ItemTableViewCell";
        
        itemDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
        if (!cell) {
            cell = [[itemDetailTableViewCell alloc] init];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsZero;
            
            [cell.arrowButton addTarget:self action:@selector(updateDetails) forControlEvents:UIControlEventTouchUpInside];
            [cell.addButton addTarget:self action:@selector(addAction) forControlEvents:UIControlEventTouchUpInside];
            [cell.cancelButton addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
            
            addButton = cell.addButton;
            [addButton setEnabled:NO];
        }
        return cell;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return 70;
    } else {
        return 50;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark - Table View Actions


- (void) showTimePickerForDate:(BOOL)date
{
    [self.itemTextField resignFirstResponder];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         
                         if (date) {
                             [self.timePicker setDatePickerMode:UIDatePickerModeDateAndTime];
                             //[self.timePicker addTarget:self action:@selector(estimationSelected) forControlEvents:UIControlEventValueChanged];
                         } else {
                             [self.timePicker setDatePickerMode:UIDatePickerModeCountDownTimer];
                             //[self.timePicker addTarget:self action:@selector(estimationSelected) forControlEvents:UIControlEventValueChanged];
                         }
                         
                        self.timePickerContainer.alpha = 1;
                         
                         NSLog(@"PLACE");
                         [self.timePickerContainer setFrame:CGRectMake(0, self.view.frame.size.height-self.timePickerContainer.frame.size.height, self.timePickerContainer.frame.size.width, self.timePickerContainer.frame.size.height)];
                         
                         NSLog(@"y %f", self.view.frame.size.height-self.timePickerContainer.frame.size.height);
                         NSLog(@"screen hight %f", self.view.frame.size.height);
                         
                     } completion:^(BOOL finished){
                         
                     }];
}

- (void) hideDatePicker
{
    
    NSLog(@"hide");
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         self.timePickerContainer.alpha = 0;
                         [self.timePickerContainer setFrame:CGRectMake(0, self.view.frame.size.height, self.timePickerContainer.frame.size.width, self.timePickerContainer.frame.size.height)];
                     } completion:^(BOOL finished){
                         // completition
                     }];
    
    
}


- (void) addEstimation
{
    [self showTimePickerForDate:NO];
}

- (void) addAlert
{
    [self showTimePickerForDate:YES];
}

- (void) addDeadline
{
    [self showTimePickerForDate:YES];
}

- (void) updateDetails
{
    
}

- (void) addAction
{

    // Getting Priority Cell
    ActionTableViewCell *priorityCell = (ActionTableViewCell *)[self.itemDetailsTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];

    NSMutableDictionary *itemTemplate = [[NSMutableDictionary alloc] init];
    [itemTemplate setValue:@"" forKey:@"id"];
    [itemTemplate setValue:self.itemTextField.text forKey:@"name"];
    [itemTemplate setValue:[NSNumber numberWithInteger:priorityCell.priority] forKey:@"estimation"];
    
    [self.delegate addItem:itemTemplate];
    [self dismissAddItemController];

}

- (void) cancelAction
{
    [self dismissAddItemController];
}

#pragma mark - Text Field Protocol

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self hideDatePicker];
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

- (void) updateTextFieldInput: (UITextField *)textfield
{
    
    NSLog(@"text %@", textfield.text);
    
    if ([textfield.text isEqualToString:@""]) {
        [addButton setEnabled:NO];
    } else {
        [addButton setEnabled:YES];
    }
    
}


- (IBAction)closeTimePickerContainer:(UIButton *)sender {
    [self hideDatePicker];
}

@end
