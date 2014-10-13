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
#import "TimeScrollView.h"

#define PAGE_WIDTH 612
#define PAGE_HEIGHT 792

@interface IntraOpPdfGenerator ()
@property IntraOp *intraOp;

@end
@implementation IntraOpPdfGenerator


+ (bool) generatePdfForForm:(IntraOp*)intraOp withView:(UIView*)view forIntraOp:(IntraOpViewController*)controller
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

    CGPoint recordLabelPoint = CGPointMake((PAGE_WIDTH - [BBPdfGenerator getStringSize:formTitle withFont:[UIFont boldSystemFontOfSize:16.0f]].width)/2.0+70, 60.0f);
    [BBPdfGenerator drawText:formTitle atLocation:recordLabelPoint withFont:[UIFont boldSystemFontOfSize:16.0f]];
    [BBPdfGenerator drawText:patientName atLocation:CGPointMake(20.0, 15*8) isBold:YES];
    [BBPdfGenerator drawText:@"Operation: " atLocation:CGPointMake(20.0, 15*9) isBold:YES];
    [BBPdfGenerator drawText:operation atLocation:CGPointMake(90.0, 15*9) isBold:YES];
    [BBPdfGenerator drawText:@"Operation Date: " atLocation:CGPointMake(20.0, 15*10) isBold:YES];
    [BBPdfGenerator drawText:operationDate atLocation:CGPointMake(120.0, 15*10) isBold:YES];
    [BBPdfGenerator drawText:@"Provider: " atLocation:CGPointMake(20.0, 15*11) isBold:YES];
    [BBPdfGenerator drawText:provider atLocation:CGPointMake(75.0, 15*11) isBold:YES];
    [BBPdfGenerator drawText:@"Location: " atLocation:CGPointMake(20.0, 15*12) isBold:YES];
    [BBPdfGenerator drawText:location atLocation:CGPointMake(80.0, 15*12) isBold:YES];
    [BBPdfGenerator drawText:@"Anesthesia Start Time: " atLocation:CGPointMake(20.0, 15*13) isBold:YES];
    [BBPdfGenerator drawText:anesthesiaStartTime atLocation:CGPointMake(150.0, 15*13) isBold:YES];
    [BBPdfGenerator drawText:@"Anesthesia End Time: " atLocation:CGPointMake(20.0, 15*14) isBold:YES];
    [BBPdfGenerator drawText:anesthesiaEndTime atLocation:CGPointMake(150.0, 15*14) isBold:YES];
    [BBPdfGenerator drawText:@"Procedure Start Time: " atLocation:CGPointMake(20.0, 15*15) isBold:YES];
    [BBPdfGenerator drawText:procedureStartTime atLocation:CGPointMake(150.0, 15*15) isBold:YES];
    [BBPdfGenerator drawText:@"Procedure End Time: " atLocation:CGPointMake(20.0, 15*16) isBold:YES];
    [BBPdfGenerator drawText:procedureEndTime atLocation:CGPointMake(150.0, 15*16) isBold:YES];
    [BBPdfGenerator drawText:@"PreOp Start Time: " atLocation:CGPointMake(20.0, 15*17) isBold:YES];
    [BBPdfGenerator drawText:preOpStartTime atLocation:CGPointMake(150.0, 15*17) isBold:YES];
    [BBPdfGenerator drawText:@"PreOp End Time: " atLocation:CGPointMake(20.0, 15*18) isBold:YES];
    [BBPdfGenerator drawText:preOpEndTime atLocation:CGPointMake(150.0, 15*18) isBold:YES];
    [BBPdfGenerator drawText:@"Out Of Room: " atLocation:CGPointMake(20.0, 15*19) isBold:YES];
    [BBPdfGenerator drawText:outOfRoom atLocation:CGPointMake(150.0, 15*19) isBold:YES];
    [BBPdfGenerator drawText:@"Anesthesia Time Out: " atLocation:CGPointMake(20.0, 15*20) isBold:YES];
    [BBPdfGenerator drawText:anesthesiaTimeOut atLocation:CGPointMake(150.0, 15*20) isBold:YES];
    [BBPdfGenerator drawText:@"Surgical Time Out: " atLocation:CGPointMake(20.0, 15*21) isBold:YES];
    [BBPdfGenerator drawText:surgicalTimeOut atLocation:CGPointMake(150.0, 15*21) isBold:YES];

    UIGraphicsBeginPDFPage();
    CGPoint timeScrollViewCurrentLocation = controller.timeScrollView.contentOffset;
    [controller scrollToBeginning];
    [IntraOpPdfGenerator createPDFfromUIView:view];

    NSTimeInterval totalIntraOpPages = [intraOp.anesthesiaEnd timeIntervalSinceDate:intraOp.anesthesiaStart]/(long)(75*60);
    totalIntraOpPages += 1;
    NSDate *nextPageDate = intraOp.anesthesiaStart;
    for(int i = 1; i < totalIntraOpPages; i++) {
        UIGraphicsBeginPDFPage();
        nextPageDate = [nextPageDate dateByAddingTimeInterval:(75*60)];
        [controller pageForTime:nextPageDate];
        [IntraOpPdfGenerator createPDFfromUIView:view];
    }
    
    UIGraphicsEndPDFContext();
    
    [pdfData writeToFile:[BBPdfGenerator getPDFFileNameForIntraOp:intraOp] atomically:YES];
    [controller.timeScrollView setContentOffset:timeScrollViewCurrentLocation animated:NO];
    return true;
}

+(void)createPDFfromUIView:(UIView*)aView
{
    CGContextRef pdfContext = UIGraphicsGetCurrentContext();
    [aView.layer renderInContext:pdfContext];
}


@end
