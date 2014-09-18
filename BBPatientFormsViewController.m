//
//  BBPatientFormsViewController.m
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBPatientFormsViewController.h"
#import "Patient.h"
#import "PreOpEvalTableTableViewController.h"
#import "AnesthesiaRecordController.h"
#import "PatientFormTableAdapter.h"
#import "Operation.h"
#import "BBData.h"
#import "BBAutoCompleteTextField.h"
#import "BPBAppDelegate.h"
#import "OperationsTableAdapter.h"
#import "BBUtil.h"
#import "Form.h"
#import "BBWeightPickerView.h"
#import "BBWeightPickerAdapter.h"

const float POUND_MULTIPLIER = 2.20462262f;

@interface BBPatientFormsViewController () 
@property (weak, nonatomic) IBOutlet UIButton *preOpDateButton;
@property (weak, nonatomic) IBOutlet UITableView *formsTableView;
@property (weak, nonatomic) IBOutlet UIButton *preOpTimeLabel;
@property (weak, nonatomic) IBOutlet UIButton *heightButton;
@property (weak, nonatomic) IBOutlet UIButton *weightButton;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property (weak, nonatomic) IBOutlet BBAutoCompleteTextField *operationTextField;
@property (weak, nonatomic) IBOutlet UITableView *operationTableView;
@property (weak, nonatomic) IBOutlet UILabel *operationTitleLabel;
@property (weak, nonatomic) IBOutlet UIView *operationBackgroundView;
@property (weak, nonatomic) IBOutlet UIPickerView *weightPicker;
@property (strong, nonatomic) IBOutlet UIView *weightPopoverView;
@property (strong, nonatomic) OperationsTableAdapter *operationTableAdapter;
@property (strong, nonatomic) PatientFormTableAdapter *patientAdapter;
@property (nonatomic) BOOL useKG;
@property Operation *selectedOperation;
@property (weak, nonatomic) IBOutlet UIButton *weightUnitButton;
@property (strong, nonatomic) BBWeightPickerAdapter *weightPickerAdapter;
@property (weak, nonatomic) IBOutlet UIButton *heightUnitButton;

@end

@implementation BBPatientFormsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
     _weightPickerAdapter = [[BBWeightPickerAdapter alloc] init];
    _useKG = YES;
    
    _operationBackgroundView.hidden = YES;
    _operationTableAdapter = [[OperationsTableAdapter alloc] init];
    _operationTableAdapter.patient = self.patient;
    _operationTableAdapter.delegate = self;
    
    _operationTableView.delegate = _operationTableAdapter;
    _operationTableView.dataSource = _operationTableAdapter;
    
    _patientAdapter = [[PatientFormTableAdapter alloc] init];
    
    _formsTableView.delegate = _patientAdapter;
    _formsTableView.dataSource = _patientAdapter;
    
    [_operationTextField setAutoCompleteData:[BBData procedures]];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = [NSString stringWithFormat:@"%@, %@", self.patient.lastName, self.patient.firstName];
}

#pragma mark - Actions

- (IBAction)addSelectedOperation:(id)sender {
    
    NSString *operationNameToSave;
    for (NSString *s in [BBData procedures]) {
        if ([self.operationTextField.text caseInsensitiveCompare:s] == NSOrderedSame) {
            operationNameToSave = s;
            break;
        }
    }
    if (!operationNameToSave) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Invalid Operation"
                                                            message:@"The operation entered is not a valid operation"
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        return;
    }
    
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    Operation *operation = [NSEntityDescription insertNewObjectForEntityForName:@"Operation"
                                                         inManagedObjectContext:context];
    operation.name = self.operationTextField.text;
    operation.preOpDate = [NSDate date];
    
    [self.patient addOperationsObject:operation];
    
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"ERROR on context save: %@",[error description]);
        [NSException raise:@"Error on context save" format:@"Message: %@",[error description]];
    }
    
    self.operationTextField.text = @"";
    [self.operationTableView reloadData];
   
}
- (IBAction)preOpDate:(id)sender {
   
}
- (IBAction)preOpTime:(id)sender {
}
- (IBAction)height:(id)sender {
}
- (IBAction)heightUnit:(id)sender {
    
}
- (IBAction)weight:(id)sender {
    [[NSBundle mainBundle] loadNibNamed:@"WeightPicker" owner:self options:nil];
    self.weightPopoverView.center = self.view.center;
    
    [self.view addSubview:self.weightPopoverView];
    _weightPicker.dataSource = _weightPickerAdapter;
    _weightPicker.delegate = _weightPickerAdapter;
    if (!self.selectedOperation.weight) {
        [self.weightPicker selectRow:100 inComponent:1 animated:NO];
    } else {
        for (int i = 0; i < 5 ; i++) {
            [self.weightPicker selectRow:([self.selectedOperation.weight characterAtIndex:i]) inComponent:i animated:NO];
        }
    }
    
}
- (IBAction)weightUnit:(UIButton*)sender {
    self.useKG = !self.useKG;
    if (self.useKG) {
        [sender setTitle:@"kg" forState:UIControlStateNormal];
    } else {
        [sender setTitle:@"lb" forState:UIControlStateNormal];
    }
    
    [self updateOperationView];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.navigationItem.title = [NSString stringWithFormat:@"Forms"];

    if ([[segue identifier] isEqualToString:@"FormsToPreOpEvalSegue"]) {
        PreOpEvalTableTableViewController *vc = [segue destinationViewController];
        for (Form *f in self.selectedOperation.forms) {
            if ([f.title isEqualToString:@"AnesthesiaRecord"]) {
                vc.form = f;
            }
        }
        if (!vc.form) {
            Form *f = (Form*)[BBUtil newCoreDataObjectForEntityName:@"Form"];
            f.title = @"AnesthesiaRecord";
            [self.selectedOperation addFormsObject:f];
            vc.form = f;
        }
    }
    if ([[segue identifier] isEqualToString:@"PatientFormsToAnesthesiaRecordSegue"]) {
        AnesthesiaRecordController *vc = [segue destinationViewController];
        for (Form *f in self.selectedOperation.forms) {
            if ([f.title isEqualToString:@"AnesthesiaRecord"]) {
                vc.form = f;
            }
        }
        if (!vc.form) {
            Form *f = (Form*)[BBUtil newCoreDataObjectForEntityName:@"Form"];
            f.title = @"AnesthesiaRecord";
            [self.selectedOperation addFormsObject:f];
            vc.form = f;
        }
    }
}

