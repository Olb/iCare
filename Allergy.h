//
//  Allergy.h
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class IntraOp;

@interface Allergy : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) IntraOp *intraop;

@end
