//
//  SubstanceTableAdapter.h
//  iCare
//
//  Created by Billy Bray on 10/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IntraOpViewController.h"

@class IntraOp;

@interface AgentTableAdapter : NSObject <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IntraOp *intraOp;
@property (weak, nonatomic) IntraOpViewController *controller;

-(id)initWithType:(NSString*)agentType;


@end
