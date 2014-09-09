//
//  BPBGenericTableAdapter.h
//  iCare2
//
//  Created by billy bray on 9/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Patient.h"

@interface BBOperationsTableAdapter : NSObject <UITableViewDataSource, UITableViewDelegate>
@property Patient *patient;
@end
