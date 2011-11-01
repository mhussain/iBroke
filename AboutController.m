//
//  AboutController.m
//  iBroke
//
//  Created by Mujtaba Hussain on 31/10/11.

// This code is distributed under the terms and conditions of the MIT license. 
//
// Copyright (c) 2011 Mujtaba Hussain
//
// Permission is hereby granted, free of charge, to any person obtaining a copy 
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights 
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is 
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE 
//
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING 
// FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS 
// IN THE SOFTWARE.

#import "AboutController.h"

#import "AboutView.h"

#import "NotificationView.h"

@interface AboutController ()

@property (nonatomic, retain) UIView *aboutView;

- (void)emailDeveloper;

@end

@implementation AboutController

@synthesize aboutView = _aboutView;

static NSString *kCantSendEmail = @"Please configure email via settings.";

static NSString *kEmailSent = @"Your email has been sent";
static NSString *kEmailSaved = @"Your email has been saved";
static NSString *kEmailCancelled = @"Your email has been cancelled";
static NSString *kEmailFailed = @"Your email could not be sent";

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil;
{
  self = [super initWithNibName:nil bundle:nil];
  
  if (self)
  {
    [[self navigationItem] setHidesBackButton:YES animated:NO];
    [[self navigationItem] setTitleView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"about_title"]]];
    
    UIButton *settings = [[UIButton alloc] initWithFrame:CGRectMake(0., 0., 35., 35.)];
    [settings setImage:[UIImage imageNamed:@"Settings"] forState:UIControlStateNormal];
    [settings addTarget:self action:@selector(settings) forControlEvents:UIControlEventTouchUpInside];
    [settings setUserInteractionEnabled:YES];
    [settings setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *settingsButton = [[UIBarButtonItem alloc] initWithCustomView:settings];
    [[self navigationItem] setLeftBarButtonItem:settingsButton];
    
    UIButton *email = [[UIButton alloc] initWithFrame:CGRectMake(0., 0., 30., 19.)];
    [email setImage:[UIImage imageNamed:@"Email"] forState:UIControlStateNormal];
    [email addTarget:self action:@selector(emailDeveloper) forControlEvents:UIControlEventTouchUpInside];
    [email setUserInteractionEnabled:YES];
    [email setShowsTouchWhenHighlighted:YES];
    
    [[self navigationItem] setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:email]];

  }
  
  return self;
}

#pragma mark - UIBarButtonSelectors

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

- (void)emailDeveloper;
{

  if ([MFMailComposeViewController canSendMail])
  {
    MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
    [controller setMailComposeDelegate:self];
    [controller setSubject:@"iBroke"];
    [controller setModalPresentationStyle:UIModalPresentationFormSheet];
    [controller setMessageBody:@"" isHTML:NO]; 
    [controller setToRecipients:[NSArray arrayWithObject:@"info@ibroke.mujtabahussain.net"]];
    [controller setWantsFullScreenLayout:NO];
    
    if (controller)
    {
      [[self navigationController] presentModalViewController:controller animated:YES];
    }
  }
  else
  {
     NotificationView *cantSendEmail = [[NotificationView alloc] initWithFrame:CGRectZero
                                                                    andMessage:kCantSendEmail
                                                                       andType:kErrorNotification];
     [cantSendEmail setNeedsLayout];
     [[self view] addSubview:cantSendEmail];
    
     [UIView animateWithDuration:3.0
        animations: ^ {
          [cantSendEmail setAlpha:0.0];
        }
        completion: ^ (BOOL completed) {
          [cantSendEmail removeFromSuperview];
        }
     ];
  }
}

#pragma mark - Mail
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error;
{
  [controller dismissModalViewControllerAnimated:YES];
  
  NSString *message = @"";
  NotificationType type = kSuccessNotification;
  if (result == MFMailComposeResultCancelled)
  {
    message = [message stringByAppendingFormat:@"%@", kEmailCancelled];
  }
  else if (result == MFMailComposeResultSaved)
  {
    message = [message stringByAppendingFormat:@"%@", kEmailSaved];
  }
  else if (result == MFMailComposeResultSent)
  {
    message = [message stringByAppendingFormat:@"%@", kEmailSent];
  }
  else
  {
    message = [message stringByAppendingFormat:@"%@", kEmailFailed];
    type = kErrorNotification;
  }

  NotificationView *sentEmail = [[NotificationView alloc] initWithFrame:CGRectZero
                                                             andMessage:message
                                                                andType:type];
  [sentEmail setNeedsLayout];
  [[self view] addSubview:sentEmail];

  [UIView animateWithDuration:3.0
     animations: ^ {
       [sentEmail setAlpha:0.0];
     }
     completion: ^ (BOOL completed) {
       [sentEmail removeFromSuperview];
     }
   ];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

#pragma mark - ViewLifecycle

// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView;
//{
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
  return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
