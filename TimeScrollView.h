//
//  TimeScrollView.h
//  iCare
//
//  Created by Billy Bray on 10/6/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeScrollView : UIScrollView
@property double pxPerMinute;
@property (copy)void (^onScroll)(void);

-(void)setStartTime:(NSDate*)date;

-(int)xCoordToMinutes:(int)x;
-(int)minutesToXCoord:(int) minutes;
-(int)dateToXCoord:(NSDate*)date;

@end
