//
//  BBPdfSectionBuilder.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/17/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FormSection;

@interface BBPdfSectionBuilder : NSObject

+(CGSize) drawSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin;
@end
