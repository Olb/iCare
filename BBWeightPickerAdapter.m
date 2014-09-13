//
//  BBWeightPickerAdapter.m
//  iCare2
//
//  Created by Billy Bray on 9/12/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBWeightPickerAdapter.h"

@implementation BBWeightPickerAdapter

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 6;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSInteger result;
    if (component == 5) {
        result = 2;
    } else {
        result = 10;
    }
    return result;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
     NSString *result;
    if (component == 3) {
        result = @".";
    } else if (component == 5){
        if (row == 0) {
            result = @"kg";
        } else {
            result = @"lb";
        }
    } else {
        result = [NSString stringWithFormat:@"%ld", (long)row];
    }
   
    return result;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    CGFloat result = 0.0;
    if (component == 5) {
        result = 40.0;
    } else {
        result = 36.0;
    }
    return result;
}
@end
