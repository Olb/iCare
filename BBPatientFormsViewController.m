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

@property (strong, nonatomic) BBOperationsTableAdapter *operationTableAdapter;
@property (strong, nonatomic) BBPatientFormTableAdapter *patientAdapter;

@property Operation *selectedOperation;

@end

@implementation BBPatientFormsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
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
    
    [self.patient addOperationObject:operation];
    
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
        vc.patient = self.patient;
    }
    if ([[segue identifier] isEqualToString:@"PatientFormsToAnesthesiaRecordSegue"]) {
        BBAnesthesiaRecordController *vc = [segue destinationViewController];
        vc.patient = self.patient;

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


-(void) operationSelected:(Operation*)operation fromPatient:(Patient*)patient
{
    self.selectedOperation = operation;
    [self updateOperationView];
}

-(void) updateOperationView
{
    [self.preOpDateButton setTitle:[BBUtil formatDate:_selectedOperation.preOpDate] forState:UIControlStateNormal];
    [self.preOpTimeLabel setTitle:[BBUtil formatTime:_selectedOperation.preOpDate] forState:UIControlStateNormal];
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components: NSDayCalendarUnit
                                                 fromDate: _patient.birthdate toDate: _selectedOperation.preOpDate options: 0];
    NSString *age = [NSString stringWithFormat:@"%d", [components year]];
    
    [self.ageLabel setText:age];
    [self.weightButton setTitle:_selectedOperation.weight forState:UIControlStateNormal];
    [self.heightButton setTitle:_selectedOperation.height forState:UIControlStateNormal];
    
    
}

@end
