//
//  TimeScrollView.m
//  iCare
//
//  Created by Billy Bray on 10/6/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "TimeScrollView.h"

const NSTimeInterval ONE_DAY_IN_SECONDS = 60*60*24;
const NSTimeInterval ONE_DAY_IN_MINUTES = 60*24;

@interface TimeScrollView ()<UIScrollViewDelegate>
@property NSDate* date;
@property NSDateFormatter* formatter;
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
        self.formatter = [[NSDateFormatter alloc] init];
        [self.formatter setDateStyle:NSDateFormatterMediumStyle];
    }
    return self;
}



- (void)drawRect:(CGRect)rect {
    NSAssert(_pxPerMinute > 0, @"pxPerMinute must be larger than 0 is: %f",_pxPerMinute);
    int min = [self xCoordToMinutes:0];
    min -= min % 15;
    for ( ; [self minutesToXCoord:min] < self.bounds.size.width+50; min+=15){
        [self drawMinutes:min];
        if (min == 0){
           
        }
    }
    [self drawText:[_formatter stringFromDate:self.date] at:CGPointMake(self.frame.size.width/2-100, 0)];
    
}

-(void)drawMinutes:(int)minutes{
    int x = [self minutesToXCoord:minutes];
    minutes %= 24*60;
    int hours = minutes/60;
    minutes %= 60;
    
    NSString* text = [NSString stringWithFormat:@"%02d:%02d",hours,minutes];
    
    [self drawText:text at:CGPointMake(x, self.bounds.size.height/2)];
}

-(void)drawText:(NSString*)text at:(CGPoint) p{
    p = CGPointMake(p.x + self.bounds.origin.x, p.y + self.bounds.origin.y );
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
    return ((int)( (x + self.contentOffset.x) / _pxPerMinute ));
}

-(int)dateToXCoord:(NSDate*)date
{
    int result = [self minutesToXCoord:[self getMinutesFromDate:date]];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *c = [calendar components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
    date = [calendar dateFromComponents:c];
    
    NSDateComponents *components = [calendar components:NSDayCalendarUnit
                                               fromDate:date
                                                 toDate:self.date
                                                options:NSWrapCalendarComponents];
        
    NSInteger diffDays = [components day];
    if (self.contentOffset.x > (ONE_DAY_IN_MINUTES-75)*_pxPerMinute &&
        [self getMinutesFromDate:date] < 75){
        diffDays += 2;
    }
    if (self.contentOffset.x)
    result += ONE_DAY_IN_MINUTES * _pxPerMinute * diffDays;
    return result;
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
    int minutes = [self getMinutesFromDate:date];
    minutes -= minutes % 15;
    [self setContentOffset:CGPointMake(minutes*_pxPerMinute, self.contentOffset.y)];
    [self setNeedsDisplay];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSDayCalendarUnit|NSMonthCalendarUnit|NSYearCalendarUnit) fromDate:date];
    date = [calendar dateFromComponents:components];
    self.date = date;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int maxX = 24*60*_pxPerMinute;
    if (self.contentOffset.x < 0 ){
        [self setContentOffset:CGPointMake(self.contentOffset.x+maxX, self.contentOffset.y)];
        self.date = [self.date dateByAddingTimeInterval:-ONE_DAY_IN_SECONDS];
    } else if (self.contentOffset.x > maxX){
        [self setContentOffset:CGPointMake(self.contentOffset.x-maxX, self.contentOffset.y)];
        self.date = [self.date dateByAddingTimeInterval:ONE_DAY_IN_SECONDS];
    }
    [self setNeedsDisplay];
    if (self.onScroll){
        self.onScroll();
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (velocity.x == 0) {
        if (((int)self.contentOffset.x) % (int)(15*_pxPerMinute) < 15*_pxPerMinute/2) {
            velocity.x = -0.01;
        } else {
            velocity.x = 0.01;
        }
    }
    int extraIntervals = (int)(ABS(velocity.x) * 3);
    NSLog(@"velocity: %f", velocity.x);
    if (velocity.x < 0){
        targetContentOffset->x = self.contentOffset.x - ((int)self.contentOffset.x) % (int)(15*_pxPerMinute) - 15*_pxPerMinute*extraIntervals;
    } else if( velocity.x > 0 ){
        targetContentOffset->x = self.contentOffset.x - ((int)self.contentOffset.x) % (int)(15*_pxPerMinute) + 15*_pxPerMinute + 15*_pxPerMinute*extraIntervals;
        
    }
}



@end
