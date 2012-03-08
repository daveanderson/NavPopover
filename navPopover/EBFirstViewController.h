//
//  firstViewController.h
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EBSecondViewController.h"
#import "EBAlternateSecondViewController.h"


@interface EBFirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *selectionList;
    UITableView *tableView;
    CGSize popoverContentSize;
    
    EBSecondViewController *secondViewController;
    EBAlternateSecondViewController *alternateSecondViewController;
}
@property (nonatomic) NSArray *selectionList;
@property (nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, assign) CGSize popoverContentSize;
@property (nonatomic) EBSecondViewController *secondViewController;
@property (nonatomic) EBAlternateSecondViewController *alternateSecondViewController;

- (id)initWithArray:(NSArray *)array;

@end
