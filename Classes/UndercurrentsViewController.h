//
//  UndercurrentsViewController.h
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiController.h"
#import "ChatController.h"

@interface UndercurrentsViewController : UIViewController {
	
	WikiController *wiki_controller;
	ChatController *chat_controller;
}

@property (retain) WikiController *wiki_controller;
@property (retain) ChatController *chat_controller;

@end

