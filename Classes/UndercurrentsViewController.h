//
//  UndercurrentsViewController.h
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WikiController.h"

@interface UndercurrentsViewController : UIViewController {
	
	WikiController *wiki_controller;
	
}

@property (retain) WikiController *wiki_controller;


@end

