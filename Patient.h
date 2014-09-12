//
//  Patient.h
//  iCare2
//
//  Created by Billy Bray on 9/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Operation, Practitioner;

@interface Patient : NSManagedObject

@property (nonatomic, retain) NSDate * birthdate;
@property (nonatomic, retain) NSString * caseCode;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * medicalRecordNumber;
@property (nonatomic, retain) NSSet *operations;
@property (nonatomic, retain) Practitioner *practitioner;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addOperationsObject:(Operation *)value;
- (void)removeOperationsObject:(Operation *)value;
- (void)addOperations:(NSSet *)values;
- (void)removeOperations:(NSSet *)values;

@end
