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

@interface AddGasViewController () <UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *gasPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *dosePickerView;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *isContinuous;

@end

@implementation AddGasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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
    NSLog(@"%ld", [self.gasPickerView selectedRowInComponent:0]);
    NSString *value = [NSString stringWithFormat:@"%ld%i.%i%i%i",(long)[self.dosePickerView selectedRowInComponent:0], [self.dosePickerView selectedRowInComponent:1],[self.dosePickerView selectedRowInComponent:3],[self.dosePickerView selectedRowInComponent:4],[self.dosePickerView selectedRowInComponent:5]];
    double d = [value doubleValue];
    NSNumberFormatter *doubleValF = [[NSNumberFormatter alloc] init];
    doubleValF.usesSignificantDigits = YES;
}


-(void)turnSwitchOn {
    [self.isContinuous setSelected:TRUE];
}

-(void)turnSwitchOff {
    [self.isContinuous setSelected:FALSE];
}

@end
