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
#import "Agent.h"
#import "BBUtil.h"

@interface AddGasViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *gasPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *dosePickerView;
@property (weak, nonatomic) IBOutlet BBCheckBox *isContinuous;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property NumericPickerAdapter* dosePickerAdapter;
@property (copy)void (^completionBlock)(void);
@end

@implementation AddGasViewController

- (instancetype)initWithIntraOp:(IntraOp*)intraOp completion:(void (^)(void))completionBlock
{
    self = [super init];
    if (self) {
        self.intraOp = intraOp;
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dosePickerAdapter = [[NumericPickerAdapter alloc] initWithPickerView:self.dosePickerView format:@"ddd.ddu/u", @[@"mg",@"mcg",@"ml", @""],@[@"mg",@"mcg",@"ml"], nil];
    if (self.agent) {
        [self.dosePickerAdapter setFloatValue:self.agent.dose];
        [self.dosePickerAdapter setUnit:self.agent.unit];
        if ([self.agent.continuous boolValue] && !self.agent.endTime){
            self.stopButton.hidden = NO;
        } else {
            NSLog(@"continuous: %@ startTime:%@ endTime: %@",self.agent.continuous, self.agent.startTime, self.agent.endTime);
        }
        for (int i; i < [BBData gases].count; i++){
            if ([[[BBData gases] objectAtIndex:i] isEqualToString:self.agent.name]){
                [self.gasPickerView selectRow:i inComponent:0 animated:NO];
                break;
            }
        }
        self.isContinuous.selected = [self.agent.continuous boolValue];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    NSString *value = [self.dosePickerAdapter getValue];
    NSString *unit = [self.dosePickerAdapter getUnit];
    NSString *gas = [self pickerView:self.gasPickerView titleForRow:[self.gasPickerView selectedRowInComponent:0] forComponent:0];
    
    if (!self.agent) {
        self.agent = (Agent*)[BBUtil newCoreDataObjectForEntityName:@"Agent"];
        [self.intraOp addAgentObject:self.agent];
        self.agent.startTime = [NSDate date];
    }
    self.agent.name = gas;
    self.agent.dose = value;
    self.agent.unit = unit;
    self.agent.continuous = [NSNumber numberWithBool:self.isContinuous.selected];

    self.agent.type = @"Gas";
    for (Agent *a in self.intraOp.agent) {
        if (a!=self.agent && [a.name isEqualToString:self.agent.name] && [a.unit isEqualToString:self.agent.unit] && !a.endTime && [a.continuous boolValue]) {
            a.endTime = [NSDate date];
        }
    }
    [BBUtil saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.completionBlock();
}

- (IBAction)stopContinuousGas:(id)sender {
    self.agent.endTime = [NSDate date];
    self.stopButton.hidden = YES;
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
