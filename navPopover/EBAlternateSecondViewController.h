//
//  EBAlternateSecondViewController.h
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EBAlternateSecondViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate> {
    CGSize popoverContentSize;
}
@property (nonatomic, assign) CGSize popoverContentSize;

@end
