//
//  BBPatientFormsViewController.h
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OperationsTableAdapter.h"

@class Patient;
@interface BBPatientFormsViewController : UIViewController <BBOperationSelectedDelegate>
@property Patient *patient;
@end
