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
}

-(void)setupToolbar;
-(void)setupTabs;
-(void)editBtnPressed;
-(void)setupWikiView; 

@property (retain) UIWebView *wiki_view;
@property (retain) UITabBar *tab_bar;

@end
