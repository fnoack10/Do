//
//  ActionTableViewCell.m
//  Do
//
//  Created by Franco Noack on 09/12/14.
//  Copyright (c) 2014 Franco Noack. All rights reserved.
//

#import "ActionTableViewCell.h"

@implementation ActionTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSArray *bundleArray = [[NSBundle mainBundle] loadNibNamed:@"ActionTableViewCell" owner:self options:nil];
        self = [bundleArray objectAtIndex:0];
        
        [self initialize];
    }
    return self;
}

- (void)initialize
{
    self.priority = 0;
    
    [self.priority0.layer setCornerRadius:10.0f];
    [self.priority1.layer setCornerRadius:10.0f];
    [self.priority2.layer setCornerRadius:10.0f];
    [self.priority3.layer setCornerRadius:10.0f];
    [self.priority4.layer setCornerRadius:10.0f];
    
    [self.prioritySelector.layer setCornerRadius:20.0f];
    [self.prioritySelectorForground.layer setCornerRadius:18.0f];
    
    [self.prioritySelector setCenter:self.priority4.center];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)definePriorityAction:(UIButton *)sender {
    
    [UIView animateWithDuration:0.5 animations:^(void){
        [self.prioritySelector setCenter:sender.center];
    } completion:^(BOOL finished) {
        self.priority = sender.tag;
    }];

    
//    int value = (int)sender.tag;
//    
//    if (value == 0) {
//        self.priorityLabel.text =  @"To backlog";
//    } else if (value == 1){
//        self.priorityLabel.text = @"No biggy";
//    } else if (value == 2){
//        self.priorityLabel.text = @"I'll do it sometime this week";
//    } else if (value == 3){
//        self.priorityLabel.text = @"Need to do this Today";
//    } else if (value == 4){
//        self.priorityLabel.text = @"Had to do it yesterday!";
//    } else {
//        self.priorityLabel.text = @"Something went horribly wrong!";
//    }
    


}
@end
