//
//  EBSecondViewController.h
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EBSecondViewController : UIViewController <UITableViewDataSource> {
    NSArray *selectionList;
    CGSize popoverContentSize;
}
@property (nonatomic, retain) NSArray *selectionList;
@property (nonatomic, assign) CGSize popoverContentSize;

- (id)initWithArray:(NSArray *)array;

@end
