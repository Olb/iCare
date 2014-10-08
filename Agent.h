//
//  Agent.h
//  iCare
//
//  Created by Billy Bray on 10/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IntraOp;

@interface Agent : NSManagedObject

@property (nonatomic, retain) NSNumber * continuous;
@property (nonatomic, retain) NSString * dose;
@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) IntraOp *intraop;

@end