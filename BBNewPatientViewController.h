//
//  BBNewPatientViewController.h
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Practitioner.h"
#import "BBMainViewController.h"
@interface BBNewPatientViewController : UIViewController
@property (weak, nonatomic) Practitioner *practitioner;
@property (weak, nonatomic) BBMainViewController *mainViewController;
@end
