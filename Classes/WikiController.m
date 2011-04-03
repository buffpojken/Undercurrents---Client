    //
//  WikiController.m
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "WikiController.h"
#import "WikiEdit.h"

@implementation WikiController

@synthesize wiki_view, tab_bar, current_wiki_id;
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
	UIBarButtonItem *reload	= [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"01-refresh.png"] style:UIBarButtonItemStyleBordered target:self action:@selector(reloadBtnPressed)];
	toolbar.items		= [NSArray arrayWithObjects:[[UIBarButtonItem alloc] initWithCustomView:label],[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil], reload,edit, nil];	
	[self.view addSubview: toolbar];
	[label release];
	[edit release];
	[reload release];
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

-(void)reloadBtnPressed{
	[wiki_view reload];
}


-(void)editBtnPressed{	
	WikiEdit *wiki_edit = [[WikiEdit alloc] init];
	wiki_edit.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
	wiki_edit.modalPresentationStyle = UIModalPresentationCurrentContext;
	wiki_edit.editing_wiki_id = self.current_wiki_id;
	[self presentModalViewController:wiki_edit animated:YES];
	wiki_edit.view.center = self.view.center;
}


- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
	if(item.tag == 1){
		self.current_wiki_id = 3;
		[wiki_view loadRequest:[NSURLRequest requestWithURL:[self constructWikiURL:3 action:@""]]];
	}else if(item.tag == 2){
		self.current_wiki_id = 4;
		[wiki_view loadRequest:[NSURLRequest requestWithURL:[self constructWikiURL:4 action:@""]]];
	}
}


-(void)dismissEditMode{
	[self.wiki_view reload];
	[self dismissModalViewControllerAnimated:YES];
	self.view.center = self.modalViewController.view.center;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.current_wiki_id = 3;
	[wiki_view loadRequest:[NSURLRequest requestWithURL:[self constructWikiURL:3 action:@""]]];
}


-(NSURL*)constructWikiURL:(int)wiki_id action:(NSString*)action{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];	
	if([action length] == 0){
		return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/wiki/%d",[prefs objectForKey:@"domain"] , wiki_id]];
	}else{
		return [NSURL URLWithString:[NSString stringWithFormat:@"http://%@/wiki/%d/%@", [prefs objectForKey:@"domain"], wiki_id, action]];
	}
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
