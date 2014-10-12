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

#define PAGE_WIDTH 612
#define PAGE_HEIGHT 792

@interface IntraOpPdfGenerator ()
@property IntraOp *intraOp;

@end
@implementation IntraOpPdfGenerator

-(instancetype)initWithIntraOp:(IntraOp*)intraOp
{
    if (self = [super init]) {
        _intraOp = intraOp;
    }
    return self;
}

-(void)generateIntraOpPDF
{
    [self generatePdfForForm:self.intraOp];
}

-(void)drawTitlePage
{
    
}




- (bool) generatePdfForForm:(IntraOp*)form
{
    UIGraphicsBeginPDFContextToFile([BBPdfGenerator getPDFFileNameForIntraOp:form], CGRectZero, nil);
    
    UIGraphicsBeginPDFPage();
    NSString *formTitle = @"IntraOp";
    NSString *patientName = [NSString stringWithFormat:@"%@, %@", form.operation.patient.lastName, form.operation.patient.firstName];
    NSString *operation = form.operation.name;
    NSString *provider = self.intraOp.provider;
    NSString *location = self.intraOp.orLocation;
    NSString *operationDate = [BBUtil formatDate:form.operation.preOpDate];
    NSString *anesthesiaStartTime = [BBUtil formatTime:self.intraOp.anesthesiaStart];
    NSString *anesthesiaEndTime = [BBUtil formatTime:self.intraOp.anesthesiaEnd];
    NSString *procedureStartTime = [BBUtil formatTime:self.intraOp.procedureStart];
    NSString *procedureEndTime = [BBUtil formatTime:self.intraOp.procedureEnd];
    NSString *preOpStartTime = [BBUtil formatTime:self.intraOp.preOpStart];
    NSString *preOpEndTime = [BBUtil formatTime:self.intraOp.preOpEnd];
    NSString *outOfRoom = [BBUtil formatTime:self.intraOp.outOfRoom];
    NSString *anesthesiaTimeOut = [BBUtil formatTime:self.intraOp.anesthesiaTimeOut];
    NSString *surgicalTimeOut = [BBUtil formatTime:self.intraOp.surgicalTimeOut];

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

    [self drawLines];
    
    UIGraphicsEndPDFContext();
    
    return true;
}

-(void)drawLines
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    int numVerticalLines = 0;
    int currentColumnX = FIRST_COLUMN_X_COORD;
    
    // Vertical/Column lines
    while ( numVerticalLines < INTRA_OP_COLUMN_LINE_NUMBER_MAX ) {
        [aPath moveToPoint:CGPointMake( currentColumnX, PAGE_HEIGHT + 20) ];
        [aPath addLineToPoint:CGPointMake( currentColumnX, PAGE_HEIGHT - INTRA_OP_GRID_VERTICAL_LINE_TOP) ];
        [[UIColor blackColor] setStroke];
        aPath.lineWidth = 1;
        [aPath stroke];
        if ( numVerticalLines < INTRA_OP_COLUMN_LINE_NUMBER_MAX - 1 ) {
            [self drawTwoBPColumnLines:currentColumnX];
        }
        numVerticalLines += 1;
        currentColumnX += COLUMN_INTERVAL_WIDTH;
    }
    
    // Horizontal/row line
   // Draw gas
    for (int i = 0; i < self.intraOp.measurements.count; i++) {
        [aPath moveToPoint:CGPointMake( 20, 20*i) ];
        [aPath addLineToPoint:CGPointMake( PAGE_WIDTH - 20, 20 *i)];
        [aPath stroke];
    }
    // Draw fluids
    
    // Draw ...
    
    // Add Horizontal BP lines
    [self drawBPRowLines];
}

-(void)drawTwoBPColumnLines:(int)originX
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    float lineSeperation = COLUMN_INTERVAL_WIDTH / 3.0;
    int numLinesDrawn = 0;
    while ( numLinesDrawn < 2 ) {
        [aPath moveToPoint:CGPointMake( lineSeperation, 50) ];
        [aPath addLineToPoint:CGPointMake( lineSeperation, 500) ];
        lineSeperation += lineSeperation;
        numLinesDrawn++;
    }
    aPath.lineWidth = 1;
    [[UIColor lightGrayColor] setStroke];
    [aPath stroke];
}

