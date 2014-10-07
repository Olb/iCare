//
//  TimeScrollView.m
//  iCare
//
//  Created by Billy Bray on 10/6/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "TimeScrollView.h"
@interface TimeScrollView ()<UIScrollViewDelegate>

@end

@implementation TimeScrollView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.contentSize = CGSizeMake(20000, self.frame.size.height);
        self.delegate = self;
        [self setShowsHorizontalScrollIndicator:NO];
        [self setShowsVerticalScrollIndicator:NO];
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    NSAssert(_pxPerMinute > 0, @"pxPerMinute must be larger than 0 is: %f",_pxPerMinute);
    int min = [self xCoordToMinutes:0];
    min -= min % 15;
    for ( ; [self minutesToXCoord:min] < self.bounds.size.width+50; min+=15){
        [self drawMinutes:min];
    }
    
}

-(void)drawMinutes:(int)minutes{
    int x = [self minutesToXCoord:minutes];
    minutes %= 24*60;
    int hours = minutes/60;
    minutes %= 60;
    
    NSString* text = [NSString stringWithFormat:@"%02d:%02d",hours,minutes];
    
    [self drawText:text at:CGPointMake(x+self.bounds.origin.x,self.bounds.origin.y + self.bounds.size.height/2)];
}

-(void)drawText:(NSString*)text at:(CGPoint) p{
    UIFont *font;
    font = [UIFont systemFontOfSize:12.0f];
    
    NSDictionary *attr = [[NSDictionary alloc] initWithObjectsAndKeys: font, NSFontAttributeName,
                          nil];
    
    CGSize size = [text sizeWithAttributes:
                   @{NSFontAttributeName:
                         font}];
    
    CGRect frameRect = CGRectMake(p.x, p.y, size.width, size.height);
    
    [text drawInRect:frameRect withAttributes:attr];
}

-(int)minutesToXCoord:(int) minutes{
//    NSLog(@"min: %d contentOffset: %f  result: %f", minutes, self.contentOffset.x, minutes * _pxPerMinute - self.contentOffset.x);
    return (int)(minutes * _pxPerMinute - self.contentOffset.x);
}

-(int)xCoordToMinutes:(int)x
{
//    NSLog(@"x: %d contentOffset: %f  result: %f", x, self.contentOffset.x, (x + self.contentOffset.x) / _pxPerMinute);
    return (int)( (x + self.contentOffset.x) / _pxPerMinute );
}

-(int)dateToXCoord:(NSDate*)date
{
    return [self minutesToXCoord:[self getMinutesFromDate:date]];
}

-(int)getMinutesFromDate:(NSDate*)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:date];
    NSInteger hour = [components hour];
    NSInteger minute = [components minute];
    
    return  (int)(hour*60 + minute);
}
-(void)setStartTime:(NSDate*)date
{
    [self setContentOffset:CGPointMake([self minutesToXCoord:[self getMinutesFromDate:date]], self.contentOffset.y)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int maxX = 24*60*_pxPerMinute;
    if (self.contentOffset.x < 0 ){
        [self setContentOffset:CGPointMake(self.contentOffset.x+maxX, self.contentOffset.y)];
    } else if (self.contentOffset.x > maxX){
        [self setContentOffset:CGPointMake(self.contentOffset.x-maxX, self.contentOffset.y)];
    }
    [self setNeedsDisplay];
}

@end
