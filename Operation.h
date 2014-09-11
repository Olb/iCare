//
//  Operation.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Form, IntraOp, Patient;

@interface Operation : NSManagedObject

@property (nonatomic, retain) NSString * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * preOpDate;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) IntraOp *intraOp;
@property (nonatomic, retain) NSSet *forms;
@end

@interface Operation (CoreDataGeneratedAccessors)

- (void)addFormsObject:(Form *)value;
- (void)removeFormsObject:(Form *)value;
- (void)addForms:(NSSet *)values;
- (void)removeForms:(NSSet *)values;

@end
