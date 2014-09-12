//
//  FormGroup.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "FormGroup.h"
#import "FormElement.h"
#import "FormSection.h"


@implementation FormGroup

@dynamic heading;
@dynamic section;
@dynamic elements;
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
