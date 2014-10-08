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


@interface AddMeasurementsViewController () <UIPickerViewDataSource>
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




- (IBAction)save:(id)sender {
    NSDate* now = [NSDate date];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:now];
    NSInteger minute = [components minute];
    
    minute -= minute%15;
    [components setMinute:minute];
    now = [calendar dateFromComponents:components];
    
    
    Measurement* m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"Mode";
    m.time = now;
    m.value = [self pickerView:self.mode titleForRow:[self.mode selectedRowInComponent:0] forComponent:0];
    m.type = @"Vent";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"Rate";
    m.time = now;
    m.value = self.rate.text;
    m.type = @"Vent";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"Peak Pressure";
    m.time = now;
    m.value = self.peakPressure.text;
    m.type = @"Vent";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"Peep";
    m.time = now;
    m.value = self.peep.text;
    m.type = @"Vent";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"Temperature";
    m.time = now;
    m.unit = @"C";
    m.value = self.temperature.text;
    m.type = @"Vent";
    [self.intraOp addMeasurementsObject:m];
    /*
     
     @property (weak, nonatomic) IBOutlet UIPickerView *ekg;
     @property (weak, nonatomic) IBOutlet UITextField *o2Inspired;
     @property (weak, nonatomic) IBOutlet UITextField *endTitleCO2;
     @property (weak, nonatomic) IBOutlet UITextField *tidalVolume;
     @property (weak, nonatomic) IBOutlet UITextField *bis;
     @property (weak, nonatomic) IBOutlet UITextField *o2Saturation;
     
     @property (weak, nonatomic) IBOutlet UITextField *ebl;
     @property (weak, nonatomic) IBOutlet UITextField *urine;
     */
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"EKG";
    m.time = now;
    m.value = [self pickerView:self.ekg titleForRow:[self.ekg selectedRowInComponent:0] forComponent:0];
    m.type = @"Vital";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"O2 Inspired";
    m.time = now;
    m.value = self.o2Inspired.text;
    m.type = @"Vital";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"End Title CO2";
    m.time = now;
    m.value = self.endTitleCO2.text;
    m.type = @"Vital";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"Tidal Volume";
    m.time = now;
    m.value = self.tidalVolume.text;
    m.type = @"Vital";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"B.I.S.";
    m.time = now;
    m.value = self.bis.text;
    m.type = @"Vital";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"O2 Saturation";
    m.time = now;
    m.value = self.o2Saturation.text;
    m.type = @"Vital";
    [self.intraOp addMeasurementsObject:m];
    
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"EBL";
    m.time = now;
    m.value = self.ebl.text;
    m.type = @"Ebl";
    [self.intraOp addMeasurementsObject:m];
    
    m = (Measurement*)[BBUtil newCoreDataObjectForEntityName:@"Measurement"];
    m.name = @"Urine";
    m.time = now;
    m.value = self.urine.text;
    m.type = @"Ebl";
    [self.intraOp addMeasurementsObject:m];
    
    [BBUtil saveContext];
    [self dismissViewControllerAnimated:YES completion:nil];
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

@end
