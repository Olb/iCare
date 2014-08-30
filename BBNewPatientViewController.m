//
//  BBNewPatientViewController.m
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBNewPatientViewController.h"
#import "BPBAppDelegate.h"
#import "Patient.h"
#import "BBDatePickerViewController.h"

@interface BBNewPatientViewController () <BBDatePickerViewControllerDelegate, UITextFieldDelegate> {
    BBDatePickerViewController *dateContent;
    UIPopoverController *datePopover;
}
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *medicalRecordNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *caseCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *birthdateTextField;
@property (strong, nonatomic) NSDate *birthdate;
@end

@implementation BBNewPatientViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"Patient Name:%@", self.practitioner.loginID);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveNewPatient:(id)sender {
    if ( [self.firstNameTextField.text length] == 0){
        [self showAlertWithMessage:@"First name cannot be empty"];
        return;
    }
    
    if ( [self.lastNameTextField.text length] == 0){
        [self showAlertWithMessage:@"Last name cannot be empty"];
        return;
    }
    
    if ( [self.medicalRecordNumberTextField.text length] == 0){
        [self showAlertWithMessage:@"Medical Record Number cannot be empty"];
        return;
    }
    
    if ( [self.caseCodeTextField.text length] == 0){
        [self showAlertWithMessage:@"Case Code cannot be empty"];
        return;
    }
    
    if ( [self.birthdateTextField.text length] == 0){
        [self showAlertWithMessage:@"Birthdate cannot be empty"];
        return;
    }
    
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Patient"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"medicalRecordNumber = %@", self.medicalRecordNumberTextField.text]];
    [request setFetchLimit:1];
    
    NSUInteger count = [context countForFetchRequest:request error:nil];
    
    if (count == NSNotFound){
        [self showAlertWithMessage:@"Internal error"];
        return;
    } else if (count != 0){
        [self showAlertWithMessage:@"Patient with this MRN already exists"];
        return;
    }
    
    
    Patient *patient =[NSEntityDescription insertNewObjectForEntityForName:@"Patient"
                                                              inManagedObjectContext:context];
    patient.firstName = self.firstNameTextField.text;
    patient.lastName = self.lastNameTextField.text;
    patient.medicalRecordNumber = self.medicalRecordNumberTextField.text;
    patient.caseCode = self.caseCodeTextField.text;
    patient.birthdate = self.birthdate;
    patient.practitioner = self.practitioner;
    NSError *error;
    if (![context save:&error]) {
        NSLog(@"ERROR on context save: %@",[error description]);
        [NSException raise:@"Error on context save" format:@"Message: %@",[error description]];
    }
    
    [self.practitioner addPatientsObject:patient];

    
    [self dismissViewControllerAnimated:YES completion:^{
        [self.mainViewController refreshData];
    }];
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iCare"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}
- (IBAction)setBirthdateFromTextField:(id)sender {
    [self setupDatePopoverRect:sender];
    [self.birthdateTextField resignFirstResponder];
}

-(void)didSaveDateValues:(NSDate *)date {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    self.birthdateTextField.text = stringFromDate;
    self.birthdate = date;
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

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

@end
