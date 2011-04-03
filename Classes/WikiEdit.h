//
//  WikiEdit.h
//  Undercurrents
//
//  Created by Daniel Sundström on 4/2/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface WikiEdit : UIViewController<UIAlertViewDelegate> {
	int editing_wiki_id;
	UITextView *edit;
}

-(void)addToolbar; 
-(void)cancelEdit;
-(void)saveEdit;
-(void)addEditGui;

@property int editing_wiki_id;
@property (retain) UITextView *edit;

@end
