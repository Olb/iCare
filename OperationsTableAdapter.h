//
//  BPBGenericTableAdapter.h
//  iCare2
//
//  Created by billy bray on 9/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"
@class Operation;

@protocol BBOperationSelectedDelegate <NSObject>
-(void) operationSelected:(Operation*)operation fromPatient:(Patient*)patient;
-(void) operationDeleted:(Operation*)operation;
@end

@interface OperationsTableAdapter : NSObject <UITableViewDataSource, UITableViewDelegate>
@property Patient *patient;
@property id <BBOperationSelectedDelegate> delegate;
@end
