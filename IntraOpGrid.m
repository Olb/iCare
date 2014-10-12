//
//  IntraOpGrid.m
//  iCare
//
//  Created by Billy Bray on 10/2/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "IntraOpGrid.h"
#import "GridConstants.h"

@implementation IntraOpGrid

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    int numVerticalLines = 0;
    int currentColumnX = FIRST_COLUMN_X_COORD;
    
    // Vertical/Column lines
    while ( numVerticalLines < INTRA_OP_COLUMN_LINE_NUMBER_MAX ) {
        [aPath moveToPoint:CGPointMake( currentColumnX, self.bounds.origin.y) ];
        [aPath addLineToPoint:CGPointMake( currentColumnX, self.bounds.size.height - INTRA_OP_GRID_VERTICAL_LINE_TOP) ];
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
    NSMutableArray *tablesArray = [[NSMutableArray alloc] initWithObjects:self.tableOne, self.tableTwo, self.tableThree, self.tableFour, self.tableFive, self.tableSix, nil];
    for (UITableView *tv in tablesArray) {
        [aPath moveToPoint:CGPointMake( self.bounds.origin.x, ((CGPoint)[tv convertPoint:tv.bounds.origin toView:self]).y + tv.bounds.size.height) ];
        [aPath addLineToPoint:CGPointMake( self.bounds.size.width, ((CGPoint)[tv convertPoint:tv.bounds.origin toView:self]).y + tv.bounds.size.height) ];
        [aPath stroke];
    }
    
    // Add Horizontal BP lines
    [self drawBPRowLines];
}

-(void)drawTwoBPColumnLines:(int)originX
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    float lineSeperation = COLUMN_INTERVAL_WIDTH / 3.0;
    int numLinesDrawn = 0;
    while ( numLinesDrawn < 2 ) {
        [aPath moveToPoint:CGPointMake( originX + lineSeperation, ((CGPoint)[self.tableThree convertPoint:self.tableThree.bounds.origin toView:self]).y + self.tableThree.bounds.size.height) ];
        [aPath addLineToPoint:CGPointMake( originX + lineSeperation, ((CGPoint)[self.tableFour convertPoint:self.tableFour.bounds.origin toView:self]).y) ];
        lineSeperation += lineSeperation;
        numLinesDrawn++;
    }
    aPath.lineWidth = 1;
    [[UIColor lightGrayColor] setStroke];
    [aPath stroke];
}

-(void)drawBPRowLines
{
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    float lineSeperation = ( self.tableFour.frame.origin.y - ( self.tableThree.frame.origin.y + self.tableThree.bounds.size.height) ) / 24; // 23 lines
    int numLinesDrawn = 0;
    float xCoord = ((CGPoint)[self.tableThree convertPoint:self.tableThree.bounds.origin toView:self]).x + FIRST_COLUMN_X_COORD;
    float yCoord = ((CGPoint)[self.tableThree convertPoint:self.tableThree.bounds.origin toView:self]).y + self.tableThree.bounds.size.height + lineSeperation;
    CGPoint fiftyPoint;
    CGPoint hundredPoint;
    CGPoint hundredFiftyPoint;
    CGPoint twoHundredPoint;

    while ( numLinesDrawn < 24 ) {
        switch (numLinesDrawn) {
            case 3:{
                NSString *string = @"200";
                twoHundredPoint = CGPointMake(xCoord, yCoord);
                [string drawInRect:CGRectMake(twoHundredPoint.x-25, twoHundredPoint.y-7, 50, 50) withAttributes:nil];
                [aPath moveToPoint:CGPointMake(xCoord , yCoord )];
                [aPath addLineToPoint:CGPointMake( xCoord + self.tableThree.bounds.size.width, yCoord )];
                break;
            }
            case 8:{
                NSString *string = @"150";
                hundredFiftyPoint = CGPointMake(xCoord, yCoord);
                [string drawInRect:CGRectMake(hundredFiftyPoint.x-25, hundredFiftyPoint.y-7, 50, 50) withAttributes:nil];
                break;
            }
            case 13: {
                NSString *string = @"100";
                hundredPoint = CGPointMake(xCoord, yCoord);
                [string drawInRect:CGRectMake(hundredPoint.x-25, hundredPoint.y-7, 50, 50) withAttributes:nil];
                break;
            }
            case 18: {
                NSString *string = @"50";
                fiftyPoint = CGPointMake(xCoord, yCoord);
                [string drawInRect:CGRectMake(fiftyPoint.x-25, fiftyPoint.y-7, 50, 50) withAttributes:nil];
                break;
            }
            default:
                break;
        }
        [aPath moveToPoint:CGPointMake(xCoord , yCoord )];
        [aPath addLineToPoint:CGPointMake( xCoord + self.tableThree.bounds.size.width, yCoord )];
        yCoord += lineSeperation;
        numLinesDrawn++;
    }
    aPath.lineWidth = 1;
    [[UIColor lightGrayColor] setStroke];
    [aPath stroke];
    
    // Fat lines
    UIBezierPath *aPath2 = [UIBezierPath bezierPath];

    [aPath2 moveToPoint:CGPointMake(fiftyPoint.x , fiftyPoint.y )];
    [aPath2 addLineToPoint:CGPointMake( fiftyPoint.x + self.tableThree.bounds.size.width, fiftyPoint.y )];
    [aPath2 moveToPoint:CGPointMake(hundredPoint.x , hundredPoint.y )];
    [aPath2 addLineToPoint:CGPointMake( hundredPoint.x + self.tableThree.bounds.size.width, hundredPoint.y )];
    [aPath2 moveToPoint:CGPointMake(hundredFiftyPoint.x , hundredFiftyPoint.y )];
    [aPath2 addLineToPoint:CGPointMake( hundredFiftyPoint.x + self.tableThree.bounds.size.width, hundredFiftyPoint.y )];
    [aPath2 moveToPoint:CGPointMake(twoHundredPoint.x , twoHundredPoint.y )];
    [aPath2 addLineToPoint:CGPointMake( twoHundredPoint.x + self.tableThree.bounds.size.width, twoHundredPoint.y )];
    [[UIColor blackColor] setStroke];
    aPath2.lineWidth = 1;
    [aPath2 stroke];

}


@end
