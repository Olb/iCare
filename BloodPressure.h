//
//  BloodPressure.h
//  iCare
//
//  Created by Billy Bray on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IntraOp;

@interface BloodPressure : NSManagedObject

@property (nonatomic, retain) NSString * diastolic;
@property (nonatomic, retain) NSString * systolic;
@property (nonatomic, retain) NSDate * time;
@property (nonatomic, retain) NSString * rate;
@property (nonatomic, retain) NSString * origin;
@property (nonatomic, retain) IntraOp *intraOp;

@end
