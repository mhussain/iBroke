////
////  EGORefreshTableHeaderView.m
////  Demo
////
////  Created by Devin Doty on 10/14/09October14.
////  Copyright 2009 enormego. All rights reserved.
////
////  Permission is hereby granted, free of charge, to any person obtaining a copy
////  of this software and associated documentation files (the "Software"), to deal
////  in the Software without restriction, including without limitation the rights
////  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
////  copies of the Software, and to permit persons to whom the Software is
////  furnished to do so, subject to the following conditions:
////
////  The above copyright notice and this permission notice shall be included in
////  all copies or substantial portions of the Software.
////
////  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
////  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
////  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
////  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
////  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
////  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
////  THE SOFTWARE.
////
//
//#import "EGORefreshTableHeaderView.h"
//
//#define FLIP_ANIMATION_DURATION 0.18
//
//@implementation UILabel (REA_EGO_Factory);
//
//+ (UILabel *)instanceForRefreshHeader:(SkinManager *)skin;
//{
//  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
//  [label setTextAlignment:UITextAlignmentCenter];
//  [label setShadowOffset:CGSizeMake(0., -1.)];
//  [label setTextColor: [skin colorNamed:@"text"]];
//  [label setShadowColor: [skin colorNamed:@"text-shadow"]];
//  [label setBackgroundColor: [skin colorNamed:@"dark-grey-texture"]];
//  
//  return [label autorelease];
//}
//@end
//
//
//@implementation EGORefreshTableHeaderView
//
//@synthesize delegate          = delegate_;
//@synthesize state             = state_;
//
//@synthesize lastUpdatedLabel  = lastUpdatedLabel_;
//@synthesize statusLabel       = statuslabel_;
//@synthesize arrowImage        = arrowImage_;
//@synthesize activityView      = activityView_;
//@dynamic stateThreshold;
//
//- (void)dealloc;
//{
//	delegate_ = nil;
//  RELEASE(lastUpdatedLabel_);
//  RELEASE(statuslabel_);
//  RELEASE(arrowImage_);
//  RELEASE(activityView_);
//  
//  [super dealloc];
//}
//
//
//#pragma mark - Properties
//
//- (void)setDelegate:(id<EGORefreshTableHeaderDelegate>)delegate;
//{
//  delegate_ = delegate;
//  
//  [self refreshLastUpdatedDate];
//  
//  Assert([[self delegate] respondsToSelector:@selector(egoRefreshTableHeaderDataSourceIsLoading:)]);
//
//  [self setState:[[self delegate] egoRefreshTableHeaderDataSourceIsLoading:self] ? EGOOPullRefreshLoading : EGOOPullRefreshNormal];
//}
//
//- (void)setState:(EGOPullRefreshState)state;
//{	
//	switch (state)
//  {
//		case EGOOPullRefreshPulling:
//			
//			[[self statusLabel] setText: NSLocalizedString(@"Release to update", @"Release to update status")];
//      [[self statusLabel] sizeToFit];
//
//			[CATransaction begin];
//			[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
//			[[self arrowImage] setTransform: CATransform3DMakeRotation(M_PI, 0., 0., 1.)];
//			[CATransaction commit];
//      
//			break;
//		case EGOOPullRefreshNormal:
//			
//			if ([self state] == EGOOPullRefreshPulling)
//      {
//				[CATransaction begin];
//				[CATransaction setAnimationDuration:FLIP_ANIMATION_DURATION];
//				[[self arrowImage] setTransform: CATransform3DIdentity];
//				[CATransaction commit];
//			}
//			
//			[[self statusLabel] setText: NSLocalizedString(@"Pull to update", @"Pull to update status")];
//      [[self statusLabel] sizeToFit];
//      
//			[[self activityView] stopAnimating];
//      
//			[CATransaction begin];
//			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
//			[[self arrowImage] setHidden: NO];
//			[[self arrowImage] setTransform: CATransform3DIdentity];
//			[CATransaction commit];
//			
//			[self refreshLastUpdatedDate];
//      
//			break;
//		case EGOOPullRefreshLoading:
//			
//			[[self statusLabel] setText: NSLocalizedString(@"Loading\u2026", @"Loading Status")];
//      [[self statusLabel] sizeToFit];
//      
//			[[self activityView] startAnimating];
//      
//			[CATransaction begin];
//			[CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions]; 
//			[[self arrowImage] setHidden: YES];
//			[CATransaction commit];
//			
//			break;
//	}
//	
//	state_ = state;
//}
//
//#pragma mark - UIView
//
//-(void)layoutSubviews;
//{
//}
//
//#pragma mark - 
//
//- (void)refreshLastUpdatedDate;
//{
//  [[self lastUpdatedLabel] setText:nil];
//  
//	if ([[self delegate] respondsToSelector:@selector(egoRefreshTableHeaderDataSourceLastUpdated:)])
//  {
//		NSDate *date = [delegate_ egoRefreshTableHeaderDataSourceLastUpdated:self];
//    
//		if (![date isEqualToDate:[NSDate distantPast]])
//    {
//      NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//      
//      [formatter setLocale:[NSLocale currentLocale]];
//      [formatter setDateStyle:NSDateFormatterShortStyle];
//      [formatter setTimeStyle:NSDateFormatterShortStyle];
//      
//      [[self lastUpdatedLabel] setText: [NSString stringWithFormat:NSLocalizedString(@"Last updated %1$@",@"Last Updated string and format"), [formatter stringFromDate:date]]];
//      [[self lastUpdatedLabel] sizeToFit];
//      
//      [[NSUserDefaults standardUserDefaults] setObject:[[self lastUpdatedLabel] text] forKey:@"EGORefreshTableView_LastRefresh"];
//      [[NSUserDefaults standardUserDefaults] synchronize];
//      
//      [formatter release];
//    }
//	}
//}
//
//#pragma mark - EGORefreshTableHeaderView
//
//- (BOOL)extentLessThanThreshold:(UIScrollView *)scrollView;
//{
//  return ([scrollView contentOffset].x < -[self stateThreshold]) || ([scrollView contentOffset].y < -[self stateThreshold]);
//}
//
//- (BOOL)extentGreaterThanThreshold:(UIScrollView *)scrollView;
//{
//    
//  return (([scrollView contentOffset].y > -[self stateThreshold] && [scrollView contentOffset].y < 0.) || ([scrollView contentOffset].x > -[self stateThreshold] && [scrollView contentOffset].x < 0.));
//}
//
//- (void)egoRefreshScrollViewDidScroll:(UIScrollView *)scrollView;
//{	
//  if (![scrollView isDragging] || [[self delegate] performSelectorSafely:@selector(egoRefreshTableHeaderDataSourceIsLoading:) withObject:self]) return;
//  
//  if (([self state] == EGOOPullRefreshPulling) && [self extentGreaterThanThreshold:scrollView])
//  {
//    [self setState:EGOOPullRefreshNormal];
//  }
//  else if (([self state] == EGOOPullRefreshNormal) && [self extentLessThanThreshold:scrollView])
//  {
//    [self setState:EGOOPullRefreshPulling];
//  }  
//}
//
//- (void)egoRefreshScrollViewDidEndDragging:(UIScrollView *)scrollView;
//{
//  if ([[self delegate] performSelectorSafely:@selector(egoRefreshTableHeaderDataSourceIsLoading:) withObject:self]) return;
//  	
//	if ([self extentLessThanThreshold:scrollView])
//  {
//    [self setState:EGOOPullRefreshLoading];
//		[[self delegate] performSelectorSafely:@selector(egoRefreshTableHeaderDidTriggerRefresh:) withObject:self];
//	}
//}
//
//- (void)egoRefreshScrollViewDataSourceDidFinishedLoading:(UIScrollView *)scrollView;
//{
//	[self setState:EGOOPullRefreshNormal];
//}
//
//@end
