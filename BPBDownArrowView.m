//
//  BPBDownArrowView.m
//  iCare2
//
//  Created by billy bray on 6/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BPBDownArrowView.h"

@implementation BPBDownArrowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [super drawRect:rect];
    
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetRGBStrokeColor(context, 0.0, 0.0, 255.0, 1.0);
    
    CGPoint center = self.center;
    
    // Draw them with a 2.0 stroke width so they are a bit more visible.
    CGContextSetLineWidth(context, 2.0f);
    
    CGContextMoveToPoint(context, center.x, center.y-5); //start at this point
    
    CGContextAddLineToPoint(context, center.x, center.y+5); //draw to this point
    
    CGContextMoveToPoint(context, center.x-5, center.y-5); // Prepare to draw left side arrow
    
    CGContextAddLineToPoint(context, center.x, center.y+5); // draw left arrow side to center top
    
    CGContextAddLineToPoint(context, center.x+5, center.y-5); // draw right side of arrow
    
    // and now draw the Path!
    CGContextStrokePath(context);
    
    // if selected property is set then we need a circle
    
    if (self.selected) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Set the border width
        CGContextSetLineWidth(context, 2.0);
        
        
        // Set the cicle border color to BLUE
        CGContextSetRGBStrokeColor(context, 0.0, 0.0, 255.0, 1.0);
        
        
        // Draw the circle border
        CGContextStrokeEllipseInRect(context, rect);
    }
}


@end
