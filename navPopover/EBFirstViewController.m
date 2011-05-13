//
//  firstViewController.m
//  navPopover
//
//  Created by David Anderson on 5/12/11.
//  Copyright 2011 ElectroBarn Inc. All rights reserved.
//

#import "EBFirstViewController.h"
#import "EBSecondViewController.h"
#import "EBAlternateSecondViewController.h"


@implementation EBFirstViewController
@synthesize selectionList;
@synthesize tableView;
@synthesize popoverContentSize;
@synthesize secondViewController;
@synthesize alternateSecondViewController;

- (id)initWithArray:(NSArray *)array {
    self = [super init]; // calls [self initWithNibName:nil bundle:nil];
    if (self) {
        self.selectionList = array;
        self.view.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleBottomMargin; // needed so view doesn't move around during navigationController push/pop animation
        // if pin to bottom (flexible top) then when the popover resizes taller, there is a black gap at the top.

    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]; // looks for nib with name matching the name of this class
    if (self) {
        // Custom initialization
//        self.view.autoresizesSubviews = NO;

    }
    return self;
}

- (void)dealloc
{
    [tableView release];
    [selectionList release];
    [secondViewController release];
    [alternateSecondViewController release];
    [super dealloc];
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
    self.title = @"First View";
    
    // if the view.frame.size is more than 2X as tall as a later view pushed to the 
    // navigation controller, then when the popover resizes to the smaller view, the popover arrow will move
    // up from being centered on the rect from which the popover is displayed (at least when the popover
    // arrow direction is right or left
    // so load up the next views and use their heights to determine our maximum height
    secondViewController = [[EBSecondViewController alloc] initWithArray:[NSArray arrayWithObjects:@"A", @"B", @"C", @"D", @"E", nil]];
    alternateSecondViewController = [[EBAlternateSecondViewController alloc] init];
    
    // the 4.0f correction factor is needed to ensure the popover arrow doesn't move
    CGRect maximumRect = self.view.frame;
    if (maximumRect.size.height > self.secondViewController.popoverContentSize.height * 2.0f - 4.0f) {
        maximumRect.size.height = self.secondViewController.popoverContentSize.height * 2.0f - 4.0f;
    }
    if (maximumRect.size.height > self.alternateSecondViewController.popoverContentSize.height * 2.0f - 4.0f) {
        maximumRect.size.height = self.alternateSecondViewController.popoverContentSize.height * 2.0f - 4.0f;
    }
    self.view.frame = maximumRect;
    self.contentSizeForViewInPopover = maximumRect.size; // sets initial size of popover
    self.popoverContentSize = maximumRect.size; // used during navigationController:willShowViewController: to setPopoverContentSize:

    // using the tableView frame (or the view frame) size works well if the size of the tableView frame 
    // (or its parent view frame) is fixed in size.
    // as soon as the animation happens when pushed to the second view controller, the size 
    // of this view is therafter changed.
    
    NSLog(@"FirstView viewDidLoad frame: %0.1f, %0.1f, %0.1f, %0.1f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);

}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.contentSizeForViewInPopover = self.view.frame.size; // setting contentSizeForViewInPopover here is ineffective because the value stored in this property is only used the first time the view is shown.
    
    // in order to avoid having ugly black showing lower than the bottom of this view's table during the navigation controller's push/pop animation, set this view's table height to the maximum height of the next view in the navigation controller's stack
    CGRect maximumTableViewRect = self.tableView.frame;
    if (maximumTableViewRect.size.height < self.secondViewController.popoverContentSize.height) {
        maximumTableViewRect.size.height = self.secondViewController.popoverContentSize.height + 37.0f;
    }
    if (maximumTableViewRect.size.height < self.alternateSecondViewController.popoverContentSize.height) {
        maximumTableViewRect.size.height = self.alternateSecondViewController.popoverContentSize.height + 37.0f;
    }
    self.tableView.frame = maximumTableViewRect;

    
    NSLog(@"FirstView viewWillAppear frame: %0.1f, %0.1f, %0.1f, %0.1f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSLog(@"FirstView viewDidAppear frame: %0.1f, %0.1f, %0.1f, %0.1f", self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, self.view.frame.size.height);
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)targetTableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"FirstViewCell";

    UITableViewCell *cell = [targetTableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:cellIdentifier] autorelease];
    }
    cell.textLabel.text = [self.selectionList objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.selectionList count];
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // when push to the nextViewController, this view's frame size is adjusted to the size of the nextViewController
    // view size.
    // if the second view has the same frame as the first view, everything looks great.
    // if the second view has a frame smaller than that of the first view, the second view's frame
    // is adjusted to the size of the first view
    
    if (indexPath.row % 2 == 0) {
        [self.navigationController pushViewController:secondViewController animated:YES];
    } else {
        [self.navigationController pushViewController:alternateSecondViewController animated:YES];
    }
    
}

@end
