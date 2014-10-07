//
//  IntraOpViewController.m
//  iCare
//
//  Created by Billy Bray on 10/2/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "IntraOpViewController.h"
#import "AddGasViewController.h"
#import "IntraOpGrid.h"
#import "GridConstants.h"
#import "DoseView.h"
#import "TimeScrollView.h"
#import "Agent.h"
#import "AgentTableAdapter.h"

@interface IntraOpViewController ()

@property (weak, nonatomic) IBOutlet UITableView *gasTableView;
@property (weak, nonatomic) IBOutlet UITableView *vitalsTableView;
@property (weak, nonatomic) IBOutlet IntraOpGrid *gridView;
@property (weak, nonatomic) IBOutlet UITableView *medicationTableView;
@property (weak, nonatomic) IBOutlet UITableView *fluidTableView;
@property (weak, nonatomic) IBOutlet UITableView *ventsTableView;
@property (weak, nonatomic) IBOutlet UITableView *eblTableView;
@property (weak, nonatomic) IBOutlet TimeScrollView *timeScrollView;


@end

@implementation IntraOpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.timeScrollView setStartTime:[NSDate date]];
    
//    AgentTableAdapter *gasAdapter = [[AgentTableAdapter alloc] initWithType:@"Gas"];
    AgentTableAdapter *gasAdapter = [[AgentTableAdapter alloc] init];
    gasAdapter.agentType = @"Gas";
    NSLog(@"%@", gasAdapter);
    self.gasTableView.dataSource = gasAdapter;
    self.gasTableView.delegate = gasAdapter;
}


-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    self.gridView.backgroundColor = [UIColor clearColor];
    self.gridView.frame = CGRectMake(self.gasTableView.frame.origin.x, self.gasTableView.frame.origin.y - INTRA_OP_GRID_VERTICAL_LINE_TOP, self.gasTableView.frame.size.width, (self.vitalsTableView.frame.origin.y + self.vitalsTableView.frame.size.height) - self.gasTableView.frame.origin.y + INTRA_OP_GRID_VERTICAL_LINE_TOP*2);
    self.gridView.tableOne = self.gasTableView;
    self.gridView.tableTwo = self.medicationTableView;
    self.gridView.tableThree = self.fluidTableView;
    self.gridView.tableFour = self.ventsTableView;
    self.gridView.tableFive = self.eblTableView;
    self.gridView.tableSix = self.vitalsTableView;
    [self.gridView setNeedsLayout];

    
    self.timeScrollView.pxPerMinute = COLUMN_INTERVAL_WIDTH/15.0;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addGass:(id)sender {
    AddGasViewController* vc = [[AddGasViewController alloc] init];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

-(DoseView*)doseViewForAgent:(Agent*)agent
{
    DoseView *doseView = [[DoseView alloc ]init];
    doseView.dose.text = agent.dose;
    NSDate *endTime;
    if (!agent.endTime) {
        endTime = [NSDate date];
    } else {
        endTime = agent.endTime;
    }
    int width;
    if (agent.continuous) {
        width = [self.timeScrollView dateToXCoord:endTime]-[self.timeScrollView dateToXCoord:agent.startTime];
    } else {
        width = ((CGSize)[agent.dose sizeWithAttributes:
                          @{NSFontAttributeName:
                                doseView.dose.font}]).width + 5;
        
    }

    doseView.frame = CGRectMake( [self.timeScrollView dateToXCoord:agent.startTime] + FIRST_COLUMN_X_COORD, 0, width, 26.0 );
    return doseView;
}

-(CGRect)frameRectForStartTime:(NSDate*)startTime withEndTime:(NSDate*)endTime
{
    return CGRectZero;
}


@end
