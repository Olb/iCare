//
//  AddMeasurementsViewController.m
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "AddMeasurementsViewController.h"
#import "IntraOpViewController.h"
#import "IntraOp.h"
#import "Measurement.h"
#import "BBUtil.h"
#import "TimeScrollView.h"

@interface AddMeasurementsViewController () <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *mode;
@property (weak, nonatomic) IBOutlet UITextField *rate;
@property (weak, nonatomic) IBOutlet UITextField *peakPressure;
@property (weak, nonatomic) IBOutlet UITextField *peep;
@property (weak, nonatomic) IBOutlet UITextField *temperature;

@property (weak, nonatomic) IBOutlet UIPickerView *ekg;
@property (weak, nonatomic) IBOutlet UITextField *o2Inspired;
@property (weak, nonatomic) IBOutlet UITextField *endTitleCO2;
@property (weak, nonatomic) IBOutlet UITextField *tidalVolume;
@property (weak, nonatomic) IBOutlet UITextField *bis;
@property (weak, nonatomic) IBOutlet UITextField *o2Saturation;

@property (weak, nonatomic) IBOutlet UITextField *ebl;
@property (weak, nonatomic) IBOutlet UITextField *urine;

@property IntraOp *intraOp;
@property (copy)void (^completionBlock)(void);
@property NSArray* ekgArray;
@property NSArray* modeArray;
@property NSMutableArray *measurementArray;
@end

@implementation AddMeasurementsViewController


- (instancetype)initWithIntraOp:(IntraOp*)intraOp completion:(void (^)(void))completionBlock
{
    self = [super init];
    if (self) {
        self.intraOp = intraOp;
        self.completionBlock = completionBlock;
        _ekgArray = @[@"A-Fib",@"Asystole",@"NSR",@"V-Tach",@"V-Fib"];
        _modeArray = @[@"Spontaneous",@"Assisted",@"Controller"];
    }
    return self;
}

-(void)viewDidLoad
{
    [super viewDidLoad];
    if (self.measurement) {
        self.measurementArray = [[NSMutableArray alloc] init];
        for (Measurement *m in self.intraOp.measurements) {
            if ([m.time compare:self.measurement.time] != 0 ) {
                continue;
            }
            [self.measurementArray addObject:m];
            if ([m.name isEqualToString:@"Mode"]) {
                for (int i = 0; i < self.modeArray.count; i++) {
                    if ([m.value isEqualToString:[self.modeArray objectAtIndex:i]]) {
                        [self.mode selectRow:i inComponent:0 animated:NO];
                        break;
                    }
                }
            } else if ([m.name isEqualToString:@"Rate"]){
                self.rate.text = m.value;
            } else if ([m.name isEqualToString:@"Peak Pressure"]){
                self.peakPressure.text = m.value;
            } else if ([m.name isEqualToString:@"Peep"]){
                self.peep.text = m.value;
            } else if ([m.name isEqualToString:@"Temperature"]){
                self.temperature.text = m.value;
            } else if ([m.name isEqualToString:@"EKG"]){
                for (int i = 0; i < self.ekgArray.count; i++) {
                    if ([m.value isEqualToString:[self.ekgArray objectAtIndex:i]]) {
                        [self.ekg selectRow:i inComponent:0 animated:NO];
                        break;
                    }
                }
            } else if ([m.name isEqualToString:@"O2 Inspired"]){
                self.o2Inspired.text = m.value;
            } else if ([m.name isEqualToString:@"End Title CO2"]){
                self.endTitleCO2.text = m.value;
            } else if ([m.name isEqualToString:@"Tidal Volume"]){
                self.tidalVolume.text = m.value;
            } else if ([m.name isEqualToString:@"B.I.S."]){
                self.bis.text = m.value;
            } else if ([m.name isEqualToString:@"O2 Saturation"]){
                self.o2Saturation.text = m.value;
            } else if ([m.name isEqualToString:@"EBL"]){
                self.ebl.text = [m.value substringToIndex:[m.value rangeOfString:@"/"].location];
            } else if ([m.name isEqualToString:@"Urine"]){
                self.urine.text = [m.value substringToIndex:[m.value rangeOfString:@"/"].location];
            }
        }
        
    }
}

