//
//  IntraOp.h
//  iCare
//
//  Created by Billy Bray on 10/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Agent, Operation;

@interface IntraOp : NSManagedObject

@property (nonatomic, retain) NSSet *agent;
@property (nonatomic, retain) Operation *operation;
@end

@interface IntraOp (CoreDataGeneratedAccessors)

- (void)addAgentObject:(Agent *)value;
- (void)removeAgentObject:(Agent *)value;
- (void)addAgent:(NSSet *)values;
- (void)removeAgent:(NSSet *)values;

@end
