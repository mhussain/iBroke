//
//  AboutController.m
//  iBroke
//
//  Created by Mujtaba Hussain on 31/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AboutController.h"

#import "AboutView.h"

@interface AboutController ()

@property (nonatomic, retain) UIView *aboutView;

@end

@implementation AboutController

@synthesize aboutView = _aboutView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self)
  {    
    [[self navigationItem] setHidesBackButton:YES animated:NO];
    [self setTitle:@"About"];
    
    UIButton *settings = [[UIButton alloc] initWithFrame:CGRectMake(0., 0., 35., 35.)];
    [settings setImage:[UIImage imageNamed:@"Settings"] forState:UIControlStateNormal];
    [settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    [settings setUserInteractionEnabled:YES];
    [settings setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settings];
    [[self navigationItem] setLeftBarButtonItem:settingsButton];
  }
  
  return self;
}

- (void)settings;
{
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
  [UIView setAnimationDuration:0.75];
  [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO];
  [UIView commitAnimations];
  
  [UIView beginAnimations:nil context:NULL];
  [UIView setAnimationDelay:0.375];
  [self.navigationController popViewControllerAnimated:NO];
  [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
  // Releases the view if it doesn't have a superview.
  [super didReceiveMemoryWarning];
}

#pragma mark - View lifecycle


// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView;
//{
//  _aboutView = [[AboutView alloc] initWithFrame:CGRectZero];
//  [self setView:_aboutView];
//}



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
  _aboutView = [[AboutView alloc] initWithFrame:CGRectZero];
  [self setView:_aboutView];

  [super viewDidLoad];
}


- (void)viewDidUnload;
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