-(void)drawBPRowLines
{
//    UIBezierPath *aPath = [UIBezierPath bezierPath];
//    float lineSeperation = ( self.tableFour.frame.origin.y - ( self.tableThree.frame.origin.y + self.tableThree.bounds.size.height) ) / 24; // 23 lines
//    int numLinesDrawn = 0;
//    float xCoord = ((CGPoint)[self.tableThree convertPoint:self.tableThree.bounds.origin toView:self]).x + FIRST_COLUMN_X_COORD;
//    float yCoord = ((CGPoint)[self.tableThree convertPoint:self.tableThree.bounds.origin toView:self]).y + self.tableThree.bounds.size.height + lineSeperation;
//    CGPoint fiftyPoint;
//    CGPoint hundredPoint;
//    CGPoint hundredFiftyPoint;
//    CGPoint twoHundredPoint;
//    
//    while ( numLinesDrawn < 24 ) {
//        switch (numLinesDrawn) {
//            case 3:{
//                NSString *string = @"200";
//                twoHundredPoint = CGPointMake(xCoord, yCoord);
//                [string drawInRect:CGRectMake(twoHundredPoint.x-25, twoHundredPoint.y-7, 50, 50) withAttributes:nil];
//                [aPath moveToPoint:CGPointMake(xCoord , yCoord )];
//                [aPath addLineToPoint:CGPointMake( xCoord + self.tableThree.bounds.size.width, yCoord )];
//                break;
//            }
//            case 8:{
//                NSString *string = @"150";
//                hundredFiftyPoint = CGPointMake(xCoord, yCoord);
//                [string drawInRect:CGRectMake(hundredFiftyPoint.x-25, hundredFiftyPoint.y-7, 50, 50) withAttributes:nil];
//                break;
//            }
//            case 13: {
//                NSString *string = @"100";
//                hundredPoint = CGPointMake(xCoord, yCoord);
//                [string drawInRect:CGRectMake(hundredPoint.x-25, hundredPoint.y-7, 50, 50) withAttributes:nil];
//                break;
//            }
//            case 18: {
//                NSString *string = @"50";
//                fiftyPoint = CGPointMake(xCoord, yCoord);
//                [string drawInRect:CGRectMake(fiftyPoint.x-25, fiftyPoint.y-7, 50, 50) withAttributes:nil];
//                break;
//            }
//            default:
//                break;
//        }
//        [aPath moveToPoint:CGPointMake(xCoord , yCoord )];
//        [aPath addLineToPoint:CGPointMake( xCoord + self.tableThree.bounds.size.width, yCoord )];
//        yCoord += lineSeperation;
//        numLinesDrawn++;
//    }
//    aPath.lineWidth = 1;
//    [[UIColor lightGrayColor] setStroke];
//    [aPath stroke];
//    
//    // Fat lines
//    UIBezierPath *aPath2 = [UIBezierPath bezierPath];
//    
//    [aPath2 moveToPoint:CGPointMake(fiftyPoint.x , fiftyPoint.y )];
//    [aPath2 addLineToPoint:CGPointMake( fiftyPoint.x + self.tableThree.bounds.size.width, fiftyPoint.y )];
//    [aPath2 moveToPoint:CGPointMake(hundredPoint.x , hundredPoint.y )];
//    [aPath2 addLineToPoint:CGPointMake( hundredPoint.x + self.tableThree.bounds.size.width, hundredPoint.y )];
//    [aPath2 moveToPoint:CGPointMake(hundredFiftyPoint.x , hundredFiftyPoint.y )];
//    [aPath2 addLineToPoint:CGPointMake( hundredFiftyPoint.x + self.tableThree.bounds.size.width, hundredFiftyPoint.y )];
//    [aPath2 moveToPoint:CGPointMake(twoHundredPoint.x , twoHundredPoint.y )];
//    [aPath2 addLineToPoint:CGPointMake( twoHundredPoint.x + self.tableThree.bounds.size.width, twoHundredPoint.y )];
//    [[UIColor blackColor] setStroke];
//    aPath2.lineWidth = 1;
//    [aPath2 stroke];
    
}


@end
