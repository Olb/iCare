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
        for  ( FormGroup* group in section.groups ){
            [self drawGroup:group];
        }
    }
    
    
    // Get the graphics context.
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
    
    
    NSString *string = @"Some TExt";
    CFStringRef stringRef = (__bridge CFStringRef)string;
    // Prepare the text using a Core Text Framesetter.
    CFAttributedStringRef currentText = CFAttributedStringCreate(NULL, stringRef, NULL);
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(currentText);
    CGRect frameRect = CGRectMake(0, 0, 300, 50.0);
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
    CGContextTranslateCTM(currentContext, 0, 100);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
    
    
    
    UIGraphicsEndPDFContext();
    return true;
}

+(void) drawGroup:(FormGroup*)group
{
    
}

@end
