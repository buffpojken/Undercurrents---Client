//
//  WikiController.h
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WikiController : UIViewController<UITabBarDelegate>{
	UIWebView *wiki_view;
	UITabBar *tab_bar;
	int current_wiki_id;
}

-(void)setupToolbar;
-(void)setupTabs;

// Action Responder
-(void)editBtnPressed;
-(void)reloadBtnPressed;


-(void)setupWikiView; 
-(NSURL*)constructWikiURL:(int)wiki_id action:(NSString*)action;
-(void)dismissEditMode; 


@property (retain) UIWebView *wiki_view;
@property (retain) UITabBar *tab_bar;
@property int current_wiki_id;

@end
