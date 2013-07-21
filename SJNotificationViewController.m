/*
 Copyright (c) 2013, Scott Jackson
 All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are permitted provided that the following conditions are met:
 
 Redistributions of source code must retain the above copyright notice, this list of conditions and the following disclaimer.
 Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the following disclaimer in the documentation and/or other materials provided with the distribution.
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "SJNotificationViewController.h"
#import <QuartzCore/QuartzCore.h>

#define SLIDE_DURATION 0.25f
#define LABEL_RESIZE_DURATION 0.1f
#define COLOR_FADE_DURATION 0.25f

#define ERROR_HEX_COLOR 0xff0000
#define MESSAGE_HEX_COLOR 0x0f5297
#define SUCCESS_HEX_COLOR 0x00ff00
#define NOTIFICATION_VIEW_OPACITY 0.85f

@implementation SJNotificationViewController

@synthesize parentView, notificationPosition;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
		showSpinner = NO;
		[self setNotificationLevel:SJNotificationLevelMessage];
    }
    return self;
}

- (id)initWithParentView:(UIView*)p title:(NSString*)t level:(SJNotificationLevel)l position:(SJNotificationPosition)pos spinner:(BOOL)sp {
    self = [super initWithNibName:@"SJNotificationViewController" bundle:nil];
    if (self) {
        [self setParentView:p];
        [self setNotificationTitle:t];
        [self setNotificationLevel:l];
        [self setNotificationPosition:pos];
        [self setShowSpinner:sp];
    }
    return self;
}

#pragma mark - Showing/Hiding the Notification

- (void)show {
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
	
	/* Attach to the parent view. */
	CGFloat yPosition;
	switch (notificationPosition) {
		case SJNotificationPositionTop:
			yPosition = self.view.frame.size.height * -1;
			break;
		case SJNotificationPositionBottom:
			yPosition = [parentView frame].size.height;
		default:
			break;
	}
	
	[self.view setFrame:CGRectMake(0, yPosition, self.view.frame.size.width, self.view.frame.size.height)];
	[parentView addSubview:self.view];
	
	[UIView animateWithDuration:SLIDE_DURATION
					 animations:^{
						 /* Slide the notification view into place. */
						 CGRect shownRect = CGRectMake(0,
													   [self yPositionWhenHidden:NO],
													   self.view.frame.size.width,
													   self.view.frame.size.height);
						 [self.view setFrame:shownRect];
					 }
	 ];
}

- (void)hide {
    if (!self.view.superview) {
        return;
    }
    
	[UIView animateWithDuration:SLIDE_DURATION
					 animations:^{
						 /* Slide the notification view out of place. */
						 [self.view setFrame:CGRectMake(0, [self yPositionWhenHidden:YES], self.view.frame.size.width, self.view.frame.size.height)];
					 }
					 completion:^(BOOL finished) {
						 [self.view removeFromSuperview];
					 }
     ];
}

#pragma mark - Calculating position
- (CGFloat)yPositionWhenHidden:(BOOL)hidden {
    CGFloat y;
    
    // when hidden
    if (hidden) {
        switch (notificationPosition) {
            case SJNotificationPositionTop:
                y = self.view.frame.size.height * -1;
                break;
                
            case SJNotificationPositionBottom:
            default:
                y = [parentView frame].size.height;
                break;
        }
        // when shown
    } else {
        switch (notificationPosition) {
            case SJNotificationPositionTop:
                y = 0;
                break;
                
            case SJNotificationPositionBottom:
            default:
                y = [parentView frame].size.height - self.view.frame.size.height;
                break;
        }
    }
    
    return y;
}

#pragma mark - Setting Notification Title

- (void)setNotificationTitle:(NSString *)t {
	notificationTitle = t;
	[label setText:t];
}

#pragma mark - Setting Tap Action

- (void)setTapTarget:(id)target selector:(SEL)selector {
	for (UIGestureRecognizer *r in [self.view gestureRecognizers]) {
		[self.view removeGestureRecognizer:r];
	}
	
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
	[self.view addGestureRecognizer:tap];
}

#pragma mark - Setting Notification Level

- (void)setNotificationLevel:(SJNotificationLevel)level {
	notificationLevel = level;
	
	UIColor *color;
	switch (notificationLevel) {
		case SJNotificationLevelError:
			color = [UIColor colorWithRed:((float)((ERROR_HEX_COLOR & 0xFF0000) >> 16))/255.0
									green:((float)((ERROR_HEX_COLOR & 0xFF00) >> 8))/255.0
									 blue:((float)(ERROR_HEX_COLOR & 0xFF))/255.0 alpha:NOTIFICATION_VIEW_OPACITY];
			break;
		case SJNotificationLevelMessage:
			color = [UIColor colorWithRed:((float)((MESSAGE_HEX_COLOR & 0xFF0000) >> 16))/255.0
                                    green:((float)((MESSAGE_HEX_COLOR & 0xFF00) >> 8))/255.0
                                     blue:((float)(MESSAGE_HEX_COLOR & 0xFF))/255.0 alpha:NOTIFICATION_VIEW_OPACITY];
			break;
		case SJNotificationLevelSuccess:
			color = [UIColor colorWithRed:((float)((SUCCESS_HEX_COLOR & 0xFF0000) >> 16))/255.0
									green:((float)((SUCCESS_HEX_COLOR & 0xFF00) >> 8))/255.0
									 blue:((float)(SUCCESS_HEX_COLOR & 0xFF))/255.0 alpha:NOTIFICATION_VIEW_OPACITY];
			break;
		default:
			break;
	}
	
	[UIView animateWithDuration:COLOR_FADE_DURATION
					 animations:^ {
						 [self.view setBackgroundColor:color];
					 }
     ];
}

#pragma mark - Spinner

- (void)setShowSpinner:(BOOL)b {
	showSpinner = b;
	if (showSpinner) {
		[spinner.layer setOpacity:1.0];
		[UIView animateWithDuration:LABEL_RESIZE_DURATION
						 animations:^{
							 [label setFrame:CGRectMake(44, label.frame.origin.y, 258, label.frame.size.height)];
						 }
						 completion:^(BOOL finished) {
							 [spinner startAnimating];
						 }
         ];
	} else {
		[spinner stopAnimating];
		[spinner.layer setOpacity:0.0];
		[UIView animateWithDuration:LABEL_RESIZE_DURATION
						 animations:^{
							 [label setFrame:CGRectMake(12, label.frame.origin.y, 290, label.frame.size.height)];
						 }
		 ];
	}
}

#pragma  mark - Hide

- (void)showFor:(NSInteger)seconds
{
    if (seconds > 0)
    {
        NSTimer *notificationTimer;
        notificationTimer = [NSTimer scheduledTimerWithTimeInterval:seconds target:self
                                                           selector:@selector(notificationTimerHide) userInfo:nil repeats:NO];
        [self show];
    }
    else
    {
        [self show];
    }
}

- (void)notificationTimerHide
{
    [self hide];
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
	
	/* By default, tapping the notification view hides it. */
	[self setTapTarget:self selector:@selector(hide)];
	
	if (showSpinner) {
		[self setShowSpinner:YES];
	} else {
		[self setShowSpinner:NO];
	}
	
	[label setText:notificationTitle];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
