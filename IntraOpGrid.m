//
//  IntraOpGrid.m
//  iCare
//
//  Created by Billy Bray on 10/2/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "IntraOpGrid.h"
#define START_X 155
#define START_Y 0
#define VERTICAL_LINE_WIDTH 110
@implementation IntraOpGrid

- (void)drawRect:(CGRect)rect {
    
    UIBezierPath *aPath = [UIBezierPath bezierPath];
    
    int numVerticalLines = 0;
    int currentColumnX = START_X;
    while (numVerticalLines < 6) {
        [aPath moveToPoint:CGPointMake(currentColumnX, self.bounds.origin.y)];
        [aPath addLineToPoint:CGPointMake(currentColumnX, self.bounds.size.height)];
        [aPath stroke];
        numVerticalLines += 1;
        currentColumnX += VERTICAL_LINE_WIDTH;
    }
//    [aPath moveToPoint:CGPointMake(xOrigin, yOrigin)];
//    while (currentLineY < maxY) {
//        [aPath moveToPoint:CGPointMake(xOrigin, currentLineY)];
//        [aPath addLineToPoint:CGPointMake(maxX, currentLineY)];
//        [aPath stroke];
//        currentLineY += 20;
//    }
    
}


@end
