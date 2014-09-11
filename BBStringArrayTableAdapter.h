//
//  BBStringArrayTableAdapter.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BBStringArrayTableDelegate <NSObject>
-(void) itemSelected:(NSString*)item;
-(void) itemDeleted:(NSString*)item;
@end
@interface BBStringArrayTableAdapter : NSObject <UITableViewDataSource, UITableViewDelegate>
@property NSMutableArray *items;
@property id <BBStringArrayTableDelegate> delegate;
@end
