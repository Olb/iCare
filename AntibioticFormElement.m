//
//  AntibioticFormElement.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/22/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "AntibioticFormElement.h"
#import "BBUtil.h"
#import "BPBAppDelegate.h"
@implementation AntibioticFormElement

@dynamic name;
@dynamic dose;
@dynamic doseUnit;
@dynamic startTime;

-(id)initWithCoder:(NSCoder *)aDecoder
{
    NSLog(@"initWithCoder: called");
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    self = [super initWithEntity:[NSEntityDescription entityForName:@"AntibioticFormElement"
                                                               inManagedObjectContext:context] insertIntoManagedObjectContext:context];
    self.name =[aDecoder decodeObjectForKey:@"name"];
    self.dose =[aDecoder decodeObjectForKey:@"dose"];
    self.doseUnit =[aDecoder decodeObjectForKey:@"doseUnit"];
    self.startTime =[aDecoder decodeObjectForKey:@"startTime"];

    return self;
}

-(void)encodeWithCoder:(NSCoder *)encoder
{
    NSLog(@"encodeWithCoder: called");
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:self.dose forKey:@"dose"];
    [encoder encodeObject:self.doseUnit forKey:@"doseUnit"];
    [encoder encodeObject:self.startTime forKey:@"startTime"];

}
@end
