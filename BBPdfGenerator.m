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

@implementation BBPdfGenerator

+(NSString*)getPDFFileNameForForm:(Form*)form
{
    
    NSString* fileNameToPassToPDFRenderer = [NSString stringWithFormat:@"%@_%@_%@_%@.pdf",
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
    
    return pdfFileName;
    
}

+ (bool) generatePdfForForm:(Form*)form
{
    UIGraphicsBeginPDFContextToFile([BBPdfGenerator getPDFFileNameForForm:form], CGRectZero, nil);
    
    UIGraphicsBeginPDFPage();
    
    
    for ( FormSection* section in form.sections ){
        [BBPdfSectionBuilder drawSection:(FormSection*)section atLocation:CGPointMake(20, 100)];
    }
    
    UIGraphicsEndPDFContext();
    return true;
}



+(CGSize)drawCheckBoxChecked:(BOOL)checked atLocation:(CGPoint)location
{
    UIImage* logo = checked ? [UIImage imageNamed:@"checkbox_selected.png"] : [UIImage imageNamed:@"checkbox_unselected.png"];
    CGRect frame = CGRectMake(location.x,location.y, 20, 20);
    [logo drawInRect:frame];
    return frame.size;
}

+(CGSize)drawText:(id)text atLocation:(CGPoint)location
{
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         [UIFont systemFontOfSize:17.0f]}];
    
    CGContextRef currentContext = UIGraphicsGetCurrentContext();

    // Get the graphics context.
    CFStringRef stringRef = (__bridge CFStringRef)text;
    // Prepare the text using a Core Text Framesetter.
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    CGRect frameRect = CGRectMake(location.x, location.y, size.width, size.height);
    CGMutablePathRef framePath = CGPathCreateMutable();
    CGPathAddRect(framePath, NULL, frameRect);
    
    // Get the frame that will do the rendering.
    CFRange currentRange = CFRangeMake(0, 0);
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, currentRange, framePath, NULL);
    CGPathRelease(framePath);
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    CGContextTranslateCTM(currentContext, 0, size.height + frameRect.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*(size.height + frameRect.origin.y*2));

    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
    
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
