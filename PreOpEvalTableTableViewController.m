//
//  BBPreOpEvalTableTableViewController.m
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "PreOpEvalTableTableViewController.h"
#import "Operation.h"
#import "Patient.h"
#import "Form.h"
#import "BBFormSectionDelegate.h"
#import "BPBAppDelegate.h"
#import "CardioViewController.h"
#import "RespiratoryViewController.h"
#import "RenalViewController.h"
#import "NeuroligcViewController.h"
#import "EndocrineViewController.h"
#import "HepatoViewController.h"
#import "HemOncViewController.h"
#import "ImmuneIDViewController.h"
#import "EvalOtherViewController.h"
#import "DiagnosticStudiesViewController.h"
#import "PlanDiscussionViewController.h"
#import "PreOpReviewViewController.h"
#import "MedicationsSupplementsViewController.h"
#import "PastSurgicalProceduresViewController.h"
#import "AllergiesReactionsViewController.h"
#import "PhysicalExamViewController.h"
#import "AirwayViewController.h"

@interface PreOpEvalTableTableViewController () <BBFormSectionDelegate>

@end

@implementation PreOpEvalTableTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"PreOperative Evaluation - %@, %@", self.form.operation.patient.lastName, self.form.operation.patient.firstName];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;

    switch (section) {
        case 0:
            result = 5;
            break;
        case 1:
            result = 9;
            break;
        case 2:
            result = 1;
            break;
        case 3:
            result = 2;
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
            vc = [[MedicationsSupplementsViewController alloc] init];
            ((MedicationsSupplementsViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[MedicationsSupplementsViewController sectionTitle]]) {
                    ((MedicationsSupplementsViewController*)vc).section = s;
                }
            }
            break;
        case 1:
            vc = [[PastSurgicalProceduresViewController alloc] init];
            ((PastSurgicalProceduresViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PastSurgicalProceduresViewController sectionTitle]]) {
                    ((PastSurgicalProceduresViewController*)vc).section = s;
                }
            }
            break;
        case 2:
            vc = [[AllergiesReactionsViewController alloc] init];
            ((AllergiesReactionsViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[AllergiesReactionsViewController sectionTitle]]) {
                    ((AllergiesReactionsViewController*)vc).section = s;
                }
            }
            break;
        case 3:
            vc = [[PhysicalExamViewController alloc] init];
            ((PhysicalExamViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PhysicalExamViewController sectionTitle]]) {
                    ((PhysicalExamViewController*)vc).section = s;
                }
            }
            break;
        case 4:
            vc = [[AirwayViewController alloc] init];
            ((AirwayViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[AirwayViewController sectionTitle]]) {
                    ((AirwayViewController*)vc).section = s;
                }
            }
            break;
        case 5:
            vc = [[CardioViewController alloc] init];
            ((CardioViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[CardioViewController sectionTitle]]) {
                    ((CardioViewController*)vc).section = s;
                }
            }
            break;
        case 6:
            vc = [[RespiratoryViewController alloc] init];
            ((RespiratoryViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[RespiratoryViewController sectionTitle]]) {
                    ((RespiratoryViewController*)vc).section = s;
                }
            }
            break;
        case 7:
            vc = [[NeuroligcViewController alloc] init];
            ((NeuroligcViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[NeuroligcViewController sectionTitle]]) {
                    ((NeuroligcViewController*)vc).section = s;
                }
            }
            break;
        case 8:
            vc = [[EndocrineViewController alloc] init];
            ((EndocrineViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[EndocrineViewController sectionTitle]]) {
                    ((EndocrineViewController*)vc).section = s;
                }
            }
            break;
        case 9:
            vc = [[HepatoViewController alloc] init];
            ((HepatoViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[HepatoViewController sectionTitle]]) {
                    ((HepatoViewController*)vc).section = s;
                }
            }
            break;
        case 10:
            vc = [[RenalViewController alloc] init];
            ((RenalViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[RenalViewController sectionTitle]]) {
                    ((RenalViewController*)vc).section = s;
                }
            }
            break;
        case 11:
            vc = [[HemOncViewController alloc] init];
            ((HemOncViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[HemOncViewController sectionTitle]]) {
                    ((HemOncViewController*)vc).section = s;
                }
            }
            break;
        case 12:
            vc = [[ImmuneIDViewController alloc] init];
            ((ImmuneIDViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[ImmuneIDViewController sectionTitle]]) {
                    ((ImmuneIDViewController*)vc).section = s;
                }
            }
            break;
        case 13:
            vc = [[EvalOtherViewController alloc] init];
            ((EvalOtherViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[EvalOtherViewController sectionTitle]]) {
                    ((EvalOtherViewController*)vc).section = s;
                }
            }
            break;
        case 14:
            vc = [[DiagnosticStudiesViewController alloc] init];
            ((DiagnosticStudiesViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[DiagnosticStudiesViewController sectionTitle]]) {
                    ((DiagnosticStudiesViewController*)vc).section = s;
                }
            }
            break;
        case 15:
            vc = [[PlanDiscussionViewController alloc] init];
            ((PlanDiscussionViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PlanDiscussionViewController sectionTitle]]) {
                    ((PlanDiscussionViewController*)vc).section = s;
                }
            }
            break;
        case 16:
            vc = [[PreOpReviewViewController alloc] init];
            ((PreOpReviewViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PreOpReviewViewController sectionTitle]]) {
                    ((PreOpReviewViewController*)vc).section = s;
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
        [context refreshObject:formSection mergeChanges:YES];
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
