//
//  BBFilterableTableViewController.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/4/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BBFilterableTableViewControllerDelegate <NSObject>
@optional
-(void)didSaveValues:(NSMutableSet*)set;
@end

@interface BBFilterableTableViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) id <BBFilterableTableViewControllerDelegate> delegate;
@property (nonatomic, strong) NSArray* dataSet;
@end
