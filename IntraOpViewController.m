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
#import "AddMedicationViewController.h"
#import "AddMeasurementsViewController.h"
#import "AddFluidViewController.h"
#import "MeasurementTableAdapter.h"

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
@property AgentTableAdapter *medicationAdapter;
@property AgentTableAdapter *fluidAdapter;
@property MeasurementTableAdapter *ventsAdapter;
@property MeasurementTableAdapter *vitalsAdapter;
@property MeasurementTableAdapter *eblAdapter;


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
    
    self.medicationAdapter = [[AgentTableAdapter alloc] initWithType:@"Medication"];
    self.medicationAdapter.controller = self;
    self.medicationAdapter.intraOp = self.intraOp;
    self.medicationTableView.dataSource = self.medicationAdapter;
    self.medicationTableView.delegate = self.medicationAdapter;
    
    self.fluidAdapter = [[AgentTableAdapter alloc] initWithType:@"Fluid"];
    self.fluidAdapter.controller = self;
    self.fluidAdapter.intraOp = self.intraOp;
    self.fluidTableView.dataSource = self.fluidAdapter;
    self.fluidTableView.delegate = self.fluidAdapter;
    
    self.ventsAdapter = [[MeasurementTableAdapter alloc] initWithType:@"Vent"];
    self.ventsAdapter.controller = self;
    self.ventsAdapter.intraOp = self.intraOp;
    self.ventsTableView.dataSource = self.ventsAdapter;
    self.ventsTableView.delegate = self.ventsAdapter;
    
    self.vitalsAdapter = [[MeasurementTableAdapter alloc] initWithType:@"Vital"];
    self.vitalsAdapter.controller = self;
    self.vitalsAdapter.intraOp = self.intraOp;
    self.vitalsTableView.dataSource = self.vitalsAdapter;
    self.vitalsTableView.delegate = self.vitalsAdapter;
    
    self.eblAdapter = [[MeasurementTableAdapter alloc] initWithType:@"Ebl"];
    self.eblAdapter.controller = self;
    self.eblAdapter.intraOp = self.intraOp;
    self.eblTableView.dataSource = self.eblAdapter;
    self.eblTableView.delegate = self.eblAdapter;

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

- (IBAction)addMedication:(id)sender {
    AddMedicationViewController* vc = [[AddMedicationViewController alloc] initWithIntraOp:self.intraOp completion:^{
        [self reloadTables];
    }];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (IBAction)updateMonitors:(id)sender {
    AddMeasurementsViewController* vc = [[AddMeasurementsViewController alloc] initWithIntraOp:self.intraOp completion:^{
        [self reloadTables];
    }];
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (IBAction)addFluid:(id)sender {
    AddFluidViewController* vc = [[AddFluidViewController alloc] initWithIntraOp:self.intraOp completion:^{
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


-(UILabel*)viewForMeasurement:(Measurement*)measurement forCell:(UITableViewCell*)cell{
    UILabel *label = [[UILabel alloc] init];
    label.text = measurement.value;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.frame = CGRectMake( [self.timeScrollView dateToXCoord:measurement.time] + FIRST_COLUMN_X_COORD, cell.bounds.origin.y, COLUMN_INTERVAL_WIDTH, cell.bounds.size.height );
    return label;
}

-(CGRect)frameRectForStartTime:(NSDate*)startTime withEndTime:(NSDate*)endTime
{
    return CGRectZero;
}

-(void) reloadTables{
    [self.gasTableView reloadData];
    [self.medicationTableView reloadData];
    [self.fluidTableView reloadData];
    [self.vitalsTableView reloadData];
    [self.ventsTableView reloadData];
    [self.eblTableView reloadData];
}

@end
