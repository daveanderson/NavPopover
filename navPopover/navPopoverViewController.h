//
//  navPopoverViewController.h
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface navPopoverViewController : UIViewController <UINavigationControllerDelegate, UIPopoverControllerDelegate> {
    
    UIButton *showPopoverButton;
    UIPopoverController *popoverController;
}
@property (nonatomic, retain) IBOutlet UIButton *showPopoverButton;
@property (nonatomic, retain) IBOutlet UIPopoverController *popoverController;

- (IBAction)showNavPopover:(id)sender;

@end
