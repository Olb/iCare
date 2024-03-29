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
#import "IntraOpViewController.h"
#import "PostOpTableViewController.h"
#import "IntraOp.h"
#import "BBDatePickerViewController.h"
#import "EditPatientViewController.h"

const float POUND_MULTIPLIER = 2.20462262f;

typedef enum : NSUInteger {
    kg,
    lb,
} WeightUnit;

typedef enum : NSUInteger {
    cm,
    ft,
} HeightUnit;

@interface BBPatientFormsViewController () <UITextFieldDelegate, BBDatePickerViewControllerDelegate> {
    BBDatePickerViewController *dateContent;
    UIPopoverController *datePopover;
}

@property (weak, nonatomic) IBOutlet UIButton *preOpDateButton;
@property (weak, nonatomic) IBOutlet UITextField *preOpTimeTextField;
@property (weak, nonatomic) IBOutlet UITableView *formsTableView;
@property (weak, nonatomic) IBOutlet UITextField *weightTextField;
@property (weak, nonatomic) IBOutlet UITextField *heightTextField;

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
@property (nonatomic) BOOL useCM;
@property Operation *selectedOperation;
@property (weak, nonatomic) IBOutlet UIButton *weightUnitButton;
@property (strong, nonatomic) BBWeightPickerAdapter *weightPickerAdapter;
@property (weak, nonatomic) IBOutlet UIButton *heightUnitButton;
@property (weak, nonatomic) IBOutlet UIView *selectedOperationBackgroundView;

@end

@implementation BBPatientFormsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    self.selectedOperationBackgroundView.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:233.0/255.0 blue:199.0/255.0 alpha:1.0];

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
    [self.operationTextField resignFirstResponder];
    self.operationTextField.text = @"";
    [self.operationTableView reloadData];
   
}
- (IBAction)preOpDate:(id)sender {
   
}
- (IBAction)preOpTime:(id)sender {
}

- (IBAction)heightUnit:(id)sender {
    // TODO - see weightUnit
}

- (IBAction)weightUnit:(UIButton*)sender {
    self.useKG = !self.useKG;
    if (self.useKG) {
        [sender setTitle:@"kg" forState:UIControlStateNormal];
        self.weightTextField.text = [self getWeight];
    } else {
        [sender setTitle:@"lb" forState:UIControlStateNormal];
        self.heightTextField.text = [self getHeight];
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
            if ([f.title isEqualToString:@"Pre-Operative Anesthesia Evaluation"]) {
                vc.form = f;
            }
        }
        if (!vc.form) {
            Form *f = (Form*)[BBUtil newCoreDataObjectForEntityName:@"Form"];
            f.title = @"Pre-Operative Anesthesia Evaluation";
            [self.selectedOperation addFormsObject:f];
            vc.form = f;
        }
    }
    if ([[segue identifier] isEqualToString:@"PatientFormsToAnesthesiaRecordSegue"]) {
        AnesthesiaRecordController *vc = [segue destinationViewController];
        for (Form *f in self.selectedOperation.forms) {
            if ([f.title isEqualToString:@"Anesthesia Record"]) {
                vc.form = f;
            }
        }
        if (!vc.form) {
            Form *f = (Form*)[BBUtil newCoreDataObjectForEntityName:@"Form"];
            f.title = @"Anesthesia Record";
            [self.selectedOperation addFormsObject:f];
            vc.form = f;
        }
    }
    if ([[segue identifier] isEqualToString:@"IntraOp Segue"]) {
        IntraOpViewController *vc = [segue destinationViewController];
        if (!self.selectedOperation.intraOp) {
            IntraOp *intraOp = (IntraOp*)[BBUtil newCoreDataObjectForEntityName:@"IntraOp"];
            self.selectedOperation.intraOp = intraOp;
            [BBUtil saveContext];
        }
        vc.intraOp = self.selectedOperation.intraOp;
    }
    if ([[segue identifier] isEqualToString:@"Post Op Segue"]) {
        PostOpTableViewController *vc = [segue destinationViewController];
        for (Form *f in self.selectedOperation.forms) {
            if ([f.title isEqualToString:@"PostOp"]) {
                vc.form = f;
            }
        }
        if (!vc.form) {
            Form *f = (Form*)[BBUtil newCoreDataObjectForEntityName:@"Form"];
            f.title = @"PostOp";
            [self.selectedOperation addFormsObject:f];
            vc.form = f;
        }
    }
    if ([[segue identifier] isEqualToString:@"Edit Patient Segue"]) {
        EditPatientViewController *vc = [segue destinationViewController];
        vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        vc.mainViewController = self;
        vc.patient = self.patient;
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
    self.preOpTimeTextField.text = _selectedOperation.preOpTime;
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSYearCalendarUnit
                                                 fromDate: _patient.birthdate toDate: _selectedOperation.preOpDate options: 0];
    NSString *age;
    if ((int)[components year] >= 0) {
        age = [NSString stringWithFormat:@"%d", (int)[components year]];
    } else {
        age = @"0";
    }
    
    
    [self.ageLabel setText:age];
    
    self.weightTextField.text = [self getWeight];
    self.heightTextField.text = [self getHeight];

    self.operationTitleLabel.text = self.selectedOperation.name;
    self.operationBackgroundView.hidden = NO;
}

