//
//  FormSection.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "FormSection.h"
#import "Form.h"
#import "FormGroup.h"


@implementation FormSection

@dynamic title;
@dynamic groups;
@dynamic form;

- (void)addGroupsObject:(FormGroup *)value
{
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.groups];
    [tempSet addObject:value];
    self.groups = tempSet;
}

- (NSArray*)allElements
{
    NSMutableArray *elements = [[NSMutableArray alloc] init];
    
    for (FormGroup *group in self.groups) {
        [elements addObjectsFromArray:[group.elements array]];
    }
    
    return elements;
}

-(FormElement*)getElementForKey:(NSString *)key
{
    
    for (FormGroup* g in self.groups) {
        FormElement *e = [g getElementForKey:key];
        if (e) {
            return e;
        }
    }
    return nil;
}
@end
