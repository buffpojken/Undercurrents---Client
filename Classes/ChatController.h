//
//  ChatController.h
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZTWebSocket.h"

@interface ChatController : UIViewController<ZTWebSocketDelegate, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate> {
	UITableView *chat; 
	NSMutableArray *chat_archive;
	ZTWebSocket *chat_socket;
	UITextField *chat_field;
}

@property (retain) UITableView *chat;
@property (retain) NSMutableArray *chat_archive;
@property (retain) ZTWebSocket *chat_socket;
@property (retain) UITextField *chat_field;

-(void)addToolbar;
-(void)addChatList;
-(void)startChat;
-(void)addChatField;

@end
