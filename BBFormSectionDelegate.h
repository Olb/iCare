//
//  BBFormSectionDelegate.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FormSection;
@protocol BBFormSectionDelegate <NSObject>
-(void)sectionCreated:(FormSection*)formSection;
@end
