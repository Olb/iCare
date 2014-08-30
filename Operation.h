//
//  Operation.h
//  iCare2
//
//  Created by billy bray on 8/30/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Patient;

@interface Operation : NSManagedObject

@property (nonatomic, retain) NSString * height;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSDate * preOpDate;
@property (nonatomic, retain) NSString * weight;
@property (nonatomic, retain) NSManagedObject *anesthesiaRecord;
@property (nonatomic, retain) NSManagedObject *intraOp;
@property (nonatomic, retain) Patient *patient;
@property (nonatomic, retain) NSManagedObject *postOp;
@property (nonatomic, retain) NSManagedObject *preOp;

@end
