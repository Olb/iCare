//
//  BBPdfGenerator.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/16/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <CoreText/CoreText.h>
#import "BBPdfGenerator.h"
#import "Form.h"
#import "Operation.h"
#import "Patient.h"
#import "FormSection.h"
#import "FormGroup.h"
#import "FormSection.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "BBPdfSectionBuilder.h"
#import "BBUtil.h"

@implementation BBPdfGenerator

+(NSString*)getPDFFileNameForForm:(Form*)form
{
    
    NSString* fileNameToPassToPDFRenderer = [NSString stringWithFormat:@"%@%@%@%@.pdf",
                                                    form.title,
                                                    form.operation.patient.lastName,
                                                    form.operation.name,
                                                    form.operation.preOpDate];
    
    NSArray *arrayPaths =
    NSSearchPathForDirectoriesInDomains(
                                        NSDocumentDirectory,
                                        NSUserDomainMask,
                                        YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString* pdfFileName = [path stringByAppendingPathComponent:fileNameToPassToPDFRenderer];
    
    NSLog(@"NAME:%@", pdfFileName);
    return pdfFileName;
    
}

+ (bool) generatePdfForForm:(Form*)form
{
    UIGraphicsBeginPDFContextToFile([BBPdfGenerator getPDFFileNameForForm:form], CGRectZero, nil);
    
    UIGraphicsBeginPDFPage();
    
    CGPoint location = CGPointMake(20, 20);
    for ( FormSection* section in form.sections ){

        CGSize size = [BBPdfSectionBuilder drawSection:(FormSection*)section atLocation:location];
        [BBUtil drawRect:CGRectMake(location.x, location.y, size.width, size.height)];
        
        location.y += size.height;
    }
    
    UIGraphicsEndPDFContext();
    
    return true;
}



+(CGSize)drawCheckBoxChecked:(BOOL)checked atLocation:(CGPoint)location
{
    UIImage* logo = checked ? [UIImage imageNamed:@"checkbox_selected.png"] : [UIImage imageNamed:@"checkbox_unselected.png"];
    CGRect frame = CGRectMake(location.x,location.y, 14, 14);
    [logo drawInRect:frame];
    return frame.size;
}

+(CGSize)drawText:(id)text atLocation:(CGPoint)location
{
    UIFont *font = [UIFont systemFontOfSize:12.0f];
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         font}];
    
    CGRect frameRect = CGRectMake(location.x, location.y, size.width, size.height);

    NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,
                                nil];
    [text drawInRect:frameRect withAttributes:attr];
    
    return size;
}

/*
 
 <Graphics>
 <Group label="Anesthesia PreOp time used to:">
 <Element name="CheckConsents" label="Check consents and review chart/plan with Pt" />
 <Element name="StartIv" label="Start IV" />
 <Element name="OtherActions" label="Other Actions" />
 </Group>
 </Graphics>
 
 */

@end
