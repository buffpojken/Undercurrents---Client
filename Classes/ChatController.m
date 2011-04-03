    //
//  ChatController.m
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatController.h"


@implementation ChatController

@synthesize chat; 

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
	self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 307, 1024)];
	self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:24/255.0 blue:23/255.0 alpha:1.0];
	[self addToolbar];
	[self addChatList];
}

-(void)addToolbar{
	UIToolbar *tool_bar		= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 306, 44)];
	tool_bar.barStyle		= UIBarStyleBlackTranslucent;
	UILabel *label			= [[UILabel alloc] initWithFrame:CGRectMake(0,0,306, 44)];
	label.textAlignment		= UITextAlignmentCenter;
	label.backgroundColor	= [UIColor clearColor];
	label.textColor			= [UIColor whiteColor];
	label.text				= @"Chat";
	tool_bar.items			= [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:label], nil];
	[self.view addSubview:tool_bar];
}

-(void)addChatList{
	self.chat				= [[UITableView alloc] initWithFrame:CGRectMake(0, 45, 306, 910)];	
	[self.view addSubview:self.chat];
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/


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
