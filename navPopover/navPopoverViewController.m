//
//  navPopoverViewController.m
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import "navPopoverViewController.h"

#import "EBFirstViewController.h"

@implementation navPopoverViewController
@synthesize showPopoverButton;

- (void)dealloc
{
    [showPopoverButton release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

- (void)viewDidUnload
{
    [self setShowPopoverButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (IBAction)showNavPopover:(id)sender {
    
    // init first view controller
    EBFirstViewController *firstViewController = [[EBFirstViewController alloc] initWithArray:[NSArray arrayWithObjects:@"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", @"One", @"Two", @"Three", @"Four", @"Five", @"Six", @"Seven", @"Eight", @"Nine", @"Ten", nil]];
    
    // stick it in a navigation controller
    UINavigationController *navigationController = [[[UINavigationController alloc] initWithRootViewController:firstViewController] autorelease];
    navigationController.delegate = self;
    // show the navigation controller in a popover
    UIPopoverController *popoverController = [[UIPopoverController alloc] initWithContentViewController:navigationController];
    popoverController.delegate = self;
    
    [popoverController presentPopoverFromRect:self.showPopoverButton.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];


}

#pragma mark - UINavigationControllerDelegate

// adjusts popover size during navigationController animation
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
}


@end
