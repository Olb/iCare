//
//  IntraOp.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Operation;

@interface IntraOp : NSManagedObject

@property (nonatomic, retain) Operation *operation;

@end
