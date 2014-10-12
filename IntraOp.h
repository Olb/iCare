//
//  IntraOp.h
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent, Allergy, BloodPressure, Measurement, Operation;

@interface IntraOp : NSManagedObject

@property (nonatomic, retain) NSDate * anesthesiaEnd;
@property (nonatomic, retain) NSDate * anesthesiaStart;
@property (nonatomic, retain) NSString * orLocation;
@property (nonatomic, retain) NSDate * outOfRoom;
@property (nonatomic, retain) NSDate * preOpEnd;
@property (nonatomic, retain) NSDate * preOpStart;
@property (nonatomic, retain) NSDate * procedureEnd;
@property (nonatomic, retain) NSDate * procedureStart;
@property (nonatomic, retain) NSString * provider;
@property (nonatomic, retain) NSDate * anesthesiaTimeOut;
@property (nonatomic, retain) NSDate * surgicalTimeOut;
@property (nonatomic, retain) NSSet *agent;
@property (nonatomic, retain) NSSet *allergies;
@property (nonatomic, retain) NSSet *bloodPressures;
@property (nonatomic, retain) NSSet *measurements;
@property (nonatomic, retain) Operation *operation;
@end

@interface IntraOp (CoreDataGeneratedAccessors)

- (void)addAgentObject:(Agent *)value;
- (void)removeAgentObject:(Agent *)value;
- (void)addAgent:(NSSet *)values;
- (void)removeAgent:(NSSet *)values;

- (void)addAllergiesObject:(Allergy *)value;
- (void)removeAllergiesObject:(Allergy *)value;
- (void)addAllergies:(NSSet *)values;
- (void)removeAllergies:(NSSet *)values;

- (void)addBloodPressuresObject:(BloodPressure *)value;
- (void)removeBloodPressuresObject:(BloodPressure *)value;
- (void)addBloodPressures:(NSSet *)values;
- (void)removeBloodPressures:(NSSet *)values;

- (void)addMeasurementsObject:(Measurement *)value;
- (void)removeMeasurementsObject:(Measurement *)value;
- (void)addMeasurements:(NSSet *)values;
- (void)removeMeasurements:(NSSet *)values;

@end
