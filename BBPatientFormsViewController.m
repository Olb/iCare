//
//  BBPatientFormsViewController.m
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBPatientFormsViewController.h"
#import "Patient.h"
#import "BBPreOpEvalTableTableViewController.h"
#import "BBAnesthesiaRecordController.h"
#import "BBPatientFormTableAdapter.h"
#import "BBDatePickerViewController.h"
#import "Operation.h"
#import "BBData.h"
#import "BBAutoCompleteTextField.h"
#import "BPBAppDelegate.h"
#import "BBOperationsTableAdapter.h"
#import "BBUtil.h"

@interface BBPatientFormsViewController () <BBDatePickerViewControllerDelegate>{
    BBDatePickerViewController *dateContent;
    UIPopoverController *datePopover;
}
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

@property (strong, nonatomic) BBOperationsTableAdapter *operationTableAdapter;
@property (strong, nonatomic) BBPatientFormTableAdapter *patientAdapter;

@property Operation *selectedOperation;

@end

@implementation BBPatientFormsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    _operationBackgroundView.hidden = YES;
    _operationTableAdapter = [[BBOperationsTableAdapter alloc] init];
    _operationTableAdapter.patient = self.patient;
    _operationTableAdapter.delegate = self;
    
    _operationTableView.delegate = _operationTableAdapter;
    _operationTableView.dataSource = _operationTableAdapter;
    
    _patientAdapter = [[BBPatientFormTableAdapter alloc] init];
    
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
}
- (IBAction)weightUnit:(id)sender {
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.navigationItem.title = [NSString stringWithFormat:@"Forms"];

    if ([[segue identifier] isEqualToString:@"FormsToPreOpEvalSegue"]) {
        BBPreOpEvalTableTableViewController *vc = [segue destinationViewController];
        vc.operation = self.selectedOperation;
    }
    if ([[segue identifier] isEqualToString:@"PatientFormsToAnesthesiaRecordSegue"]) {
        BBAnesthesiaRecordController *vc = [segue destinationViewController];
        vc.operation = self.selectedOperation;

    }
}

-(void)didSaveDateValues:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:date];

}

-(void)setupDatePopoverRect:(id)sender {
    CGRect location = CGRectMake(self.view.center.x, ((UITextField *)sender).frame.origin.y, 100, 100);
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


-(void)didSaveValues:(NSArray*)values{

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
        weight = _selectedOperation.weight;
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

@end
