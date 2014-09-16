//
//  BBPdfGenerator.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/16/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Form;

@interface BBPdfGenerator : NSObject

+ (bool) generatePdfForForm:(Form*)form;

@end
