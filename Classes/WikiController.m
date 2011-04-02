    //
//  WikiController.m
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WikiController.h"


@implementation WikiController

@synthesize wiki_view, tab_bar;
/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
    }
    return self
}
*/

// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	self.view = [[UIView alloc] initWithFrame:CGRectMake(308, 0, 470, 1024)];
	self.view.backgroundColor = [UIColor colorWithRed:26.0/255.0 green:24/255.0 blue:23/255.0 alpha:1.0];
	[self setupToolbar];
	[self setupWikiView];
	[self setupTabs];
}

-(void)setupToolbar{
	UIToolbar *toolbar		= [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 460, 44)];
	toolbar.barStyle		= UIBarStyleBlackTranslucent;
	UILabel *label			= [[UILabel alloc] initWithFrame:CGRectMake(0,0,200, 44)];
	label.backgroundColor	= [UIColor clearColor];
	label.textColor			= [UIColor whiteColor];
	label.text				= @"Wiki";
	UIBarButtonItem *edit	= [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStyleBordered target:self action:@selector(editBtnPressed)];	
	toolbar.items		= [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:label],[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], edit, nil];	
	[self.view addSubview: toolbar];
	[label release];
	[toolbar release];
}

-(void)setupWikiView{
	wiki_view = [[UIWebView alloc] initWithFrame:CGRectMake(0, 44, 460, 916)];
	wiki_view.backgroundColor = [UIColor blueColor];
	[self.view addSubview:wiki_view];
	[wiki_view release];
}

-(void)setupTabs{
	tab_bar = [[UITabBar alloc] initWithFrame:CGRectMake(0, 955, 460, 49)];
	tab_bar.backgroundColor = [UIColor redColor];
	tab_bar.items = [NSArray arrayWithObjects:
					 [[UITabBarItem alloc] initWithTitle:@"Character" image:[UIImage imageNamed:@"111-user.png"] tag:1], 
					 [[UITabBarItem alloc] initWithTitle:@"Wiki" image:[UIImage imageNamed:@"96-book.png"] tag:2],nil];
	tab_bar.selectedItem = [tab_bar.items objectAtIndex:0];
	tab_bar.delegate = self;
	[self.view addSubview:tab_bar];
}

//	Action responders

-(void)editBtnPressed{
	NSLog(@"Edit btn pressed...");
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
	if(item.tag == 1){
		[wiki_view loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://google.com"]]];
	}else if(item.tag == 2){
		[wiki_view loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://tt.se"]]];
	}
}




// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[wiki_view loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://google.com"]]];
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
