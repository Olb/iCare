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
#import "BBPatientFormsViewController.h"

@interface BBMainViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *patientsTableView;
@property Patient *testPatient;
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
    
    BPBAppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.managedObjectContext;
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Practitioner"
                                              inManagedObjectContext:context];
    if (entity == nil) {
        NSLog(@"Entity is nil");
        return;
    }
    
    [fetchRequest setEntity:entity];
    NSError *requestError = nil;
    NSArray *persons = [context executeFetchRequest:fetchRequest
                                                                error:&requestError];
    
    if ([persons count] == 0) {
        self.practitioner = [NSEntityDescription insertNewObjectForEntityForName:@"Practitioner"
                                                          inManagedObjectContext:context];
        if (self.practitioner != nil) {
            self.practitioner.firstName = @"Doc";
            self.practitioner.lastName = @"tor";
            NSError *savingError = nil;
            if ([context save:&savingError]) {
                NSLog(@"Save successful");
            } else {
                NSLog(@"Save failed");
            }
        } else {
            NSLog(@"Failed to create new practitioner");
        }
    }
    self.practitioner = [persons firstObject];
    Patient *p;
    
    fetchRequest = [[NSFetchRequest alloc] init];
    entity = [NSEntityDescription entityForName:@"Patient"
                         inManagedObjectContext:context];
    [fetchRequest setEntity:entity];

    persons = [context executeFetchRequest:fetchRequest
                                     error:&requestError];
    if ([persons count] == 0) {
        p = [NSEntityDescription insertNewObjectForEntityForName:@"Patient"
                                          inManagedObjectContext:context];
        p.firstName = @"FirstName";
        p.lastName = @"LastName";
        [self.practitioner addPatientsObject:p];
        NSError *savingError = nil;
        if ([context save:&savingError]) {
            NSLog(@"Save successful");
        } else {
            NSLog(@"Save failed");
        }
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
    BBPatientFormsViewController *vc = [segue destinationViewController];
    vc.patient = self.testPatient;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    if (tableView == self.patientsTableView) {
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
        self.testPatient = p;
    }
    
    return cell;
}




@end
