//
//  BBTableViewPopoverController.h
//  iCare
//
//  Created by Billy Bray on 2/7/14.
//  Copyright (c) 2014 Billy Bray. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BBPopoverCell.h"

@protocol BBProceduresTableViewControllerDelegate <NSObject>
@optional
-(void)didSaveValues:(NSMutableSet*)set;
@end
@interface BBProceduresTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) id <BBProceduresTableViewControllerDelegate> delegate;
@property (nonatomic, weak) NSMutableSet *loadedProcedureSet;
@end
