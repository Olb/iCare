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
#import "BBUtil.h"
#import "IntraOpBPView.h"
#import "BloodPressure.h"

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
@property (weak, nonatomic) IBOutlet UITextField *systolicTextfield;
@property (weak, nonatomic) IBOutlet UITextField *diastolicTextField;
@property (weak, nonatomic) IBOutlet UITextField *pulseTextField;
@property (weak, nonatomic) IBOutlet UISlider *systolicSlider;
@property (weak, nonatomic) IBOutlet UISlider *diastolicSlider;
@property (weak, nonatomic) IBOutlet UISlider *pulseSlider;
@property UIView *bpGridView;
@property (weak, nonatomic) IBOutlet IntraOpGrid *bloodPressureDrawingView;
@property NSDate* lastTouchTime;
@end

@implementation IntraOpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.bpGridView =  [[[NSBundle mainBundle] loadNibNamed:@"IntraOpBPView" owner:self options:nil] objectAtIndex:0];

    self.bpGridView.center = self.view.center;
    
    self.bpGridView.frame = CGRectMake(self.bpGridView.frame.origin.x, self.bpGridView.frame.origin.y + 65, self.fluidTableView.frame.size.width - FIRST_COLUMN_X_COORD, 226);
    
    [self.systolicSlider addTarget:self
                            action:@selector(sliderValueChanged:)
                  forControlEvents:UIControlEventValueChanged];
    [self.diastolicSlider addTarget:self
                             action:@selector(sliderValueChanged:)
                   forControlEvents:UIControlEventValueChanged];
    [self.pulseSlider addTarget:self
                         action:@selector(sliderValueChanged:)
               forControlEvents:UIControlEventValueChanged];
    
    if ([self.systolicTextfield.text isEqualToString:@""]) {
        self.systolicTextfield.text = [NSString stringWithFormat:@"%i", (int)self.systolicSlider.value];
        self.diastolicTextField.text = [NSString stringWithFormat:@"%i", (int)self.diastolicSlider.value];
        self.pulseTextField.text = [NSString stringWithFormat:@"%i", (int)self.pulseSlider.value];
    }
    
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

    self.bloodPressureDrawingView.frame = CGRectMake(FIRST_COLUMN_X_COORD+(self.fluidTableView.frame.origin.x - self.view.bounds.origin.x), self.fluidTableView.frame.origin.y + self.fluidTableView.frame.size.height, self.fluidTableView.frame.size.width - FIRST_COLUMN_X_COORD, self.ventsTableView.frame.origin.y - self.fluidTableView.frame.origin.y -self.fluidTableView.frame.size.height);
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

    doseView.frame = CGRectMake( [self.timeScrollView dateToXCoord:agent.startTime] + FIRST_COLUMN_X_COORD, 0, width, cell.bounds.size.height );
    [doseView setNeedsUpdateConstraints];

    return doseView;
}


-(UILabel*)viewForMeasurement:(Measurement*)measurement forCell:(UITableViewCell*)cell{
    UILabel *label = [[UILabel alloc] init];
    label.text = measurement.value;
    label.textAlignment = NSTextAlignmentCenter;
    
    label.frame = CGRectMake( [self.timeScrollView dateToXCoord:measurement.time] + FIRST_COLUMN_X_COORD, 0, COLUMN_INTERVAL_WIDTH, cell.bounds.size.height );
    
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
    [self populateBPGrid];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = obj;
        CGPoint touchPoint = [touch locationInView:self.view];
        CGRect gridBounds = CGRectMake( FIRST_COLUMN_X_COORD, self.fluidTableView.frame.origin.y + self.fluidTableView.frame.size.height, self.fluidTableView.frame.size.width, self.vitalsTableView.frame.origin.y - self.fluidTableView.frame.origin.y +self.fluidTableView.frame.size.height);
        CGFloat minimumX = CGRectGetMinX(gridBounds);
        CGFloat maximumX = CGRectGetMaxX(gridBounds);
        CGFloat minimumY = CGRectGetMinY(gridBounds);
        CGFloat maximumY = CGRectGetMaxY(gridBounds);
       
        if ((touchPoint.x > minimumX && touchPoint.x < maximumX) && (touchPoint.y > minimumY && touchPoint.y < maximumY) ) {
            NSDate* now = [NSDate date];
            
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:now];
            NSInteger minute = [components minute];
            
            minute -= minute%5;
            [components setMinute:minute];
            now = [calendar dateFromComponents:components];
            if (minute%10 < 5) {
                minute -= minute%5;
            } else  {
                minute += 5;
                [components setMinute:minute];
                now = [calendar dateFromComponents:components];
            }
            self.lastTouchTime = now;
            [self showBPView];
        }
    }];
}

