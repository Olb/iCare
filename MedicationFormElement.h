//
//  MedicationFormElement.h
//  iCare2
//
//  Created by Billy Bray on 9/23/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FormElement.h"


@interface MedicationFormElement : FormElement

@property (nonatomic, retain) NSString * dose;
@property (nonatomic, retain) NSString * doseUnit;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * selected;

@end
