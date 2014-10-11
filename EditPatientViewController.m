//
//  EditPatientViewController.m
//  iCare
//
//  Created by Billy Bray on 10/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "EditPatientViewController.h"
#import "BBDatePickerViewController.h"
#import "BBUtil.h"

@interface EditPatientViewController () <BBDatePickerViewControllerDelegate, UITextFieldDelegate> {
    BBDatePickerViewController *dateContent;
    UIPopoverController *datePopover;
}

@property (weak, nonatomic) IBOutlet UITextField *firstName;
@property (weak, nonatomic) IBOutlet UITextField *lastName;
@property (weak, nonatomic) IBOutlet UITextField *birthdate;
@property (weak, nonatomic) IBOutlet UITextField *mrn;
@property (weak, nonatomic) IBOutlet UITextField *caseCode;
@property (strong, nonatomic) NSDate *birthdateDate;

@end

@implementation EditPatientViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstName.text = self.patient.firstName;
    self.lastName.text = self.patient.lastName;
    self.birthdateDate = self.patient.birthdate;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:self.birthdateDate];
    self.birthdate.text = stringFromDate;
    self.mrn.text = self.patient.medicalRecordNumber;
    self.caseCode.text = self.patient.caseCode;
}

- (IBAction)saveEditUser:(id)sender {
    
    self.patient.firstName = self.firstName.text;
    self.patient.lastName = self.lastName.text;
    self.patient.birthdate = self.birthdateDate;
    self.patient.medicalRecordNumber = self.mrn.text;
    self.patient.caseCode = self.caseCode.text;
    
    [BBUtil saveContext];
    [self.mainViewController updateOperationView];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelEditUser:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)setBirthdateFromTextField:(id)sender {
    [self setupDatePopoverRect:sender];
    [self.birthdate resignFirstResponder];
}

-(void)didSaveDateValues:(NSDate *)date {
    self.birthdateDate = date;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM/dd/yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:date];
    self.birthdate.text = stringFromDate;
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

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self setBirthdateFromTextField:textField];
    return YES;
}

-(BOOL) textFieldShouldReturn: (UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}


@end
