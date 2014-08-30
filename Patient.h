//
//  Patient.h
//  iCare2
//
//  Created by billy bray on 8/30/14.
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
@property (nonatomic, retain) NSSet *operation;
@property (nonatomic, retain) Practitioner *practitioner;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)addOperationObject:(Operation *)value;
- (void)removeOperationObject:(Operation *)value;
- (void)addOperation:(NSSet *)values;
- (void)removeOperation:(NSSet *)values;

@end
