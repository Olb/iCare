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

@interface BBPatientFormsViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (weak, nonatomic) IBOutlet UITableView *formsTableView;
@property (weak, nonatomic) IBOutlet UITableView *plannedProcedureTableView;
@end

@implementation BBPatientFormsViewController

BBPatientTableAdapter *patientAdapter;

-(void)viewDidLoad
{
    [super viewDidLoad];
    patientAdapter = [[BBPatientTableAdapter alloc] init];
    self.plannedProcedureTableView.delegate = patientAdapter;
    self.plannedProcedureTableView.dataSource = patientAdapter;
}

-(void)targetMethod:(id)t
{
    NSLog(@"Timer fired");
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationItem.title = [NSString stringWithFormat:@"%@, %@", self.patient.lastName, self.patient.firstName];
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


@end
