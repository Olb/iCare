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

@end
