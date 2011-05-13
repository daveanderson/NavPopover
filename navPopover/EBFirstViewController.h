//
//  firstViewController.h
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EBFirstViewController : UIViewController <UITableViewDataSource>{
    NSArray *selectionList;
}
@property (nonatomic, retain) NSArray *selectionList;


- (id)initWithArray:(NSArray *)array;

@end
