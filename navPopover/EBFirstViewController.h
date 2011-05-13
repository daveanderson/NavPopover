//
//  firstViewController.h
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EBFirstViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *selectionList;
    UITableView *tableView;
}
@property (nonatomic, retain) NSArray *selectionList;
@property (nonatomic, retain) IBOutlet UITableView *tableView;

- (id)initWithArray:(NSArray *)array;

@end
