//
//  BBPreOpEvalTableTableViewController.m
//  iCare2
//
//  Created by billy bray on 8/25/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBPreOpEvalTableTableViewController.h"
#import "BBCardioViewController.h"
#import "BBRespiratoryViewController.h"
#import "BBRenalViewController.h"
#import "BBNeuroligcViewController.h"
#import "OverviewViewController.h"
#import "BBEndocrineViewController.h"
#import "BBHepatoViewController.h"
#import "BBHemOncViewController.h"
#import "BBImmuneIDViewController.h"
#import "BBOtherViewController.h"
#import "BBDaignosticStudiesViewController.h"
#import "BBPlanDiscussionViewController.h"
#import "BBPreOpReviewViewController.h"
#import "Operation.h"
#import "Patient.h"

@interface BBPreOpEvalTableTableViewController ()

@end

@implementation BBPreOpEvalTableTableViewController

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
    
    self.navigationItem.title = [NSString stringWithFormat:@"PreOperative Evaluation - %@, %@", self.operation.patient.lastName, self.operation.patient.firstName];

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
            break;
        case 1:
            vc = [[BBCardioViewController alloc] init];
            break;
        case 2:
            vc = [[BBRespiratoryViewController alloc] init];
            break;
        case 3:
            vc = [[BBNeuroligcViewController alloc] init];
            break;
        case 4:
            vc = [[BBEndocrineViewController alloc] init];
            break;
        case 5:
            vc = [[BBHepatoViewController alloc] init];
            break;
        case 6:
            vc = [[BBRenalViewController alloc] init];
            break;
        case 7:
            vc = [[BBHemOncViewController alloc] init];
            break;
        case 8:
            vc = [[BBImmuneIDViewController alloc] init];
            break;
        case 9:
            vc = [[BBOtherViewController alloc] init];
            break;
        case 10:
            vc = [[BBDaignosticStudiesViewController alloc] init];
            break;
        case 11:
            vc = [[BBPlanDiscussionViewController alloc] init];
            break;
        case 12:
            vc = [[BBPreOpReviewViewController alloc] init];
            break;
        default:
            break;
    }

    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    // "self" is the parent ViewController
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

@end
