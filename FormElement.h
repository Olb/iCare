//
//  FormElement.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class FormGroup;

@interface FormElement : NSManagedObject

@property (nonatomic, retain) NSString * key;
@property (nonatomic, retain) FormGroup *group;

@end
