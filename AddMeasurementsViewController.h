//
//  AddMeasurementsViewController.h
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class IntraOp;
@class Measurement;

@interface AddMeasurementsViewController : UIViewController
@property Measurement *measurement;
- (instancetype)initWithIntraOp:(IntraOp*)intraOp completion:(void (^)(void))completionBlock;
@end
