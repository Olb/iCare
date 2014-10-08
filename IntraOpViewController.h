//
//  IntraOpViewController.h
//  iCare
//
//  Created by Billy Bray on 10/2/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntraOp.h"
@class Agent;
@class DoseView;
@interface IntraOpViewController : UIViewController
@property (nonatomic) IntraOp *intraOp;

-(DoseView*)doseViewForAgent:(Agent*)agent forCell:(UITableViewCell*)cell;

@end
