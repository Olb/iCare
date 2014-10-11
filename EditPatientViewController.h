//
//  EditPatientViewController.h
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Patient.h"
#import "BBPatientFormsViewController.h"
@interface EditPatientViewController : UIViewController
@property (nonatomic, weak) Patient *patient;
@property (nonatomic, weak) BBPatientFormsViewController *mainViewController;

@end
