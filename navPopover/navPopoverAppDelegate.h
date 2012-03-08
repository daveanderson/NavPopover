//
//  navPopoverAppDelegate.h
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class navPopoverViewController;

@interface navPopoverAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic) IBOutlet UIWindow *window;

@property (nonatomic) IBOutlet navPopoverViewController *viewController;

@end
