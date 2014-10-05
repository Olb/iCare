//
//  NumericPickerAdapter.m
//  iCare
//
//  Created by Billy Bray on 10/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "NumericPickerAdapter.h"

@interface NumericPickerAdapter ()
@property NSString *format;
@property NSMutableArray *units;
@end

@implementation NumericPickerAdapter


-(instancetype)initWithFormat:(NSString*)format, ... {
    if (self = [super init]) {
        va_list args;
        va_start(args, format);
        _format = format;
        _units = [[NSMutableArray alloc] init];
        for (NSArray *arg = va_arg(args, NSArray*); arg != nil; arg = va_arg(args, NSArray*))
        {
            [_units addObject:arg];
        }
        va_end(args);
    }
    return self;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;

    switch ([self.format characterAtIndex:component]) {
        case '.':
            result = 1;
            break;
        case 'd':
            result = 10;
            break;
        case 'u':{
            int unitsIndex = 0;
            
            for (int i = 0; i < component; i++) {
                char c = [self.format characterAtIndex:i];
                if (c == 'u'){
                    unitsIndex++;
                }
            }
            result = ((NSArray*)[self.units objectAtIndex:unitsIndex]).count;
            break;
        }
        default:
            break;
    }
    
    return result;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.format.length;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *result = 0;
    
    switch ([self.format characterAtIndex:component]) {
        case '.':
            result = @".";
            break;
        case 'd':
            result = [NSString stringWithFormat:@"%ld", row];
            break;
        case 'u':{
            int unitsIndex = 0;
            
            for (int i = 0; i < component; i++) {
                char c = [self.format characterAtIndex:i];
                if (c == 'u'){
                    unitsIndex++;
                }
            }
            result = [[self.units objectAtIndex:unitsIndex] objectAtIndex:row];
            break;
        }
        default:
            NSAssert(false, @"Format string unknown character");
            break;
    }
    return result;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat result = 0.0;
    switch ([self.format characterAtIndex:component]) {
        case '.':
            result = 20.0;
            break;
        case 'd':
            result = 30.0;
            break;
        case 'u':{
            result = 40.0;
            break;
        }
        default:
            NSAssert(false, @"Format string unknown character");
            break;
    }
   
    return result;
}

@end
