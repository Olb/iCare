//
//  AddGasViewController.m
//  iCare
//
//  Created by Billy Bray on 10/5/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "AddGasViewController.h"
#import "BBData.h"
#import "BBCheckBox.h"
#import "NumericPickerAdapter.h"

@interface AddGasViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *gasPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *dosePickerView;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *isContinuous;

@property NumericPickerAdapter* gasPickerAdapter;

@end

@implementation AddGasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.gasPickerAdapter = [[NumericPickerAdapter alloc] initWithPickerView:self.dosePickerView format:@"ddd.ddu/u", @[@"mg",@"mcg",@"ml", @""],@[@"mg",@"mcg",@"ml"], nil];
}

- (IBAction)continuous:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSString *value = [self.gasPickerAdapter getValue];
    NSString *unit = [self.gasPickerAdapter getUnit];
    NSLog(@"Value: '%@' Unit:'%@'", value, unit);
    NSNumberFormatter *doubleValF = [[NSNumberFormatter alloc] init];
    doubleValF.usesSignificantDigits = YES;
}


-(void)turnSwitchOn {
    [self.isContinuous setSelected:TRUE];
}

-(void)turnSwitchOff {
    [self.isContinuous setSelected:FALSE];
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [BBData gases].count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[BBData gases] objectAtIndex:row];
}

@end