-(void)showBPView
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [self.bpGridView.layer addAnimation:transition forKey:nil];
    
    [self.view addSubview:self.bpGridView];
}

-(void)sliderValueChanged:(UISlider*)slider {
    if (slider == self.systolicSlider) {
        self.systolicTextfield.text = [NSString stringWithFormat:@"%i", (int)slider.value];
    } else if (slider == self.diastolicSlider) {
        self.diastolicTextField.text = [NSString stringWithFormat:@"%i", (int)slider.value];
    } else if (slider == self.pulseSlider) {
        self.pulseTextField.text = [NSString stringWithFormat:@"%i", (int)slider.value];
    }
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == self.systolicTextfield) {
        self.systolicSlider.value = [self.systolicTextfield.text integerValue];
    } else if (textField == self.diastolicTextField) {
        self.diastolicSlider.value = [self.diastolicTextField.text integerValue];
    } else if (textField == self.pulseTextField) {
        self.pulseSlider.value = [self.pulseTextField.text integerValue];
    }
    
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)cancelBPChange:(id)sender {
    [self removeBPSubView];
}

-(void)removeBPSubView
{
    CGRect temp = self.bpGridView.frame;
    CGRect original = temp;
    temp.origin.x = -5000;
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.bpGridView.frame = temp;
                     } completion:^(BOOL finished) {
                         [self.bpGridView removeFromSuperview];
                         self.bpGridView.frame = original;
                     }];
}

- (IBAction)saveBloodPressure:(id)sender {
    BloodPressure *bp = (BloodPressure*)[BBUtil newCoreDataObjectForEntityName:@"BloodPressure"];
    bp.systolic = self.systolicTextfield.text;
    bp.diastolic = self.diastolicTextField.text;
    bp.rate = self.pulseTextField.text;
    bp.time = self.lastTouchTime;
    [self.intraOp addBloodPressuresObject:bp];
    [self removeBPSubView];
    [self populateBPGrid];
}

-(float)convertBPValueToGridY:(float)yPointRate {
    
    return (self.bloodPressureDrawingView.bounds.size.height -((yPointRate/260.0)*self.bloodPressureDrawingView.bounds.size.height));
}

-(void)populateBPGrid
{
    self.bloodPressureDrawingView.layer.sublayers = nil;
    
    for (BloodPressure *p in self.intraOp.bloodPressures) {
        float yPointSystolic = [p.systolic floatValue];
        float yPointDiastolic = [p.diastolic floatValue];
        float yPointRate = [p.rate floatValue];
        /* Rate */
        UIView *rateView = [[UIView alloc] init];
        [rateView setBackgroundColor:[UIColor grayColor]];
        rateView.userInteractionEnabled = NO;
        rateView.frame = CGRectMake([self.timeScrollView dateToXCoord:p.time]-10, [self convertBPValueToGridY:yPointRate], 20, 20);
        rateView.layer.cornerRadius = 10;
        CGMutablePathRef path = CGPathCreateMutable();
        /* Systolic */
        CGPathMoveToPoint(path,NULL,[self.timeScrollView dateToXCoord:p.time]-10,[self convertBPValueToGridY:yPointSystolic]-10);
        CGPathAddLineToPoint(path, NULL, [self.timeScrollView dateToXCoord:p.time], [self convertBPValueToGridY:yPointSystolic]);
        CGPathAddLineToPoint(path, NULL, [self.timeScrollView dateToXCoord:p.time]+10, [self convertBPValueToGridY:yPointSystolic]-10);
        /* Diastolic */
        CGPathMoveToPoint(path,NULL,[self.timeScrollView dateToXCoord:p.time]-10,[self convertBPValueToGridY:yPointDiastolic]+10);
        CGPathAddLineToPoint(path, NULL, [self.timeScrollView dateToXCoord:p.time], [self convertBPValueToGridY:yPointDiastolic]);
        CGPathAddLineToPoint(path, NULL, [self.timeScrollView dateToXCoord:p.time]+10, [self convertBPValueToGridY:yPointDiastolic]+10);
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setPath:path];
        [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [shapeLayer setStrokeColor:[[UIColor grayColor] CGColor]];
        [shapeLayer setBounds:CGRectMake(0.0f, 0.0f, 10.0f, 10)];
        [shapeLayer setAnchorPoint:CGPointMake(0.0f, 0.0f)];
        [shapeLayer setPosition:CGPointMake(0.0f, 0.0f)];
        [[self.bloodPressureDrawingView  layer] addSublayer:shapeLayer];
        CGPathRelease(path);
        [self.bloodPressureDrawingView addSubview:rateView];
    }
}



@end
