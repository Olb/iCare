//
//  NumericPickerAdapter.h
//  iCare
//
//  Created by Billy Bray on 10/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NumericPickerAdapter : NSObject <UIPickerViewDelegate, UIPickerViewDataSource>

-(instancetype)initWithPickerView:(UIPickerView*)pickerView format:(NSString*)format, ...;
-(NSString*) getValue;
-(NSString*) getUnit;
-(void)setFloatValue:(NSString*)value;
-(void)setUnit:(NSString*)unit;
@end
