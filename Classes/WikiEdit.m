    //
//  WikiEdit.m
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WikiEdit.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

@implementation WikiEdit

@synthesize editing_wiki_id, edit;

 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 470, 1024)];
	self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:24/255.0 blue:23/255.0 alpha:1.0];	
	[self addToolbar];
	[self addEditGui];
}

-(void)addToolbar{
	UIToolbar *toolbar		= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 460, 44)];
	toolbar.barStyle		= UIBarStyleBlackTranslucent;
	UILabel *label			= [[UILabel alloc] initWithFrame:CGRectMake(0,0,200, 44)];
	label.backgroundColor	= [UIColor clearColor];
	label.textColor			= [UIColor whiteColor];
	label.textAlignment		= UITextAlignmentCenter;
	label.text				= @"Edit Wiki";
	UIBarButtonItem *save	= [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveEdit)];	
	UIBarButtonItem *cancel	= [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelEdit)];
	toolbar.items		= [NSArray arrayWithObjects:
						   cancel,
						   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], 
						   [[UIBarButtonItem alloc] initWithCustomView:label],
						   [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], 
						   save,
						   nil];	
	[self.view addSubview: toolbar];
	[label release];
	[toolbar release];
}

-(void)addEditGui{
	self.edit = [[UITextView alloc] initWithFrame:CGRectMake(0, 44, 460, 900)];
	self.edit.editable = YES;
	self.edit.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:24/255 blue:23/255 alpha:1.0];
	self.edit.autocorrectionType = UITextAutocorrectionTypeNo;	
	self.edit.textColor = [UIColor whiteColor];
	[self.view addSubview:self.edit];
}


//	Action Responders

-(void)cancelEdit{
	[self.parentViewController dismissModalViewControllerAnimated:YES];
	self.parentViewController.view.center = self.view.center;
}

-(void)saveEdit{
	NSURL *url = [self.parentViewController constructWikiURL:self.editing_wiki_id action:@""];
	ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:url];
	[req setPostValue:self.edit.text forKey:@"article[body]"];
	[req setRequestMethod:@"PUT"];
	[req setDelegate:self];
	req.userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"saveUpdate", @"method", nil];
	[req startAsynchronous];
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSURL *url = [self.parentViewController constructWikiURL:self.editing_wiki_id action:@"edit_text"];
	ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:url];
	req.userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:@"fetchEdit", @"method", nil];
	[req setDelegate:self];	
	[req startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest*)req{
	NSString *method = [req.userInfo objectForKey:@"method"];
	if([method isEqualToString:@"fetchEdit"]){
		self.edit.text = [req responseString];			
	}else if([method isEqualToString:@"saveUpdate"]){
		[self.parentViewController dismissEditMode];
	}
	[method release];
}


- (void)requestFailed: (ASIHTTPRequest*)req{
	NSString *method = [req.userInfo objectForKey:@"method"];
	if([method isEqualToString:@"fetchEdit"]){
		NSLog(@"req failed");
		UIAlertView *error = [[UIAlertView alloc] initWithTitle:@"Request Failed" message:@"Failed to load wiki content for editing" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:nil];
		[error show];
		[error release];		
	}else if([method isEqualToString:@"saveUpdate"]){
		NSLog(@"Could nto save update...");
	}
	[method release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
	[self cancelEdit];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Overriden to allow any orientation.
    return YES;
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
