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

@interface AddGasViewController () <UITextFieldDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *gasPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *dosePickerView;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *isContinuous;

@property NumericPickerAdapter* dosePickerAdapter;
@property (copy)void (^completionBlock)(void);
@end

@implementation AddGasViewController

- (instancetype)initWithIntraOp:(IntraOp*)intrraOp completion:(void (^)(void))completionBlock
{
    self = [super init];
    if (self) {
        self.intraOp = intrraOp;
        self.completionBlock = completionBlock;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dosePickerAdapter = [[NumericPickerAdapter alloc] initWithPickerView:self.dosePickerView format:@"ddd.ddu/u", @[@"mg",@"mcg",@"ml", @""],@[@"mg",@"mcg",@"ml"], nil];
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
    NSString *value = [self.dosePickerAdapter getValue];
    NSString *unit = [self.dosePickerAdapter getUnit];
    NSString *gas = [self pickerView:self.gasPickerView titleForRow:[self.gasPickerView selectedRowInComponent:0] forComponent:0];
    
    Agent *agent = (Agent*)[BBUtil newCoreDataObjectForEntityName:@"Agent"];
    agent.name = gas;
    agent.dose = value;
    agent.unit = unit;
    agent.startTime = [NSDate date];
    agent.continuous = [NSNumber numberWithBool:self.isContinuous.selected];
    agent.type = @"Gas";
    for (Agent *a in self.intraOp.agent) {
        if ([a.name isEqualToString:agent.name] && [a.unit isEqualToString:agent.unit] && !a.endTime && [a.continuous boolValue]) {
            a.endTime = [NSDate date];
        }
    }
    [self.intraOp addAgentObject:agent];
    [BBUtil saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.completionBlock();
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
