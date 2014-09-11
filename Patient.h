//
//  Patient.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/12/14.
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
@property (nonatomic, retain) NSOrderedSet *operations;
@property (nonatomic, retain) Practitioner *practitioner;
@end

@interface Patient (CoreDataGeneratedAccessors)

- (void)insertObject:(Operation *)value inOperationsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromOperationsAtIndex:(NSUInteger)idx;
- (void)insertOperations:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeOperationsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInOperationsAtIndex:(NSUInteger)idx withObject:(Operation *)value;
- (void)replaceOperationsAtIndexes:(NSIndexSet *)indexes withOperations:(NSArray *)values;
- (void)addOperationsObject:(Operation *)value;
- (void)removeOperationsObject:(Operation *)value;
- (void)addOperations:(NSOrderedSet *)values;
- (void)removeOperations:(NSOrderedSet *)values;
@end
