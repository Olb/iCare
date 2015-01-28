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
@property UIPickerView *pickerView;
@end

@implementation NumericPickerAdapter


-(instancetype)initWithPickerView:(UIPickerView*)pickerView format:(NSString*)format, ... {
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
        
        pickerView.delegate = self;
        pickerView.dataSource = self;
        _pickerView = pickerView;
    }
    NSLog(@"Created numeric picker view with %ld units.",_units.count);
    return self;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result = 0;

    switch ([self.format characterAtIndex:component]) {
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
            result = 1;
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
    char c = [self.format characterAtIndex:component];
    switch (c) {
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
            result = [NSString stringWithFormat:@"%c", c];
            break;
    }
    return result;
}

-(CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    CGFloat result = 0.0;
    switch ([self.format characterAtIndex:component]) {
        case 'd':
            result = 30.0;
            break;
        case 'u':{
            result = 80.0;
            break;
        }
        default:
            result = 15.0;
            break;
    }
   
    return result;
}

-(NSString*) getValue{
    NSMutableString *value = [[NSMutableString alloc] init];
    
    for (int i = 0; i < self.format.length; i++) {
        if ([self.format characterAtIndex:i] == 'd' ||
            [self.format characterAtIndex:i] == '.' ) {
            [value appendString:[self pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:i] forComponent:i]];
        } else {
            break;
        }
    }
    
    double d = [value doubleValue];
    NSNumberFormatter *doubleValF = [[NSNumberFormatter alloc] init];
    doubleValF.usesSignificantDigits = YES;
    return [doubleValF stringFromNumber:[NSNumber numberWithDouble:d]];
}


-(NSString*) getUnit{
    NSMutableString *value = [[NSMutableString alloc] init];
    BOOL firstUnit = true;
    for (int i = 0; i < self.format.length; i++) {
        if ([self.format characterAtIndex:i] == 'u') {
            NSString *unit = [self pickerView:self.pickerView titleForRow:[self.pickerView selectedRowInComponent:i] forComponent:i];
            if (!firstUnit){
                [value appendString:@"/"];
            }
            [value appendString:unit];
            firstUnit = false;
        }
    }
    
    return value;
}


-(void)setFloatValue:(NSString*)val{
    int value = [[val stringByReplacingOccurrencesOfString:@"." withString:@""] intValue];
    int divPow = (int)[self.format componentsSeparatedByString:@"d"].count - 2;
    for (int i = 0; i < self.format.length; i++) {
        if ([self.format characterAtIndex:i] == 'd'){
            [self.pickerView selectRow:( value/ lroundf(pow(10, divPow)) )%10 inComponent:i animated:NO];
            divPow--;
        }
    }
    
}

-(void)setUnit:(NSString*)unit{
    NSArray *units = [unit componentsSeparatedByString:@"/"];
    int unitIndex = 0;
    for (int i = 0; i < self.format.length; i++) {
        if ([self.format characterAtIndex:i] == 'u'){
            for (int j = 0; j < [[self.units objectAtIndex:unitIndex] count]; j++){
                if ([[[self.units objectAtIndex:unitIndex] objectAtIndex:j]  isEqualToString:[units objectAtIndex:unitIndex]]){
                    [self.pickerView selectRow:j inComponent:i animated:NO];
                    unitIndex++;
                    break;
                }
            }
        }
    }
    
}

@end
