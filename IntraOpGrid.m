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
    int currentColumnX = START_X;
    
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
    float lineSeperation = ( self.tableFour.frame.origin.y - ( self.tableThree.frame.origin.y + self.tableThree.bounds.size.height) ) / 21; // 21 lines
    int numLinesDrawn = 0;
    float xCoord = ((CGPoint)[self.tableThree convertPoint:self.tableThree.bounds.origin toView:self]).x + START_X;
    float yCoord = ((CGPoint)[self.tableThree convertPoint:self.tableThree.bounds.origin toView:self]).y + self.tableThree.bounds.size.height + lineSeperation;
    while ( numLinesDrawn < 21 ) {
        [aPath moveToPoint:CGPointMake(xCoord , yCoord )];
        [aPath addLineToPoint:CGPointMake( xCoord + self.tableThree.bounds.size.width, yCoord )];
        yCoord += lineSeperation;
        numLinesDrawn++;
    }
    aPath.lineWidth = 1;
    [[UIColor lightGrayColor] setStroke];
    [aPath stroke];
}


@end
