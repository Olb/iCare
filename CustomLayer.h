//
//  CustomLayer.h
//  iCare
//
//  Created by Billy Bray on 10/9/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "BloodPressure.h"

@interface CustomLayer : CAShapeLayer
@property BloodPressure *p;
@end
