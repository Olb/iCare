//
//  Operation.h
//  iCare
//
//  Created by Billy Bray on 10/11/14.
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
@property (nonatomic, retain) NSString * preOpTime;
@property (nonatomic, retain) NSSet *forms;
@property (nonatomic, retain) IntraOp *intraOp;
@property (nonatomic, retain) Patient *patient;
@end

@interface Operation (CoreDataGeneratedAccessors)

- (void)addFormsObject:(Form *)value;
- (void)removeFormsObject:(Form *)value;
- (void)addForms:(NSSet *)values;
- (void)removeForms:(NSSet *)values;

@end
