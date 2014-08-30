//
//  BBPatientFormsViewController.m
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBPatientFormsViewController.h"
#import "Patient.h"
@interface BBPatientFormsViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *formsTableView;

@end

@implementation BBPatientFormsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"%@, %@", self.patient.lastName, self.patient.firstName];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 4;
    
    return result;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    if ( tableView == self.formsTableView) {
        switch (indexPath.row) {
            case 0:
                cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsEvalCell"];
                break;
            case 1:
                cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsIntraOpCell"];
                break;
            case 2:
                cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsAnesthesiaRecordCell"];
                break;
            case 3:
                cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsPostOpCell"];
                break;
            default:
                break;
        }
    }
    
    return cell;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
