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
    UIGraphicsBeginPDFContextToFile([self getPDFFileNameForForm:form], CGRectZero, nil);
    
    UIGraphicsBeginPDFPage();
    NSString *string = @"Some TExt";
    CGContextRef currentContext = UIGraphicsGetCurrentContext();
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
    
    // Get the graphics context.
    
    // Put the text matrix into a known state. This ensures
    // that no old scaling factors are left in place.
    CGContextSetTextMatrix(currentContext, CGAffineTransformIdentity);
    
    // Core Text draws from the bottom-left corner up, so flip
    // the current transform prior to drawing.
    // Modify this to take into consideration the origin.
    CGContextTranslateCTM(currentContext, 0, frameRect.origin.y*2);
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    
    // Draw the frame.
    CTFrameDraw(frameRef, currentContext);
    
    
    // Add these two lines to reverse the earlier transformation.
    CGContextScaleCTM(currentContext, 1.0, -1.0);
    CGContextTranslateCTM(currentContext, 0, (-1)*frameRect.origin.y*2);
    
    CFRelease(frameRef);
    CFRelease(stringRef);
    CFRelease(framesetter);
    
    
    
    UIGraphicsEndPDFContext();
    return true;
}

@end
