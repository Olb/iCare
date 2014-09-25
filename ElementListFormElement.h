//
//  ElementListFormElement.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/23/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "FormElement.h"

@class FormElement;

@interface ElementListFormElement : FormElement

@property (nonatomic, retain) NSSet *elements;
@end

@interface ElementListFormElement (CoreDataGeneratedAccessors)

- (void)addElementsObject:(FormElement *)value;
- (void)removeElementsObject:(FormElement *)value;
- (void)addElements:(NSSet *)values;
- (void)removeElements:(NSSet *)values;

@end
