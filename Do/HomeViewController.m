//
//  HomeViewController.m
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "HomeViewController.h"
#import "AddViewController.h"
#import "TaskTableViewCell.h"
#import "Item.h"

// Static Filters
typedef NS_ENUM(NSInteger, Filter) {
    ByDate,
    ByPriority
};

@interface HomeViewController ()
{
    NSMutableArray *itemsArray;
    NSInteger filter;
}

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Initialize Database
    self.databaseManager = [Database_Manager new];
    [self.databaseManager initializeDocumentAndContext];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"DatabaseReady" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshTableView) name:@"UpdateTableView" object:nil];
    
    filter = ByDate;
    
    [self.doTableView setDataSource:self];
    [self.doTableView setDelegate:self];
    
    [self prepareInterface];
    
}

- (void) prepareInterface
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Present Secondary Views

- (void) presentAddViewController {
    
    AddViewController *addViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddViewController"];
    addViewController.delegate = self;
    
    CGFloat height = addViewController.view.frame.size.height;
    CGFloat width = addViewController.view.frame.size.width;
    
    [addViewController.view setFrame:CGRectMake(0, -height, width, height)];
    
    [self addChildViewController:addViewController];
    [self.view addSubview:addViewController.view];
    [addViewController didMoveToParentViewController:self];
    
    [UIView animateWithDuration:0.4
                          delay:0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void){
                         [addViewController.view setCenter:self.view.center];
                     } completion:^(BOOL finished){
                        [addViewController.itemTextField becomeFirstResponder];
                     }];
    
}


#pragma mark - Do Table View Protocol

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier = @"TaskTableViewCell";
    
    TaskTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        cell = [[TaskTableViewCell alloc] init];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        [cell.priorityView.layer setCornerRadius:10.0f];
        [cell.priorityValue.layer setCornerRadius:7.0f];
    }
    
    Item *item = [itemsArray objectAtIndex:indexPath.row];
    
    cell.taskLabel.text = item.name;
    [cell.priorityValue setBackgroundColor:[self colorForPriority:item.estimation]];
    
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dayFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [dayFormatter setDateFormat:@"dd"];
    
    cell.daysLabel.text = [dayFormatter stringFromDate:item.creationDate];
    
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [monthFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"]];
    [monthFormatter setDateFormat:@"MMM"];
    
    cell.monthsLabel.text = [[monthFormatter stringFromDate:item.creationDate] uppercaseString];
    
    
    return cell;
}

- (UIColor *) colorForPriority:(NSNumber *)priority
{
    int value = [priority intValue];
    
    if (priority) {
        if (value == 0) {
            return [UIColor colorWithRed:(0/255.0) green:(128/255.0) blue:(255/255.0) alpha:1];
        } else if (value == 1){
            return [UIColor colorWithRed:(102/255.0) green:(102/255.0) blue:(255/255.0) alpha:1];
        } else if (value == 2){
            return [UIColor colorWithRed:(204/255.0) green:(102/255.0) blue:(255/255.0) alpha:1];
        } else if (value == 3){
            return [UIColor colorWithRed:(255/255.0) green:(111/255.0) blue:(207/255.0) alpha:1];
        } else if (value == 4){
            return [UIColor colorWithRed:(255/255.0) green:(102/255.0) blue:(102/255.0) alpha:1];
        } else {
            return [UIColor greenColor];
        }
    } else {
        return [UIColor whiteColor];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [itemsArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Item *item = [itemsArray objectAtIndex:indexPath.row];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [self.databaseManager.context deleteObject:item];
        [self refreshTableView];
    }
}

- (void) refreshTableView
{
    switch (filter) {
        case ByDate:
        {
            // TODO - Create appropriate fetch method
            itemsArray = [self.databaseManager fetchAllTasks];
            break;
        }
        case ByPriority:
        {
            itemsArray = [self.databaseManager fetchTasksByPriority];
            break;
        }
        default:
            break;
    }
    
    [self.doTableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
}


#pragma mark - Do Protocol


- (void) addItem: (NSDictionary *)itemTemplate
{
    [self.databaseManager addItem:itemTemplate];
}


#pragma mark - Do Controller Actions


- (IBAction)listAction:(UIButton *)sender {
    filter = ByDate;
    [self refreshTableView];
}

- (IBAction)calendarAction:(UIButton *)sender {
    filter = ByPriority;
    [self refreshTableView];
}

- (IBAction)addItemAction:(UIButton *)sender {
    [self presentAddViewController];
}

@end
