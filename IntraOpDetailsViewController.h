//
//  IntraOpDetailsViewController.h
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntraOp.h"
#import "IntraOpViewController.h"

@interface IntraOpDetailsViewController : UIViewController
@property (weak) IntraOp *intraOp;
@property (weak) IntraOpViewController *intraOpViewController;
@end
