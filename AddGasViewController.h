//
//  AddGasViewController.h
//  iCare
//
//  Created by Billy Bray on 10/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IntraOp.h"
#import "Agent.h"
#import "IntraOpViewController.h"

@interface AddGasViewController : UIViewController 
@property IntraOp *intraOp;
@property Agent *agent;
@property (weak) IntraOpViewController *vc;
- (instancetype)initWithIntraOp:(IntraOp*)intrraOp completion:(void (^)(void))completionBlock;
@end
