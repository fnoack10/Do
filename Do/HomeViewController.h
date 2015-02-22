//
//  HomeViewController.h
//  Do
//
//  Created by Franco Noack on 19/11/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Database Manager.h"
#import "ItemTemplate.h"

@protocol doProtocol

- (void) addItem: (NSDictionary *)itemTemplate;

@end

@interface HomeViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, doProtocol>

@property (weak, nonatomic) IBOutlet UIView *menuBarView;
@property (weak, nonatomic) IBOutlet UILabel *doTitleLabel;
@property (weak, nonatomic) IBOutlet UITableView *doTableView;

@property (strong, nonatomic) Database_Manager *databaseManager;

- (IBAction)listAction:(UIButton *)sender;
- (IBAction)calendarAction:(UIButton *)sender;
- (IBAction)addItemAction:(UIButton *)sender;

@end
