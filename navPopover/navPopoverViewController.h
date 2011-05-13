//
//  navPopoverViewController.h
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface navPopoverViewController : UIViewController <UINavigationControllerDelegate> {
    
    UIButton *showPopoverButton;
}
@property (nonatomic, retain) IBOutlet UIButton *showPopoverButton;
- (IBAction)showNavPopover:(id)sender;

@end
