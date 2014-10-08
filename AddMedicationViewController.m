//
//  AddMedicationViewController.m
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "AddMedicationViewController.h"
#import "BBData.h"
#import "BBCheckBox.h"
#import "NumericPickerAdapter.h"
#import "Agent.h"
#import "IntraOp.h"
#import "BBUtil.h"

@interface AddMedicationViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *medicationPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *dosePickerView;
@property (weak, nonatomic) IBOutlet BBCheckBox *isContinuous;

@property IntraOp *intraOp;
@property NumericPickerAdapter* dosePickerAdapter;
@property (copy)void (^completionBlock)(void);
@end

@implementation AddMedicationViewController

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
    self.dosePickerAdapter = [[NumericPickerAdapter alloc] initWithPickerView:self.dosePickerView format:@"ddd.ddu/u/u", @[@"mcg"],@[@"kg",@""],@[@"",@"min",@"hr"], nil];
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
    NSString *name = [self pickerView:self.medicationPickerView titleForRow:[self.medicationPickerView selectedRowInComponent:0] forComponent:0];
    
    Agent *agent = (Agent*)[BBUtil newCoreDataObjectForEntityName:@"Agent"];
    agent.name = name;
    agent.dose = value;
    agent.unit = unit;
    agent.startTime = [NSDate date];
    agent.continuous = [NSNumber numberWithBool:self.isContinuous.selected];
    agent.type = @"Medication";
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
    return [BBData medications].count;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[BBData intraOpMedications] objectAtIndex:row];
}

@end