-(void)saveWeight
{
    [self setWeight:self.weightTextField.text];
    [self updateOperationView];
    [BBUtil saveContext];
}

-(void)saveHeight
{
    [self setHeight:self.heightTextField.text];
    [self updateOperationView];
    [BBUtil saveContext];
}

-(NSString*)getWeight
{
    NSString *weight;
    if (self.useKG) {
        weight = _selectedOperation.weight;
    } else {
        weight = [NSString stringWithFormat:@"%f",[_selectedOperation.weight floatValue] * POUND_MULTIPLIER];
    }
    
    return [NSString stringWithFormat:@"%.1f", [weight floatValue]];
}

-(NSString*)getHeight
{
    return _selectedOperation.height;
}

-(void)setWeight:(NSString*)weight
{
    if (self.useKG) {
        _selectedOperation.weight = self.weightTextField.text;
    } else {
        _selectedOperation.weight = [NSString stringWithFormat:@"%f", [self.weightTextField.text floatValue] / POUND_MULTIPLIER];
    }
    [self updateOperationView];
}

-(void)setHeight:(NSString*)height
{
    _selectedOperation.height = self.heightTextField.text;
    [BBUtil saveContext];
    [self updateOperationView];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField == self.weightTextField) {
        [self saveWeight];
        [textField resignFirstResponder];
    }
    if (textField == self.heightTextField) {
        [self saveHeight];
        [textField resignFirstResponder];
    }
    if (textField == self.preOpTimeTextField) {
        _selectedOperation.preOpTime = textField.text;
        [BBUtil saveContext];
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (IBAction)setBirthdateFromTextField:(id)sender {
    [self setupDatePopoverRect:sender];
}


-(void)didSaveDateValues:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    [self.preOpDateButton setTitle:stringFromDate forState:UIControlStateNormal];
    
}

-(void)setupDatePopoverRect:(id)sender {
    CGRect location = CGRectMake(self.operationBackgroundView.frame.origin.x + 25, self.operationBackgroundView.frame.origin.y + 50, 100, 100);
    [self setupDatePickerPopover:location];
}

-(void)setupDatePickerPopover:(CGRect)rect {
    dateContent = [[BBDatePickerViewController alloc] initWithNibName:nil
                                                               bundle:nil];
    datePopover = [[UIPopoverController alloc] initWithContentViewController:dateContent];
    dateContent.date = [NSDate date];
    dateContent.datePopoverController = datePopover;
    dateContent.delegate = self;
    [datePopover presentPopoverFromRect:rect
                                 inView:self.view
               permittedArrowDirections:UIPopoverArrowDirectionAny
                               animated:YES];
}


@end
