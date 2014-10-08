//
//  MeasurementTableAdapter.h
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntraOpViewController.h"

@class IntraOp;

@interface MeasurementTableAdapter : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IntraOp *intraOp;
@property (weak, nonatomic) IntraOpViewController *controller;

-(id)initWithType:(NSString*)agentType;
@end
