//
//  BBTableViewPopoverController.h
//  iCare
//
//  Created by Billy Bray on 2/7/14.
//  Copyright (c) 2014 Billy Bray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBPopoverCell.h"

@protocol BBSelectedItemsDelegate <NSObject>
@optional
-(void)didSaveValues:(NSArray*)values;
@end
@interface BBPFilerableSelectableTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) id <BBSelectedItemsDelegate> delegate;
@end
