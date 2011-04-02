//
//  UndercurrentsAppDelegate.h
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UndercurrentsViewController;

@interface UndercurrentsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UndercurrentsViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UndercurrentsViewController *viewController;

@end

