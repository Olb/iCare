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
@property (nonatomic, strong) Patient *patient;
@property (nonatomic, strong) Practitioner *practitioner;
@property NSSet *patientSet;
@end

@implementation BBMainViewController

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
}

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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    if (tableView == self.patientsTableView) {
        NSLog(@"%lu", (unsigned long)[self.practitioner.patients count]);
        result = [self.practitioner.patients count];
    }
    return result;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    NSArray *patientArray = [self.practitioner.patients allObjects];
    if ( tableView == self.patientsTableView) {
        cell = [tableView dequeueReusableCellWithIdentifier:@"PatientCell"];
        UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:1];
        Patient *p;
        p = [patientArray objectAtIndex:indexPath.row];
        [nameLabel setText:[NSString stringWithFormat:@"%@, %@", p.lastName, p.firstName]];
        self.patient = p;
    }
    
    return cell;
}

-(void)setLoggedIn:(BOOL)loggedIn withPractionerID:(Practitioner *)practitioner
{
    self.isLoggedIn = loggedIn;
    self.practitioner = practitioner;
}

-(void)refreshData
{
    [self.patientsTableView reloadData];
}

@end
