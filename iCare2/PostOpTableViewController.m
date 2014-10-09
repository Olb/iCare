//
//  PostOpTableViewController.m
//  iCare
//
//  Created by Billy Bray on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "PostOpTableViewController.h"
#import "Group1ViewController.h"
#import "Group2ViewController.h"
#import "Group3ViewController.h"
#import "Group4ViewController.h"
#import "Group5ViewController.h"
#import "AsaAnesthesiaTypeViewController.h"
#import "OccurrenceDetailsViewController.h"
#import "FollowUpResultsViewController.h"
#import "PostOpReviewViewController.h"
#import "Operation.h"
#import "Patient.h"
#import "BBFormSectionDelegate.h"
#import "BPBAppDelegate.h"
#import "BBPdfGenerator.h"
#import "PDFDisplayViewController.h"

@interface PostOpTableViewController () <BBFormSectionDelegate>

@end

@implementation PostOpTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.title = [NSString stringWithFormat:@"PostOp - %@, %@", self.form.operation.patient.lastName, self.form.operation.patient.firstName];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    
    switch (section) {
        case 0:
            result = 5;
            break;
        case 1:
            result = 3;
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
            vc = [[Group1ViewController alloc] init];
            ((Group1ViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[Group1ViewController sectionTitle]]) {
                    ((Group1ViewController*)vc).section = s;
                }
            }
            break;
        case 1:
            vc = [[Group2ViewController alloc] init];
            ((Group2ViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[Group2ViewController sectionTitle]]) {
                    ((Group2ViewController*)vc).section = s;
                }
            }
            break;
        case 2:
            vc = [[Group3ViewController alloc] init];
            ((Group3ViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[Group3ViewController sectionTitle]]) {
                    ((Group3ViewController*)vc).section = s;
                }
            }
            break;
        case 3:
            vc = [[Group4ViewController alloc] init];
            ((Group4ViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[Group4ViewController sectionTitle]]) {
                    ((Group4ViewController*)vc).section = s;
                }
            }
            break;
        case 4:
            vc = [[Group5ViewController alloc] init];
            ((Group5ViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[Group5ViewController sectionTitle]]) {
                    ((Group5ViewController*)vc).section = s;
                }
            }
            break;
        case 5:
            vc = [[AsaAnesthesiaTypeViewController alloc] init];
            ((AsaAnesthesiaTypeViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[AsaAnesthesiaTypeViewController sectionTitle]]) {
                    ((AsaAnesthesiaTypeViewController*)vc).section = s;
                }
            }
            break;
        case 6:
            return;
//            vc = [[OccurrenceDetailsViewController alloc] init];
//            ((OccurrenceDetailsViewController*)vc).delegate = self;
//            for (FormSection* s in self.form.sections) {
//                if ([s.title isEqualToString:[OccurrenceDetailsViewController sectionTitle]]) {
//                    ((OccurrenceDetailsViewController*)vc).section = s;
//                }
//            }
            break;
        case 7:
            vc = [[FollowUpResultsViewController alloc] init];
            ((FollowUpResultsViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[FollowUpResultsViewController sectionTitle]]) {
                    ((FollowUpResultsViewController*)vc).section = s;
                }
            }
            break;
        case 8:
            vc = [[PostOpReviewViewController alloc] init];
            ((PostOpReviewViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:[PostOpReviewViewController sectionTitle]]) {
                    ((PostOpReviewViewController*)vc).section = s;
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

- (IBAction)showPDF:(id)sender {
    [BBPdfGenerator generatePdfForForm:self.form];
    PDFDisplayViewController *vc = [[PDFDisplayViewController alloc] init];
    vc.form = self.form;
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    //vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:vc animated:YES completion:nil];
}


@end
