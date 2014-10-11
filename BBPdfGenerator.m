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

#define PAGE_WIDTH 612
#define PAGE_HEIGHT 792

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
    NSString *formTitle = form.title;
    NSString *patientName = [NSString stringWithFormat:@"%@, %@", form.operation.patient.lastName, form.operation.patient.firstName];
    NSString *operation = form.operation.name;
    NSString *operationDate = [BBUtil formatDate:form.operation.preOpDate];
    CGPoint recordLabelPoint = CGPointMake((PAGE_WIDTH - [BBPdfGenerator getStringSize:formTitle withFont:[UIFont boldSystemFontOfSize:16.0f]].width)/2.0, 20.0f);
    [BBPdfGenerator drawText:formTitle atLocation:recordLabelPoint withFont:[UIFont boldSystemFontOfSize:16.0f]];
    [BBPdfGenerator drawText:patientName atLocation:CGPointMake(20.0, 15*3) isBold:YES];
    [BBPdfGenerator drawText:operation atLocation:CGPointMake(20.0, 15*4) isBold:YES];
    [BBPdfGenerator drawText:operationDate atLocation:CGPointMake(20.0, 15*5) isBold:YES];
    
    CGPoint location = CGPointMake(20, 15*7.0);
    float sectionPadding = 8.0f;
    for ( FormSection* section in form.sections ){
        int sizeLeftInPage = PAGE_HEIGHT - location.y;
        if (sizeLeftInPage < [BBPdfGenerator measureSection:section].height) {
            UIGraphicsBeginPDFPage();
            location.y = 20.0;
        }
        CGSize size = [BBPdfSectionBuilder drawSection:(FormSection*)section atLocation:location];
        [BBUtil drawLineFromPoint:CGPointMake(20.0, location.y + size.height + sectionPadding) toPoint:CGPointMake(592.0, location.y + size.height + sectionPadding)];
        //[BBUtil drawRect:CGRectMake(location.x, location.y, size.width, size.height)];
        
        location.y += size.height + sectionPadding*2;
    }
    
    UIGraphicsEndPDFContext();
    
    return true;
}

+(CGSize)measureSection:(FormSection*)section
{
    return [BBPdfSectionBuilder drawSection:(FormSection*)section atLocation:CGPointMake(2000, 2000)];
}

+(CGSize)getStringSize:(NSString*)text withFont:(UIFont*)font
{
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         font}];
    
    return size;
}

+(CGSize)drawCheckBoxChecked:(BOOL)checked atLocation:(CGPoint)location
{
    UIImage* logo = checked ? [UIImage imageNamed:@"checkbox_selected.png"] : [UIImage imageNamed:@"checkbox_unselected.png"];
    CGRect frame = CGRectMake(location.x,location.y, 14, 14);
    [logo drawInRect:frame];
    return frame.size;
}

+(CGSize)drawUpArrow:(BOOL)checked atLocation:(CGPoint)location
{
    UIImage* logo = checked ? [UIImage imageNamed:@"up_arrow_selected.png"] : [UIImage imageNamed:@"up_arrow_unselected.png"];
    CGRect frame = CGRectMake(location.x,location.y, 14, 14);
    [logo drawInRect:frame];
    return frame.size;
}

+(CGSize)drawDownArrow:(BOOL)checked atLocation:(CGPoint)location
{
    UIImage* logo = checked ? [UIImage imageNamed:@"down_arrow_selected.png"] : [UIImage imageNamed:@"down_arrow_unselected.png"];
    CGRect frame = CGRectMake(location.x,location.y, 14, 14);
    [logo drawInRect:frame];
    return frame.size;
}

+(CGSize)drawText:(id)text atLocation:(CGPoint)location
{
    return [BBPdfGenerator drawText:text atLocation:location isBold:NO];
}

+(CGSize)drawText:(NSString*)text atLocation:(CGPoint)location withFont:(UIFont*)font withAttribs:(NSDictionary*)attr
{

    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         font}];
    
    CGRect frameRect = CGRectMake(location.x, location.y, size.width, size.height);
    
    [text drawInRect:frameRect withAttributes:attr];
    return size;
}

+(CGSize)drawText:(NSString*)text atLocation:(CGPoint)location withFont:(UIFont*)font
{
    NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,
                          nil];
    
    return [self drawText:text atLocation:location withFont:font withAttribs:attr];
}

+(CGSize)drawText:(id)text atLocation:(CGPoint)location isBold:(BOOL)bold
{
    UIFont *font;
    if (!bold) {
        font = [UIFont systemFontOfSize:12.0f];
    } else {
        font = [UIFont boldSystemFontOfSize:12.0f];
    }
    NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,
                          nil];
    return [BBPdfGenerator drawText:text atLocation:location withFont:font withAttribs:attr];
}

+(CGSize)drawText:(id)text atLocation:(CGPoint)location isUnderlined:(BOOL)underline
{
    UIFont *font = [UIFont systemFontOfSize:12.0f];;
    NSDictionary *attr;
    if (underline) {
       attr = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,@(NSUnderlineStyleSingle),NSUnderlineStyleAttributeName, nil];
    } else {
        attr = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName, nil];
    }
    
    return [BBPdfGenerator drawText:text atLocation:location withFont:font withAttribs:attr];
}

+(CGSize)drawTextBox:(NSString*)text atLocation:(CGPoint)location width:(int)width
{
    
    UIFont *font = [UIFont systemFontOfSize:12.0f];
    
    CGRect frame = [text boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX)
                                     options:NSStringDrawingUsesLineFragmentOrigin
                                  attributes:@{NSFontAttributeName: font}
                                     context:nil];
    
    NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,
                          nil];
    frame.origin.x = location.x+4;
    frame.origin.y = location.y+4;
    
    [text drawInRect:frame withAttributes:attr];
    
    frame = CGRectMake(frame.origin.x-4, frame.origin.y-4, frame.size.width + 8, frame.size.height + 8);
    [BBUtil drawRect:frame];
    return frame.size;
}

@end
