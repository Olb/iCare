//
//  IntraOp.h
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent, Measurement, Operation;

@interface IntraOp : NSManagedObject

@property (nonatomic, retain) NSSet *agent;
@property (nonatomic, retain) Operation *operation;
@property (nonatomic, retain) NSSet *measurements;
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

@end