#pragma mark - Delegate methods
-(void) operationSelected:(Operation*)operation fromPatient:(Patient*)patient
{
    self.selectedOperation = operation;
    [self updateOperationView];
}

-(void) operationDeleted:(Operation*)operation
{
    if (operation == self.selectedOperation) {
        self.operationBackgroundView.hidden = YES;
    }
}

-(void) updateOperationView
{
    [self.preOpDateButton setTitle:[BBUtil formatDate:_selectedOperation.preOpDate] forState:UIControlStateNormal];
    [self.preOpTimeLabel setTitle:[BBUtil formatTime:_selectedOperation.preOpDate] forState:UIControlStateNormal];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSYearCalendarUnit
                                                 fromDate: _patient.birthdate toDate: _selectedOperation.preOpDate options: 0];
    NSString *age = [NSString stringWithFormat:@"%d", [components year]];
    
    [self.ageLabel setText:age];
    NSString *weight;
    NSString *height;
    if (!_selectedOperation.weight || [_selectedOperation.weight isEqual:@""]) {
        weight = @"##";
    } else {
        if (self.useKG) {
            weight = _selectedOperation.weight;
        } else {
            weight = [NSString stringWithFormat:@"%.0f",[_selectedOperation.weight intValue]*POUND_MULTIPLIER];
        }
        
    }
    if (!_selectedOperation.height || [_selectedOperation.height isEqual:@""]) {
        height = @"##";
    } else {
        height = _selectedOperation.height;
    }
    [self.weightButton setTitle:weight forState:UIControlStateNormal];
    [self.heightButton setTitle:height forState:UIControlStateNormal];
    self.operationTitleLabel.text = self.selectedOperation.name;
    self.operationBackgroundView.hidden = NO;
    
}

#pragma mark - Popovers
- (IBAction)cancelWeight:(id)sender {
    [self.weightPopoverView removeFromSuperview];
}

- (IBAction)saveWeight:(id)sender {
    NSMutableString *weightString = [[NSMutableString alloc] init];

    if ([self.weightPicker selectedRowInComponent:5] == 0) {
        for (int i = 0; i < 3 ; i++) {
            [weightString appendString:[NSString stringWithFormat:@"%ld", (long)[self.weightPicker selectedRowInComponent:i]]];
        }
        [weightString appendString:@"."];
        [weightString appendString:[NSString stringWithFormat:@"%ld", (long)[self.weightPicker selectedRowInComponent:4]]];
        self.selectedOperation.weight = [NSString stringWithFormat:@"%.1f", [weightString floatValue]];
        
    } else {
        for (int i = 0; i < 3 ; i++) {
            [weightString appendString:self.selectedOperation.weight = [NSString stringWithFormat:@"%ld", (long)[self.weightPicker selectedRowInComponent:i]]];
        }
        [weightString appendString:@"."];
        [weightString appendString:[NSString stringWithFormat:@"%ld", (long)[self.weightPicker selectedRowInComponent:4]]];
        
        float lbValue = [weightString floatValue];
        self.selectedOperation.weight = [NSString stringWithFormat:@"%.1f", (lbValue / POUND_MULTIPLIER)];
    }
    
    [self updateOperationView];
    [BBUtil saveContext];
    [self.weightPopoverView removeFromSuperview];
}

- (IBAction)kgTogglePopover:(UIButton*)sender {
    self.useKG = !self.useKG;
    if (self.useKG) {
        [sender setTitle:@"kg" forState:UIControlStateNormal];
        NSInteger lbAmount = [self.weightPicker selectedRowInComponent:0];
        NSInteger kgAmount = (lbAmount/POUND_MULTIPLIER)+1;
        [self.weightPicker selectRow:kgAmount inComponent:0 animated:NO];
    } else {
        [sender setTitle:@"lb" forState:UIControlStateNormal];
        NSInteger kgAmount = [self.weightPicker selectedRowInComponent:0];
        NSInteger lbAmount = (kgAmount*POUND_MULTIPLIER)-1;
        [self.weightPicker selectRow:lbAmount inComponent:0 animated:NO];
    }
    [self.weightPicker reloadAllComponents];
}
     
     


@end
