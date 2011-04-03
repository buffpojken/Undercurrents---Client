//
//  ChatController.h
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ChatController : UIViewController {
	UITableView *chat; 
}

@property (retain) UITableView *chat;

-(void)addToolbar;
-(void)addChatList;

@end
