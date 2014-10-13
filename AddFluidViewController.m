//
//  AddFluidViewController.m
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "AddFluidViewController.h"
#import "BBData.h"
#import "BBCheckBox.h"
#import "NumericPickerAdapter.h"
#import "Agent.h"
#import "IntraOp.h"
#import "BBUtil.h"

@interface AddFluidViewController ()
@property (weak, nonatomic) IBOutlet UIPickerView *fluidPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *dosePickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *intervalPickerView;
@property (weak, nonatomic) IBOutlet BBCheckBox *isContinuous;
@property (weak, nonatomic) IBOutlet UIButton *stopButton;

@property IntraOp *intraOp;
@property NumericPickerAdapter* dosePickerAdapter;
@property (copy)void (^completionBlock)(void);
@property NSArray *intervalArray;
@end

@implementation AddFluidViewController


- (instancetype)initWithIntraOp:(IntraOp*)intraOp completion:(void (^)(void))completionBlock
{
    self = [super init];
    if (self) {
        self.intraOp = intraOp;
        self.completionBlock = completionBlock;
        _intervalArray = @[@"5",@"10",@"15"];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dosePickerAdapter = [[NumericPickerAdapter alloc] initWithPickerView:self.dosePickerView format:@"ddddu", @[@"cc"], nil];
    
    if (self.agent) {
        NSLog(@"Agent: %@",self.agent );
        [self.dosePickerAdapter setFloatValue:self.agent.dose];
        [self.dosePickerAdapter setUnit:self.agent.unit];
        if ([self.agent.continuous boolValue] && !self.agent.endTime){
            self.stopButton.hidden = NO;
        }
        for (int i = 0; i < [BBData fluids].count; i++){
            if ([[[BBData fluids] objectAtIndex:i] isEqualToString:self.agent.name]){
                [self.fluidPickerView selectRow:i inComponent:0 animated:NO];
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
    NSString *name = [self pickerView:self.fluidPickerView titleForRow:[self.fluidPickerView selectedRowInComponent:0] forComponent:0];
    NSString *interval = [self pickerView:self.intervalPickerView titleForRow:[self.intervalPickerView selectedRowInComponent:0] forComponent:0];
    

    
    if (!self.agent) {
        self.agent = (Agent*)[BBUtil newCoreDataObjectForEntityName:@"Agent"];
        [self.intraOp addAgentObject:self.agent];
        self.agent.startTime = [NSDate date];
    }
    self.agent.name = name;
    self.agent.dose = value;
    self.agent.unit = unit;
    self.agent.interval = interval;
    self.agent.continuous = [NSNumber numberWithBool:self.isContinuous.selected];
    self.agent.type = @"Fluid";
    for (Agent *a in self.intraOp.agent) {
        if (a!=self.agent && [a.name isEqualToString:self.agent.name] && [a.unit isEqualToString:self.agent.unit] && !a.endTime && [a.continuous boolValue]) {
            a.endTime = [NSDate date];
        }
    }
    [BBUtil saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
    self.completionBlock();
}

- (IBAction)stopContinous:(id)sender {
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
    if (pickerView == self.fluidPickerView){
        return [BBData fluids].count;
    } else if (pickerView == self.intervalPickerView) {
        return self.intervalArray.count;
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.fluidPickerView){
        return [[BBData fluids] objectAtIndex:row];
    } else if (pickerView == self.intervalPickerView) {
        return [self.intervalArray objectAtIndex:row];
    }
    
    return 0;
}
@end
