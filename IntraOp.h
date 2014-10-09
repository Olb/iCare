//
//  IntraOp.h
//  iCare
//
//  Created by Billy Bray on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent, BloodPressure, Measurement, Operation;

@interface IntraOp : NSManagedObject

@property (nonatomic, retain) NSSet *agent;
@property (nonatomic, retain) NSSet *measurements;
@property (nonatomic, retain) Operation *operation;
@property (nonatomic, retain) NSSet *bloodPressures;
@end

@interface IntraOp (CoreDataGeneratedAccessors)

- (void)addAgentObject:(Agent *)value;
- (void)removeAgentObject:(Agent *)value;
- (void)addAgent:(NSSet *)values;
- (void)removeAgent:(NSSet *)values;

- (void)addMeasurementsObject:(Measurement *)value;
- (void)removeMeasurementsObject:(Measurement *)value;
- (void)addMeasurements:(NSSet *)values;
- (void)removeMeasurements:(NSSet *)values;

- (void)addBloodPressuresObject:(BloodPressure *)value;
- (void)removeBloodPressuresObject:(BloodPressure *)value;
- (void)addBloodPressures:(NSSet *)values;
- (void)removeBloodPressures:(NSSet *)values;

@end
