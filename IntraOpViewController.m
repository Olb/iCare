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
@property AgentTableAdapter *gasAdapter;


@end

@implementation IntraOpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.timeScrollView.pxPerMinute = COLUMN_INTERVAL_WIDTH/15.0;
    [self.timeScrollView setStartTime:[NSDate date]];
    self.timeScrollView.onScroll = ^{
        [self reloadTables];
    };
    
    self.gasAdapter = [[AgentTableAdapter alloc] initWithType:@"Gas"];
    self.gasAdapter.controller = self;
    self.gasAdapter.intraOp = self.intraOp;
    
    self.gasTableView.dataSource = self.gasAdapter;
    self.gasTableView.delegate = self.gasAdapter;

}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reloadTables];
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)addGass:(id)sender {
    AddGasViewController* vc = [[AddGasViewController alloc] initWithIntraOp:self.intraOp completion:^{
        [self reloadTables];
    }];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

-(DoseView*)doseViewForAgent:(Agent*)agent forCell:(UITableViewCell*)cell
{
    DoseView *doseView = [[[NSBundle mainBundle] loadNibNamed:@"DoseView" owner:self options:nil] objectAtIndex:0];
    doseView.dose.text = agent.dose;
    doseView.dose.font = [UIFont systemFontOfSize:14.0f];
    int doseTextWidth = ((CGSize)[agent.dose sizeWithAttributes:
                                    @{NSFontAttributeName:
                                          doseView.dose.font}]).width;
    doseTextWidth += 3;
    [doseView.dose addConstraint:[NSLayoutConstraint
                                  constraintWithItem:doseView.dose
                                  attribute:NSLayoutAttributeWidth
                                  relatedBy:NSLayoutRelationEqual
                                  toItem: nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                  multiplier:1.0f
                                  constant:doseTextWidth]];
    
    NSDate *endTime;
    if (!agent.endTime) {
        endTime = [NSDate date];
    } else {
        endTime = agent.endTime;
    }
    int width;
    if ([agent.continuous boolValue]) {
        width = [self.timeScrollView dateToXCoord:endTime]-[self.timeScrollView dateToXCoord:agent.startTime];
        width = MAX(width, doseTextWidth + 10);
    } else {
        width = doseTextWidth + 10;
        
    }

    doseView.frame = CGRectMake( [self.timeScrollView dateToXCoord:agent.startTime] + FIRST_COLUMN_X_COORD, cell.bounds.origin.y, width, cell.bounds.size.height );
    [doseView setNeedsUpdateConstraints];

    return doseView;
}

-(CGRect)frameRectForStartTime:(NSDate*)startTime withEndTime:(NSDate*)endTime
{
    return CGRectZero;
}

-(void) reloadTables{
    [self.gasTableView reloadData];
}

@end
