//
//  AntibioticFormElement.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/22/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FormElement.h"


@interface AntibioticFormElement : FormElement

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * dose;
@property (nonatomic, retain) NSString * doseUnit;
@property (nonatomic, retain) NSDate * startTime;

@end
