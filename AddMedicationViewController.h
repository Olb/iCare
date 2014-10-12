//
//  AddMedicationViewController.h
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Agent.h"
@class IntraOp;

@interface AddMedicationViewController : UIViewController
@property Agent *agent;
- (instancetype)initWithIntraOp:(IntraOp*)intrraOp completion:(void (^)(void))completionBlock;
@end
