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

//#import "CardioViewController.h"
//#import "RespiratoryViewController.h"
//#import "RenalViewController.h"
//#import "NeuroligcViewController.h"
//#import "EndocrineViewController.h"
//#import "HepatoViewController.h"
//#import "HemOncViewController.h"
//#import "ImmuneIDViewController.h"
//#import "EvalOtherViewController.h"
//#import "DiagnosticStudiesViewController.h"
//#import "PlanDiscussionViewController.h"
//#import "PreOpReviewViewController.h"
//
//
//
//#import "MedicationsSupplementsViewController.h"
//#import "PastSurgicalProceduresViewController.h"
//#import "AllergiesReactionsViewController.h"
//#import "PhysicalExamViewController.h"
//#import "AirwayViewController.h"

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
    UIViewController *vc;
//    switch (indexPath.row) {
//        case 0:
//            vc = [[MedicationsSupplementsViewController alloc] init];
////            vc = [[OverviewViewController alloc] init];
////            ((OverviewViewController*)vc).delegate = self;
////            for (FormSection* s in self.form.sections) {
////                if ([s.title isEqualToString:[OverviewViewController sectionTitle]]) {
////                    ((OverviewViewController*)vc).section = s;
////                }
////            }
//            break;
//        case 1:
//            vc = [[PastSurgicalProceduresViewController alloc] init];
//            break;
//        case 2:
//            vc = [[AllergiesReactionsViewController alloc] init];
//            break;
//        case 3:
//            vc = [[PhysicalExamViewController alloc] init];
//            break;
//        case 4:
//            vc = [[AirwayViewController alloc] init];
//            break;
//        case 5:
//            vc = [[CardioViewController alloc] init];
//            break;
//        case 6:
//            vc = [[RespiratoryViewController alloc] init];
//            break;
//        case 7:
//            vc = [[NeuroligcViewController alloc] init];
//            break;
//        case 8:
//            vc = [[EndocrineViewController alloc] init];
//            break;
//        case 9:
//            vc = [[HepatoViewController alloc] init];
//            break;
//        case 10:
//            vc = [[RenalViewController alloc] init];
//            break;
//        case 11:
//            vc = [[HemOncViewController alloc] init];
//            break;
//        case 12:
//            vc = [[ImmuneIDViewController alloc] init];
//            break;
//        case 13:
//            vc = [[EvalOtherViewController alloc] init];
//            break;
//        case 14:
//            vc = [[DiagnosticStudiesViewController alloc] init];
//            break;
//        case 15:
//            vc = [[PlanDiscussionViewController alloc] init];
//            break;
//        case 16:
//            vc = [[PreOpReviewViewController alloc] init];
//            break;
//        default:
//            break;
//    }

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
