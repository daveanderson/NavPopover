# NavPopover

GarageBand for iOS makes stellar use of UIPopoverControllers.  Apple sets the bar high by dynamically resizing the UIPopoverControllers as you select items in a list and the navigation controller (within the UIPopoverController) pushes and pops additional view controllers.

NavPopover is a sample of techniques, methods and delegate implementations that allow you to make UIPopoverControllers as slick as GarageBand.  Its not a full re-creation of everything needed for *perfect* popovers, but enough of a breadcrumb to get there if you wish.

## Key Techniques
The fundamental methods and techniques used to make dynamically resizable popovers.

### Implement the `UINavigationControllerDelegate` methods 

* `- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated`
  
  Allows you to use `- (void)setPopoverContentSize:(CGSize)size animated:(BOOL)animated` to set the size the popover should become.

* `- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated`
  
  Unused in NavPopover but potentially handy
  
  
### Leverage `- (void)viewWillAppear:(BOOL)animated` 


`- (void)viewWillAppear:(BOOL)animated` can be used to make sure that the bottom of the current view is the same size as the maximum height of the UIPopover (otherwise there can be a black gap between the view and the frame of the UIPopover).

`- (void)viewDidAppear:(BOOL)animated`, `- (void)viewWillDisappear:(BOOL)animated`, and `- (void)viewDidDisappear:(BOOL)animated` can also be used to setup frame sizes for future transitions.

### Add a `popoverContentSize` property
`@property (nonatomic, assign) CGSize popoverContentSize;` is used to set the desired (final) visible popover size for each view controller that will appear in the UIPopover view controller.  

  e.g. The first view controller is tall while the second is short.  
  
  During the animation as the popover is resized from tall to short, the difference in height between the tall and short view controllers will appear as a black box at the bottom of the popover (it looks like a triangle during the animation because of the resizing).  
  
  To prevent the black gap from being visible the overall frame (background) of the second view controller should be the same height as the first view controller.  This means that there's no difference in height and thus no black gap.  However, we want the popover to rezise down to the short height of the second, so the final size of the popover is also needed and is provided in this sample via the `popoverContentSize` for each view controller.  



  