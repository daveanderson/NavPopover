//
//  EBAlternateSecondViewController.m
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import "EBAlternateSecondViewController.h"
#import "EBFirstViewController.h"

@implementation EBAlternateSecondViewController
@synthesize popoverContentSize;
@synthesize pickerView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin; // needed so view doesn't move around during navigationController push/pop animation

    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Alternate Second View";
    self.contentSizeForViewInPopover = self.view.frame.size; // sets initial size of popover, only applicable here (not later)
    self.popoverContentSize = self.view.frame.size; // used during navigationController:willShowViewController: to setPopoverContentSize:
    
    NSLog(@"AlternateSecondView viewDidLoad frame: %0.1f, %0.1f, %0.1f, %0.1f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

}

- (void)viewDidUnload
{
    [self setPickerView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //    self.contentSizeForViewInPopover = self.view.frame.size; // setting contentSizeForViewInPopover here is ineffective because the value stored in this property is only used the first time the view is shown.
    
    // in order to avoid having ugly black showing lower than the bottom of this view's table during the navigation controller's push/pop animation, set this view's height to the maximum height of the previous view in the navigation controller's stack
    // this would be performed if there was a priori knowledge that this is a short view
    // whether this is reasonable to be implemented or not depends on the content of this view and how it looks during the animation.  In this case it is a picker with a black background
    NSArray *viewControllers = self.navigationController.viewControllers;
    if (viewControllers.count > 1 && [viewControllers objectAtIndex:viewControllers.count-1] == self) { // has a previous controller

        CGRect maximumTableViewRect = self.pickerView.frame;
        EBFirstViewController *previousViewController = [viewControllers objectAtIndex:viewControllers.count-2];
        CGSize previousViewPopoverContentSize = previousViewController.popoverContentSize;
        
        if (maximumTableViewRect.size.height < previousViewPopoverContentSize.height) {
            maximumTableViewRect.size.height = previousViewPopoverContentSize.height + 37.0f; // not sure if the 37 point correction factor is needed here
        }
        self.pickerView.frame = maximumTableViewRect;  
    }
    
    NSLog(@"AlternateSecondView viewWillAppear frame: %0.1f, %0.1f, %0.1f, %0.1f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"AlternateSecondView viewDidAppear frame: %0.1f, %0.1f, %0.1f, %0.1f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
    // if this view is smaller than the previous view in the navigation controller stack
    // the frame of this view gets changed to match that of the previous view.
    // if the frame of this view is larger than the previous view in the navigation controller stack
    // the previous view's frame gets changed to match that of this view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return 100;
}

#pragma mark - UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%d", row];
}

@end
