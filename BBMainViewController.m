//
//  BBMainViewController.m
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBMainViewController.h"
#import "Practitioner.h"
#import "Patient.h"
#import "BPBAppDelegate.H"
#import "LoginViewController.h"
#import "BBPatientFormsViewController.h"
#import "BBNewPatientViewController.h"

@interface BBMainViewController () <UITableViewDataSource, UITableViewDelegate, LoginViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property BOOL isLoggedIn;
@property NSString *userID;
@property NSArray *patientsArray;
@property (nonatomic, strong) Practitioner *practitioner;
@property (nonatomic, strong) NSMutableArray *headerArray;

@end

@implementation BBMainViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (!self.isLoggedIn) {
        LoginViewController *loginViewController = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
        loginViewController.delegate = self;
        [self presentViewController:loginViewController animated:YES completion:nil];
    } else {
        [self refreshData];
    }
}

-(void)setLoggedIn:(BOOL)loggedIn withPractionerID:(Practitioner *)practitioner
{
    self.isLoggedIn = loggedIn;
    self.practitioner = practitioner;
}

-(void)refreshData
{
    self.patientsArray = [self.practitioner.patients allObjects];
    [self.patientsTableView reloadData];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"NewPatientSegue"]) {
        BBNewPatientViewController *vc = [segue destinationViewController];
        vc.practitioner = self.practitioner;
        vc.mainViewController = self;
    }
    if ([[segue identifier] isEqualToString:@"PatientFormsSegue"]) {
        BBPatientFormsViewController *vc = [segue destinationViewController];
        CGPoint cellPosition = [sender convertPoint:CGPointZero toView:self.patientsTableView];
        NSIndexPath *indexPath = [self.patientsTableView indexPathForRowAtPoint:cellPosition];
        Patient *p = [[self.headerArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        NSLog(@"Patient name:%@", p.firstName);
        vc.patient = p;
    }
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if ([self.practitioner.patients count] == 0){
        return 0;
    }
    
    self.headerArray = [[NSMutableArray alloc] init];
    
    NSMutableArray *sortedPatients = [[NSMutableArray alloc] initWithArray:[self.practitioner.patients allObjects]];
    sortedPatients = (NSMutableArray*)[sortedPatients sortedArrayUsingComparator: ^(Patient *p1, Patient *p2) {
        return [p1.lastName compare:p2.lastName options:NSCaseInsensitiveSearch];
    }];
    
    int j=0;
    [self.headerArray addObject:[[NSMutableArray alloc] init]];
    for (int i = 0; i < [sortedPatients count]; i++) {
        Patient *currentPatient = [sortedPatients objectAtIndex:i];
        [[self.headerArray objectAtIndex:j] addObject:currentPatient];
        if ( i < [sortedPatients count] - 1 ){
            Patient *nextPatient = [sortedPatients objectAtIndex:i+1];
            if ([currentPatient.lastName characterAtIndex:0] !=
                [nextPatient.lastName characterAtIndex:0]){
                j++;
                [self.headerArray addObject:[[NSMutableArray alloc] init]];
            }
        }
    }
    return self.headerArray.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Patient *p = [[self.headerArray objectAtIndex:section] objectAtIndex:0];
    return [NSString stringWithFormat:@"%c", [p.lastName characterAtIndex:0]];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[self.headerArray objectAtIndex:section] count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Patient *p = [[self.headerArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell"];
    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:1];
    [nameLabel setText:[NSString stringWithFormat:@"%@, %@", p.lastName, p.firstName]];
    
    return cell;
}

@end