-(Measurement*)measurementForName:(NSString*)name
{
    for (Measurement *m in self.measurementArray) {
        if ([m.name isEqualToString:name]) {
            return m;
        }
    }
    return nil;
}

- (IBAction)save:(id)sender {
    NSDate* now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:now];
    NSInteger minute = [components minute];
    
    minute -= minute%15;
    [components setMinute:minute];
    now = [calendar dateFromComponents:components];
    
   
    for (Measurement *m in self.intraOp.measurements) {
        if ([m.time compare:now]==0) {
            minute += 15;
            [components setMinute:minute];
            now = [calendar dateFromComponents:components];
        }
    }
    
    Measurement *m = [self measurementForName:@"Mode"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"Mode";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = [self pickerView:self.mode titleForRow:[self.mode selectedRowInComponent:0] forComponent:0];
    m.type = @"Vent";
    
    m = [self measurementForName:@"Rate"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"Rate";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = self.rate.text;
    m.type = @"Vent";
    
    m = [self measurementForName:@"Peak Pressure"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"Peak Pressure";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = self.peakPressure.text;
    m.type = @"Vent";
    
    m = [self measurementForName:@"Peep"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"Peep";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = self.peep.text;
    m.type = @"Vent";
    
    m = [self measurementForName:@"Temperature"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"Temperature";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.unit = @"C";
    m.value = self.temperature.text;
    m.type = @"Vent";
    
    m = [self measurementForName:@"EKG"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"EKG";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = [self pickerView:self.ekg titleForRow:[self.ekg selectedRowInComponent:0] forComponent:0];
    m.type = @"Vital";
    
    m = [self measurementForName:@"O2 Inspired"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"O2 Inspired";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = self.o2Inspired.text;
    m.type = @"Vital";
    
    m = [self measurementForName:@"End Title CO2"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"End Title CO2";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = self.endTitleCO2.text;
    m.type = @"Vital";
    
    m = [self measurementForName:@"Tidal Volume"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"Tidal Volume";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = self.tidalVolume.text;
    m.type = @"Vital";
    
    m = [self measurementForName:@"B.I.S."];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"B.I.S.";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = self.bis.text;
    m.type = @"Vital";
    
    m = [self measurementForName:@"O2 Saturation"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"O2 Saturation";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    m.value = self.o2Saturation.text;
    m.type = @"Vital";
    
    m = [self measurementForName:@"EBL"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"EBL";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
    }
    int previousValueSum = [self.ebl.text intValue];
    for (Measurement *m2 in self.intraOp.measurements) {
        if ([m2.name isEqualToString:@"EBL"] && [m2.time compare:m.time] == NSOrderedAscending) {
            previousValueSum += [[m2.value substringToIndex:[m2.value rangeOfString:@"/"].location] intValue];
        }
    }
    m.value = [NSString stringWithFormat:@"%@/%d", self.ebl.text, previousValueSum] ;
    m.type = @"Ebl";
    
    m = [self measurementForName:@"Urine"];
    if (m == nil) {
        m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
        m.name = @"Urine";
        [self.intraOp addMeasurementsObject:m];
        m.time = now;
        
    }
    previousValueSum = [self.urine.text intValue];
    for (Measurement *m2 in self.intraOp.measurements) {
        if ([m2.name isEqualToString:@"Urine"] && [m2.time compare:m.time] == NSOrderedAscending) {
            previousValueSum += [[m2.value substringToIndex:[m2.value rangeOfString:@"/"].location] intValue];
        }
    }
    m.value = [NSString stringWithFormat:@"%@/%d", self.urine.text, previousValueSum] ;
    m.type = @"Ebl";
    
    [BBUtil saveContext];
    [self dismissViewControllerAnimated:YES completion:^{
        [self.vc.timeScrollView setStartTime:[NSDate date]];
    }];
    self.completionBlock();
    

    
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView == self.ekg){
        return [self.ekgArray objectAtIndex:row];
    } else if (pickerView == self.mode) {
        return [self.modeArray objectAtIndex:row];
    }
    
    return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView == self.ekg){
        return [self.ekgArray count];
    } else if (pickerView == self.mode) {
        return [self.modeArray count];
    }
    return 0;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}

@end
