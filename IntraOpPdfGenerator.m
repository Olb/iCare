//
//  IntraOpPdfGenerator.m
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "IntraOpPdfGenerator.h"
#import "Operation.h"
#import "Patient.h"
#import "BBUtil.h"
#import "BBPdfGenerator.h"
#import "GridConstants.h"
#import "IntraOpGrid.h"

#define PAGE_WIDTH 612
#define PAGE_HEIGHT 792

@interface IntraOpPdfGenerator ()
@property IntraOp *intraOp;

@end
@implementation IntraOpPdfGenerator


+ (bool) generatePdfForForm:(IntraOp*)intraOp withView:(UIView*)view
{
    NSMutableData *pdfData = [NSMutableData data];
    CGRect r = CGRectMake(0, -50, view.bounds.size.width, view.bounds.size.height-90);
    UIGraphicsBeginPDFContextToData(pdfData, r, nil);
    
    UIGraphicsBeginPDFPage();
    NSString *formTitle = @"IntraOp";
    NSString *patientName = [NSString stringWithFormat:@"%@, %@", intraOp.operation.patient.lastName, intraOp.operation.patient.firstName];
    NSString *operation = intraOp.operation.name;
    NSString *provider = intraOp.provider;
    NSString *location = intraOp.orLocation;
    NSString *operationDate = [BBUtil formatDate:intraOp.operation.preOpDate];
    NSString *anesthesiaStartTime = [BBUtil formatTime:intraOp.anesthesiaStart];
    NSString *anesthesiaEndTime = [BBUtil formatTime:intraOp.anesthesiaEnd];
    NSString *procedureStartTime = [BBUtil formatTime:intraOp.procedureStart];
    NSString *procedureEndTime = [BBUtil formatTime:intraOp.procedureEnd];
    NSString *preOpStartTime = [BBUtil formatTime:intraOp.preOpStart];
    NSString *preOpEndTime = [BBUtil formatTime:intraOp.preOpEnd];
    NSString *outOfRoom = [BBUtil formatTime:intraOp.outOfRoom];
    NSString *anesthesiaTimeOut = [BBUtil formatTime:intraOp.anesthesiaTimeOut];
    NSString *surgicalTimeOut = [BBUtil formatTime:intraOp.surgicalTimeOut];

    CGPoint recordLabelPoint = CGPointMake((PAGE_WIDTH - [BBPdfGenerator getStringSize:formTitle withFont:[UIFont boldSystemFontOfSize:16.0f]].width)/2.0, 20.0f);
    [BBPdfGenerator drawText:formTitle atLocation:recordLabelPoint withFont:[UIFont boldSystemFontOfSize:16.0f]];
    [BBPdfGenerator drawText:patientName atLocation:CGPointMake(20.0, 15*3) isBold:YES];
    [BBPdfGenerator drawText:operation atLocation:CGPointMake(20.0, 15*4) isBold:YES];
    [BBPdfGenerator drawText:@"Operation Date: " atLocation:CGPointMake(20.0, 15*5) isBold:YES];
    [BBPdfGenerator drawText:operationDate atLocation:CGPointMake(120.0, 15*5) isBold:YES];
    [BBPdfGenerator drawText:@"Provider: " atLocation:CGPointMake(20.0, 15*6) isBold:YES];
    [BBPdfGenerator drawText:provider atLocation:CGPointMake(75.0, 15*6) isBold:YES];
    [BBPdfGenerator drawText:@"Location: " atLocation:CGPointMake(20.0, 15*7) isBold:YES];
    [BBPdfGenerator drawText:location atLocation:CGPointMake(75.0, 15*7) isBold:YES];
    [BBPdfGenerator drawText:@"Anesthesia Start Time: " atLocation:CGPointMake(20.0, 15*8) isBold:YES];
    [BBPdfGenerator drawText:anesthesiaStartTime atLocation:CGPointMake(150.0, 15*8) isBold:YES];
    [BBPdfGenerator drawText:@"Anesthesia End Time: " atLocation:CGPointMake(20.0, 15*9) isBold:YES];
    [BBPdfGenerator drawText:anesthesiaEndTime atLocation:CGPointMake(150.0, 15*9) isBold:YES];
    [BBPdfGenerator drawText:@"Procedure Start Time: " atLocation:CGPointMake(20.0, 15*10) isBold:YES];
    [BBPdfGenerator drawText:procedureStartTime atLocation:CGPointMake(150.0, 15*10) isBold:YES];
    [BBPdfGenerator drawText:@"Procedure End Time: " atLocation:CGPointMake(20.0, 15*11) isBold:YES];
    [BBPdfGenerator drawText:procedureEndTime atLocation:CGPointMake(150.0, 15*11) isBold:YES];
    [BBPdfGenerator drawText:@"PreOp Start Time: " atLocation:CGPointMake(20.0, 15*12) isBold:YES];
    [BBPdfGenerator drawText:preOpStartTime atLocation:CGPointMake(150.0, 15*12) isBold:YES];
    [BBPdfGenerator drawText:@"PreOp End Time: " atLocation:CGPointMake(20.0, 15*13) isBold:YES];
    [BBPdfGenerator drawText:preOpEndTime atLocation:CGPointMake(150.0, 15*13) isBold:YES];
    [BBPdfGenerator drawText:@"Out Of Room: " atLocation:CGPointMake(20.0, 15*14) isBold:YES];
    [BBPdfGenerator drawText:outOfRoom atLocation:CGPointMake(150.0, 15*14) isBold:YES];
    [BBPdfGenerator drawText:@"Anesthesia Time Out: " atLocation:CGPointMake(20.0, 15*15) isBold:YES];
    [BBPdfGenerator drawText:anesthesiaTimeOut atLocation:CGPointMake(150.0, 15*15) isBold:YES];
    [BBPdfGenerator drawText:@"Surgical Time Out: " atLocation:CGPointMake(20.0, 15*16) isBold:YES];
    [BBPdfGenerator drawText:surgicalTimeOut atLocation:CGPointMake(150.0, 15*16) isBold:YES];

    UIGraphicsBeginPDFPage();

    [IntraOpPdfGenerator createPDFfromUIView:view];
    UIGraphicsBeginPDFPage();
    
    [IntraOpPdfGenerator createPDFfromUIView:view];
    UIGraphicsBeginPDFPage();
    
    [IntraOpPdfGenerator createPDFfromUIView:view];
    // Get number of pages
    NSTimeInterval totalIntraOpTime = [intraOp.anesthesiaStart timeIntervalSinceDate:intraOp.anesthesiaEnd]/(long)(60*60+15);
    totalIntraOpTime += 1;
    
    // For each page
    //    For all gases/meds/fluids
    //      Go through each measurements and add names of substances
    //          Draw any values for the measurements in that time interval
    //    DrawBP Grid
    //    For all monitors
    //      Go through each monitor and add names of monitors
    //          Draw any values for the monitors in that time interval
    // End foreach
    
    
    UIGraphicsEndPDFContext();
    
    [pdfData writeToFile:[BBPdfGenerator getPDFFileNameForIntraOp:intraOp] atomically:YES];
    
    return true;
}

+(void)createPDFfromUIView:(UIView*)aView
{
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    [aView.layer renderInContext:pdfContext];
    //UIGraphicsEndPDFContext();
}


@end
