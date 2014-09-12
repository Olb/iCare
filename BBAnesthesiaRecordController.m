//
//  BBAnesthesiaRecordController.m
//  iCare2
//
//  Created by billy bray on 8/27/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBAnesthesiaRecordController.h"
#import "AnesthesiaTypeViewController.h"
#import "BetaBlockerViewController.h"
#import "EmergenceViewController.h"
#import "BBPreopActionsViewController.h"
#import "EndotrachealTubeViewController.h"
#import "InductionAndDeviceViewController.h"
#import "InvasiveLinesViewController.h"
#import "IVAntibioticNameViewController.h"
#import "MonitorinAndEquipmentViewController.h"
#import "PersonelViewController.h"
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

NSString *const SECTION_TITLE2 = @"Anesthesia PreOp time used to";

@interface BBAnesthesiaRecordController ()<BBFormSectionDelegate>

@end

@implementation BBAnesthesiaRecordController

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
            vc = [[BBPreopActionsViewController alloc] init];
            ((BBPreopActionsViewController*)vc).delegate = self;
            for (FormSection* s in self.form.sections) {
                if ([s.title isEqualToString:SECTION_TITLE2]) {
                    ((BBPreopActionsViewController*)vc).section = s;
                }
            }
            break;
        case 1:
            vc = [[PremedsGivenViewController alloc] init];
            break;
        case 2:
            vc = [[BetaBlockerViewController alloc] init];
            break;
        case 3:
            vc = [[IVAntibioticNameViewController alloc] init];
            break;
        case 4:
            vc = [[MonitorinAndEquipmentViewController alloc] init];
            break;
        case 5:
            vc = [[InvasiveLinesViewController alloc] init];
            break;
        case 6:
            vc = [[AnesthesiaTypeViewController alloc] init];
            break;
        case 7:
            vc = [[SpinalAnesthesiaViewController alloc] init];
            break;
        case 8:
            vc = [[PositionViewController alloc] init];
            break;
        case 9:
            vc = [[EmergenceViewController alloc] init];
            break;
        case 10:
            vc = [[InductionAndDeviceViewController alloc] init];
            break;
        case 11:
            vc = [[IntubationViewController alloc] init];
            break;
        case 12:
            vc = [[EndotrachealTubeViewController alloc] init];
            break;
        case 13:
            vc = [[PostProcedureGeneralViewController alloc] init];
            break;
        case 14:
            vc = [[PostOpDiagnosisViewController alloc] init];
            break;
        case 15:
            vc = [[PostAnesthesiaEvalViewController alloc] init];
            break;
        case 16:
            vc = [[PersonelViewController alloc] init];
            break;
        default:
            break;
    }
    
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:vc animated:YES completion:nil];
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

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

@end
