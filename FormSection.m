//
//  FormSection.m
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "FormSection.h"
#import "Form.h"
#import "FormElement.h"


@implementation FormSection

@dynamic title;
@dynamic complete;
@dynamic elements;
@dynamic form;

-(FormElement*)getElementForKey:(NSString *)key
{
    
    for (FormElement* e in self.elements) {
        if ([e.key isEqualToString:key]) {
            return e;
        }
    }
    return nil;
}

- (void)addElementsObject:(FormElement *)value
{
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.elements];
    [tempSet addObject:value];
    self.elements = tempSet;
}

@end
