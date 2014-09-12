//
//  Form.m
//  iCare2
//
//  Created by Billy Bray on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "Form.h"
#import "FormSection.h"
#import "Operation.h"


@implementation Form

@dynamic title;
@dynamic operation;
@dynamic sections;
- (void)addSectionsObject:(FormSection *)value
{
    NSMutableOrderedSet* tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.sections];
    [tempSet addObject:value];
    self.sections = tempSet;
}
@end
