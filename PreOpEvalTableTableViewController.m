//
//  BBPreOpEvalTableTableViewController.m
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "PreOpEvalTableTableViewController.h"
#import "CardioViewController.h"
#import "RespiratoryViewController.h"
#import "RenalViewController.h"
#import "NeuroligcViewController.h"
#import "OverviewViewController.h"
#import "EndocrineViewController.h"
#import "HepatoViewController.h"
#import "HemOncViewController.h"
#import "ImmuneIDViewController.h"
#import "OtherViewController.h"
#import "DiagnosticStudiesViewController.h"
#import "PlanDiscussionViewController.h"
#import "PreOpReviewViewController.h"
#import "Operation.h"
#import "Patient.h"
#import "BBFormSectionDelegate.h"
#import "BPBAppDelegate.h"
#import "Form.h"

@interface PreOpEvalTableTableViewController () <BBFormSectionDelegate>

@end

@implementation PreOpEvalTableTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
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
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result;

    switch (section) {
        case 0:
            result = 1;
            break;
        case 1:
            result = 9;
            break;
        case 2:
            result = 1;
            break;
        case 3:
            result = 1;
            break;
        case 4:
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
            vc = [[OverviewViewController alloc] init];
            ((OverviewViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[OverviewViewController sectionTitle]]) {
                    ((OverviewViewController*)vc).section = s;
                }
            }
            break;
        case 1:
            vc = [[CardioViewController alloc] init];
            break;
        case 2:
            vc = [[RespiratoryViewController alloc] init];
            break;
        case 3:
            vc = [[NeuroligcViewController alloc] init];
            break;
        case 4:
            vc = [[EndocrineViewController alloc] init];
            break;
        case 5:
            vc = [[HepatoViewController alloc] init];
            break;
        case 6:
            vc = [[RenalViewController alloc] init];
            break;
        case 7:
            vc = [[HemOncViewController alloc] init];
            break;
        case 8:
            vc = [[ImmuneIDViewController alloc] init];
            break;
        case 9:
            vc = [[OtherViewController alloc] init];
            break;
        case 10:
            vc = [[DiagnosticStudiesViewController alloc] init];
            break;
        case 11:
            vc = [[PlanDiscussionViewController alloc] init];
            break;
        case 12:
            vc = [[PreOpReviewViewController alloc] init];
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
