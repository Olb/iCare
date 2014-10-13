//
//  AddFluidViewController.h
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Agent.h"
#import "IntraOpViewController.h"
#import "TimeScrollView.h"

@class  IntraOp;
@interface AddFluidViewController : UIViewController
@property Agent *agent;
@property (weak) IntraOpViewController *vc;
- (instancetype)initWithIntraOp:(IntraOp*)intrraOp completion:(void (^)(void))completionBlock;
@end
