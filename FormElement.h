//
//  FormElement.h
//  iCare2
//
//  Created by Billy Bray on 9/18/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FormSection;

@interface FormElement : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) FormSection *section;

@end
