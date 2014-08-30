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
#import "BBPatientTableAdapter.h"
#import "BBDatePickerViewController.h"
#import "Operation.h"
#import "BBData.h"
#import "BBProceduresTableViewController.h"

@interface BBPatientFormsViewController () <BBDatePickerViewControllerDelegate>{
    BBDatePickerViewController *dateContent;
    UIPopoverController *datePopover;
    BBPatientTableAdapter *patientAdapter;
}
@property (weak, nonatomic) IBOutlet UITableView *formsTableView;
@property (weak, nonatomic) IBOutlet UITableView *plannedProcedureTableView;
@property (weak, nonatomic) IBOutlet UIButton *preOpTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel *ageLabel;
@property Operation *operation;

@end

@implementation BBPatientFormsViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    patientAdapter = [[BBPatientTableAdapter alloc] init];
    self.plannedProcedureTableView.delegate = patientAdapter;
    self.plannedProcedureTableView.dataSource = patientAdapter;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = [NSString stringWithFormat:@"%@, %@", self.patient.lastName, self.patient.firstName];
}

#pragma mark - Actions

- (IBAction)addOperation:(id)sender {
    BBProceduresTableViewController *proceduresViewController = [[BBProceduresTableViewController alloc] initWithNibName:@"PopoverTableView" bundle:nil];
    proceduresViewController.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    proceduresViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:proceduresViewController animated:YES completion:nil];}
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

@end
