    //
//  ChatController.m
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ChatController.h"
#import "ZTWebSocket.h"
#import "JSON.h"

@implementation ChatController

@synthesize chat, chat_archive, chat_socket, chat_field; 

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
	[self addChatField];
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
	self.chat.delegate		= self;
	self.chat.dataSource	= self;
	[self.view addSubview:self.chat];
}

-(void)addChatField{
	self.chat_field = [[UITextField alloc] initWithFrame:CGRectMake(0, 955, 306, 44)];
	self.chat_field.backgroundColor = [UIColor blueColor];
	self.chat_field.delegate = self;
	[self.view addSubview:self.chat_field];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
	[UIView beginAnimations:nil context:NULL];
		self.chat.frame = CGRectMake(0, 45, 306, 690);
		self.chat_field.frame = CGRectMake(0, 691, 306, 44);
	[UIView commitAnimations];
	
	return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {	
    [textField resignFirstResponder];	
	[UIView beginAnimations:nil context:NULL];
		self.chat.frame = CGRectMake(0, 45, 306, 910);
		self.chat_field.frame = CGRectMake(0, 955, 306, 44);
	[UIView commitAnimations];	
    return YES;	
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:textField.text, @"message", @"negerkungen", @"sender",nil];
	[self.chat_socket send:[dic JSONRepresentation]];
}


// UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
	return [self.chat_archive count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
	static NSString *identifier = @"MyIdentifier";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
	if(cell == nil){
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:identifier] autorelease];
	}
	cell.textLabel.text = [[self.chat_archive objectAtIndex:indexPath.row] objectForKey:@"message"];
//	[cell setText:[self.chat_archive objectAtIndex:indexPath.row]];
	return cell;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	self.chat_archive = [[NSMutableArray alloc] init];
	[self startChat];
}

-(void)startChat{
	 self.chat_socket = [[ZTWebSocket alloc] initWithURLString:@"ws://0.0.0.0:8080/ninja" delegate:self];
	[self.chat_socket open];
}

- (void)webSocket:(ZTWebSocket*)webSocket didReceiveMessage:(NSString*)message{
	NSDictionary *message2 = [[[SBJsonParser new] objectWithString:message] retain];
	[self.chat_archive addObject:message2];	
	[self.chat reloadData];
	[self.chat scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:[self.chat_archive count]-1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
}

- (void)webSocketDidOpen:(ZTWebSocket*)webSocket{
	
}

- (void)webSocket:(ZTWebSocket*)webSocket didFailWithError:(NSError*)error{

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
