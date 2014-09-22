//
//  BBFormElementTableAdapter.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/22/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BBFormElementTableDelegate <NSObject>
@optional
-(void) itemSelected:(NSString*)item;
-(void) itemDeleted:(NSString*)item atIndexPathRow:(NSInteger)row;
@end
@interface FormElementTableAdapter : UIViewController
@property NSMutableArray *items;
@property id <BBFormElementTableDelegate> delegate;
@end
