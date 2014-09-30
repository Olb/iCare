//
//  BBAnesthesiaRecordController.m
//  iCare2
//
//  Created by billy bray on 8/27/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "AnesthesiaRecordController.h"
#import "AnesthesiaTypeViewController.h"
#import "BetaBlockerViewController.h"
#import "EmergenceViewController.h"
#import "PreOpActionsViewController.h"
#import "EndotrachealTubeViewController.h"
#import "InductionAndDeviceViewController.h"
#import "InvasiveLinesViewController.h"
#import "IVAntibioticNameViewController.h"
#import "MonitorinAndEquipmentViewController.h"
#import "PersonnelViewController.h"
#import "PositionViewController.h"
#import "PostAnesthesiaEvalViewController.h"
#import "PostOpDiagnosisViewController.h"
#import "PremedsGivenViewController.h"
#import "PostProcedureGeneralViewController.h"
#import "SpinalAnesthesiaViewController.h"
#import "IntubationViewController.h"
#import "Patient.h"
#import "Operation.h"
#import "BBFormSectionDelegate.h"
#import "BPBAppDelegate.h"
#import "Form.h"
#import "BBPdfGenerator.h"
#import "PDFDisplayViewController.h"

@interface AnesthesiaRecordController ()<BBFormSectionDelegate>

@end

@implementation AnesthesiaRecordController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"Anesthesia Evaluation Record - %@, %@", self.form.operation.patient.lastName, self.form.operation.patient.firstName];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result;
    
    switch (section) {
        case 0:
            result = 10;
            break;
        case 1:
            result = 3;
            break;
        case 2:
            result = 3;
            break;
        case 3:
            result = 1;
            break;
        default:
            result = 0;
            break;
    }
    return result;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIViewController *vc;
    switch (cell.tag) {
        case 0:
            vc = [[PreOpActionsViewController alloc] init];
            ((PreOpActionsViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PreOpActionsViewController sectionTitle]]) {
                    ((PreOpActionsViewController*)vc).section = s;
                }
            }
            break;
        case 1:
            vc = [[PremedsGivenViewController alloc] init];
            ((PremedsGivenViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PremedsGivenViewController sectionTitle]]) {
                    ((PremedsGivenViewController*)vc).section = s;
                }
            }
            break;
        case 2:
            vc = [[BetaBlockerViewController alloc] init];
            ((BetaBlockerViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[BetaBlockerViewController sectionTitle]]) {
                    ((BetaBlockerViewController*)vc).section = s;
                }
            }
            break;
        case 3:
            vc = [[IVAntibioticNameViewController alloc] init];
            ((IVAntibioticNameViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[IVAntibioticNameViewController sectionTitle]]) {
                    ((IVAntibioticNameViewController*)vc).section = s;
                }
            }
            break;
        case 4:
            vc = [[MonitorinAndEquipmentViewController alloc] init];
            ((MonitorinAndEquipmentViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[MonitorinAndEquipmentViewController sectionTitle]]) {
                    ((MonitorinAndEquipmentViewController*)vc).section = s;
                }
            }
            break;
        case 5:
            vc = [[InvasiveLinesViewController alloc] init];
            ((InvasiveLinesViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[InvasiveLinesViewController sectionTitle]]) {
                    ((InvasiveLinesViewController*)vc).section = s;
                }
            }
            break;
        case 6:
            vc = [[AnesthesiaTypeViewController alloc] init];
            ((AnesthesiaTypeViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[AnesthesiaTypeViewController sectionTitle]]) {
                    ((AnesthesiaTypeViewController*)vc).section = s;
                }
            }
            break;
        case 7:
            vc = [[SpinalAnesthesiaViewController alloc] init];
            ((SpinalAnesthesiaViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[SpinalAnesthesiaViewController sectionTitle]]) {
                    ((SpinalAnesthesiaViewController*)vc).section = s;
                }
            }
            break;
        case 8:
            vc = [[PositionViewController alloc] init];
            ((PositionViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PositionViewController sectionTitle]]) {
                    ((PositionViewController*)vc).section = s;
                }
            }
            break;
        case 9:
            vc = [[EmergenceViewController alloc] init];
            ((EmergenceViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[EmergenceViewController sectionTitle]]) {
                    ((EmergenceViewController*)vc).section = s;
                }
            }
            break;
        case 10:
            vc = [[InductionAndDeviceViewController alloc] init];
            ((InductionAndDeviceViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[InductionAndDeviceViewController sectionTitle]]) {
                    ((InductionAndDeviceViewController*)vc).section = s;
                }
            }
            break;
        case 11:
            vc = [[IntubationViewController alloc] init];
            ((IntubationViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[IntubationViewController sectionTitle]]) {
                    ((IntubationViewController*)vc).section = s;
                }
            }
            break;
        case 12:
            vc = [[EndotrachealTubeViewController alloc] init];
            ((EndotrachealTubeViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[EndotrachealTubeViewController sectionTitle]]) {
                    ((EndotrachealTubeViewController*)vc).section = s;
                }
            }
            break;
        case 13:
            vc = [[PostProcedureGeneralViewController alloc] init];
            ((PostProcedureGeneralViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PostProcedureGeneralViewController sectionTitle]]) {
                    ((PostProcedureGeneralViewController*)vc).section = s;
                }
            }
            break;
        case 14:
            vc = [[PostOpDiagnosisViewController alloc] init];
            ((PostOpDiagnosisViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PostOpDiagnosisViewController sectionTitle]]) {
                    ((PostOpDiagnosisViewController*)vc).section = s;
                }
            }
            break;
        case 15:
            vc = [[PostAnesthesiaEvalViewController alloc] init];
            ((PostAnesthesiaEvalViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PostAnesthesiaEvalViewController sectionTitle]]) {
                    ((PostAnesthesiaEvalViewController*)vc).section = s;
                }
            }
            break;
        case 16:
            vc = [[PersonnelViewController alloc] init];
            ((PersonnelViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PersonnelViewController sectionTitle]]) {
                    ((PersonnelViewController*)vc).section = s;
                }
            }
            break;
        default:
            break;
    }
    
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - FormSectionDelegate Methods
-(void)sectionCreated:(FormSection*)formSection
{
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    
    if (![self.form.sections containsObject:formSection]) {
        [self.form addSectionsObject:formSection];
    } else {
    }
    
    NSError *error = nil;
    if (![context save:&error]) {
        [self showAlertWithMessage:@"Error saving form"];
    }
    
}

- (void)showAlertWithMessage:(NSString *)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iCare"
                                                    message:message
                                                   delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

- (IBAction)print:(id)sender {
    [BBPdfGenerator generatePdfForForm:self.form];
    [self showPDF:self.form];
}

-(void)showPDF:(Form *)form
{
    PDFDisplayViewController *vc = [[PDFDisplayViewController alloc] init];
    vc.form = form;
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:vc animated:YES completion:nil];
}

// TODO
-(void)setTableViewAccessoryForIndexPath:(NSIndexPath*)indexPath to:(BOOL)complete
{
    UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
    if(complete)
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
}

@end
