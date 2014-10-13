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
#import "CustomLayer.h"
#import "BBData.h"
#import "Operation.h"
#import "Patient.h"
#import "Form.h"
#import "FormSection.h"
#import "StringListElement.h"
#import "Allergy.h"
#import "IntraOpDetailsViewController.h"
#import "AnesthesiaRecordController.h"
#import "IntraOpPdfGenerator.h"
#import "PDFDisplayViewController.h"
#import "BBPdfGenerator.h"
#import "MeasurementLabel.h"

@interface IntraOpViewController () <UITextFieldDelegate, UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *allergyListTextView;
@property (weak, nonatomic) IBOutlet UITableView *gasTableView;
@property (weak, nonatomic) IBOutlet UITableView *vitalsTableView;
@property (weak, nonatomic) IBOutlet IntraOpGrid *gridView;
@property (weak, nonatomic) IBOutlet UITableView *medicationTableView;
@property (weak, nonatomic) IBOutlet UITableView *fluidTableView;
@property (weak, nonatomic) IBOutlet UITableView *ventsTableView;
@property (weak, nonatomic) IBOutlet UITableView *eblTableView;
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
@property BOOL bpGridViewShowing;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gasButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *medicationButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *fluidButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *monitorsButton;
@property (weak, nonatomic) IBOutlet UIView *disabledView;
@property CGRect disabledViewFrameOrigin;

@end

@implementation IntraOpViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    if (!self.intraOp.anesthesiaStart || self.intraOp.anesthesiaEnd) {
        [self allowInteraction:NO];
    } else {
        [self allowInteraction:YES];
    }
    
    [self loadAllergies];
    UITapGestureRecognizer *disabledViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showDisabledAlert:)];
    [self.disabledView addGestureRecognizer:disabledViewGesture];
    if (self.intraOp.anesthesiaStart && !self.intraOp.anesthesiaEnd) {
        [self allowInteraction:YES];
    } else {
        [self allowInteraction:NO];
    }
    self.bpGridView =  [[[NSBundle mainBundle] loadNibNamed:@"IntraOpBPView" owner:self options:nil] objectAtIndex:0];
    self.bpGridViewShowing = NO;
    
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
    if (self.intraOp.anesthesiaStart) {
        [self.timeScrollView setStartTime:self.intraOp.anesthesiaStart];
    } else {
        [self.timeScrollView setStartTime:[NSDate date]];
    }
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

-(void)startAnesthesia
{
    [self.timeScrollView setStartTime:self.intraOp.anesthesiaStart];
    self.timeScrollView.onScroll = ^{
        [self reloadTables];
    };
    [self allowInteraction:YES];
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self reloadTables];
    self.disabledViewFrameOrigin = self.disabledView.frame;
    if (self.intraOp.anesthesiaStart && !self.intraOp.anesthesiaEnd) {
        [self allowInteraction:YES];
    } else {
        [self allowInteraction:NO];
    }
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

-(void)showDisabledAlert:(UITapGestureRecognizer*)gesture
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"PreOp Disabled" message:@"PreOp interaction disabled until Anesthesia Start Time is set" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alert show];
}

-(void)allowInteraction:(BOOL)enable
{
    //[self.disabledView setUserInteractionEnabled:NO];

    if (enable) {
        self.gasButton.enabled = YES;
        self.medicationButton.enabled = YES;
        self.fluidButton.enabled = YES;
        self.monitorsButton.enabled = YES;
        [self.disabledView setUserInteractionEnabled:NO];

    } else if (!enable) {
        self.gasButton.enabled = NO;
        self.medicationButton.enabled = NO;
        self.fluidButton.enabled = NO;
        self.monitorsButton.enabled = NO;
        [self.disabledView setUserInteractionEnabled:YES];
    }
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

-(void)editDoseView:(UITapGestureRecognizer*)gesture
{
    Agent *agent = ((DoseView*)gesture.view).agent;
    NSLog(@"Dose view is awesome: %@", agent);
    if ([agent.type isEqualToString:@"Gas"]) {
        AddGasViewController *vc = [[AddGasViewController alloc] initWithIntraOp:self.intraOp completion:^{
            [self reloadTables];
        }];
        vc.agent = agent;
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    } else if ([agent.type isEqualToString:@"Medication"]) {
        AddMedicationViewController *vc = [[AddMedicationViewController alloc] initWithIntraOp:self.intraOp completion:^{
            [self reloadTables];
        }];
        vc.agent = agent;
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    } else if ([agent.type isEqualToString:@"Fluid"]) {
        AddFluidViewController *vc = [[AddFluidViewController alloc] initWithIntraOp:self.intraOp completion:^{
            [self reloadTables];
        }];
        vc.agent = agent;
        vc.modalPresentationStyle = UIModalPresentationFormSheet;
        [self.navigationController presentViewController:vc animated:YES completion:nil];
    } else {
        [NSException raise:@"UnknownAgentType" format:@"type = %@",agent.type];
    }
}

-(DoseView*)doseViewForAgent:(Agent*)agent forCell:(UITableViewCell*)cell
{
    DoseView *doseView = [[[NSBundle mainBundle] loadNibNamed:@"DoseView" owner:self options:nil] objectAtIndex:0];
    [doseView.tapGesture addTarget:self action:@selector(editDoseView:)];
    [doseView setUserInteractionEnabled:YES];
    doseView.dose.text = agent.dose;
    doseView.agent = agent;
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

-(void)editMeasurement:(UITapGestureRecognizer*)gesture
{
    AddMeasurementsViewController *vc = [[AddMeasurementsViewController alloc] initWithIntraOp:self.intraOp completion:^{
        [self reloadTables];
    }];
    vc.measurement = ((MeasurementLabel*)gesture.view).measurement;
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
-(UILabel*)viewForMeasurement:(Measurement*)measurement forCell:(UITableViewCell*)cell{
    MeasurementLabel *label = [[MeasurementLabel alloc] init];
    label.measurement = measurement;
    label.text = measurement.value;
    label.textAlignment = NSTextAlignmentCenter;
    UITapGestureRecognizer *g = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(editMeasurement:)];
    [label setUserInteractionEnabled:YES];
    [label addGestureRecognizer:g];
    
    NSLog(@"Measurement Start Time: %@, \nxCoord:%d",measurement.time, [self.timeScrollView dateToXCoord:measurement.time]);
    label.frame = CGRectMake( [self.timeScrollView dateToXCoord:measurement.time] + FIRST_COLUMN_X_COORD, 0, COLUMN_INTERVAL_WIDTH, cell.bounds.size.height );
    
    return label;
}

-(CGRect)frameRectForStartTime:(NSDate*)startTime withEndTime:(NSDate*)endTime
{
    return CGRectZero;
}

-(void) reloadTables
{
    [self.gasTableView reloadData];
    [self.medicationTableView reloadData];
    [self.fluidTableView reloadData];
    [self.vitalsTableView reloadData];
    [self.ventsTableView reloadData];
    [self.eblTableView reloadData];
    [self populateBPGrid];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (self.disabledView.userInteractionEnabled) {
        return;
    }
    if (self.bpGridViewShowing) {
        return;
    }
    [touches enumerateObjectsUsingBlock:^(id obj, BOOL *stop) {
        UITouch *touch = obj;
        CGPoint touchPoint = [touch locationInView:self.view];
       
        if ( CGRectContainsPoint(self.bloodPressureDrawingView.frame, touchPoint) ) {
            NSDate* now = [NSDate date];
            NSCalendar *calendar = [NSCalendar currentCalendar];
            NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:now];
            NSInteger minute = [components minute];
            if (minute%5 < 3) {
                minute -= minute%5;
            } else  {
                minute += 5 - minute%5;
            }
            [components setMinute:minute];
            now = [calendar dateFromComponents:components];

            self.lastTouchTime = now;
            [self showBPView];
        }
    }];
}

-(void)showBPView
{
    self.bpGridView.center = self.view.center;
    self.bpGridView.frame = CGRectMake(self.bpGridView.frame.origin.x, self.bpGridView.frame.origin.y + 65, self.fluidTableView.frame.size.width - FIRST_COLUMN_X_COORD, 226);
    CATransition *transition = [CATransition animation];
    transition.duration = 0.5;
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.bpGridView.layer addAnimation:transition forKey:nil];
    
    [self.view addSubview:self.bpGridView];
    self.bpGridViewShowing = YES;
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

-(void)loadAllergies
{
  
    if (self.intraOp.allergies.count == 0) {
        for (Form *f in self.intraOp.operation.forms) {
            if ([f.title isEqualToString:@"Pre-Operative Anesthesia Evaluation"]) {
                for (FormSection *s in f.sections) {
                    if ([s.title isEqualToString:@"AllergiesReactionsSectionKey"]) {
                        for (StringListElement *e in s.elements) {
                            if ([e.key isEqualToString:@"AllergiesReactionsKey"]){
                                NSArray *a = [[NSMutableArray alloc] initWithArray:((StringListElement*)e).value];
                                for (NSString *s in a) {
                                    Allergy *allergy = (Allergy*)[BBUtil newCoreDataObjectForEntityName:@"Allergy"];
                                    allergy.name = s;
                                    [self.intraOp addAllergiesObject:allergy];
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    NSMutableString *allergiesString = [[NSMutableString alloc] init];
    for (Allergy *a in self.intraOp.allergies) {
        [allergiesString appendString:[NSString stringWithFormat:@"%@\n", a.name]];
    }
    self.allergyListTextView.text = allergiesString;
}


- (IBAction)cancelBPChange:(id)sender {
    [self removeBPSubView];
}

-(void)removeBPSubView
{
    CGRect temp = self.bpGridView.frame;
    temp.origin.x = -5000;
    [UIView animateWithDuration:1.0
                     animations:^{
                         self.bpGridView.frame = temp;
                     } completion:^(BOOL finished) {
                         [self.bpGridView removeFromSuperview];
                         [self.bpGridView.layer removeAllAnimations];
                         self.bpGridViewShowing = NO;
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
    [BBUtil saveContext];
}

-(float)convertBPValueToGridY:(float)yPointRate {
    
    return (self.bloodPressureDrawingView.bounds.size.height -((yPointRate/240.0)*self.bloodPressureDrawingView.bounds.size.height));
}

-(void)populateBPGrid
{
    self.bloodPressureDrawingView.layer.sublayers = nil;
    
    for (BloodPressure *p in self.intraOp.bloodPressures) {
        float yPointSystolic = [p.systolic floatValue];
        float yPointDiastolic = [p.diastolic floatValue];
        float yPointRate = [p.rate floatValue];
        /* Rate */
        float XCoord = [self.timeScrollView dateToXCoord:p.time];
        if ( (XCoord < 0) || (XCoord > self.fluidTableView.frame.size.width-FIRST_COLUMN_X_COORD) ) {
            NSLog(@"Out of bounds xCoord: %f", XCoord);
            NSLog(@"p.time: %@", p.time);
            continue;
        }
        UIView *rateView = [[UIView alloc] init];
        [rateView setBackgroundColor:[UIColor grayColor]];
        rateView.userInteractionEnabled = NO;
        rateView.frame = CGRectMake(XCoord-10, [self convertBPValueToGridY:yPointRate]-10, 20, 20);
        rateView.layer.cornerRadius = 10;
        CGMutablePathRef path = CGPathCreateMutable();
        /* Systolic */
        CGPathMoveToPoint(path,NULL, XCoord-10,[self convertBPValueToGridY:yPointSystolic]-10);
        CGPathAddLineToPoint(path, NULL, XCoord, [self convertBPValueToGridY:yPointSystolic]);
        CGPathAddLineToPoint(path, NULL, XCoord+10, [self convertBPValueToGridY:yPointSystolic]-10);
        /* Diastolic */
        CGPathMoveToPoint(path,NULL,XCoord-10,[self convertBPValueToGridY:yPointDiastolic]+10);
        CGPathAddLineToPoint(path, NULL, XCoord, [self convertBPValueToGridY:yPointDiastolic]);
        CGPathAddLineToPoint(path, NULL, XCoord+10, [self convertBPValueToGridY:yPointDiastolic]+10);
        
        CustomLayer *shapeLayer = [CustomLayer layer];
        shapeLayer.p = p;
        [shapeLayer setPath:path];
        [shapeLayer setFillColor:[[UIColor clearColor] CGColor]];
        [shapeLayer setStrokeColor:[[UIColor darkGrayColor] CGColor]];
        [shapeLayer setBounds:CGRectMake(0.0f, 0.0f, 10.0f, 10)];
        [shapeLayer setAnchorPoint:CGPointMake(0.0f, 0.0f)];
        [shapeLayer setPosition:CGPointMake(0.0f, 0.0f)];
        [[self.bloodPressureDrawingView  layer] addSublayer:shapeLayer];
        CGPathRelease(path);
        [self.bloodPressureDrawingView addSubview:rateView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    for (Allergy *allergy in self.intraOp.allergies) {
        [BBUtil deleteManagedObject:allergy];
    }
    NSArray *allergyComponents = [self.allergyListTextView.text componentsSeparatedByString:@"\n"];
    
    for (NSString *allergyName in allergyComponents) {
        if ([allergyName isEqualToString:@""] || [allergyName isEqualToString:@" "]) {
            continue;
        }
        Allergy *a = (Allergy*)[BBUtil newCoreDataObjectForEntityName:@"Allergy"];
        a.name = allergyName;
        [self.intraOp addAllergiesObject:a];
    }
    
    [BBUtil saveContext];
    [self loadAllergies];
}

-(IBAction)showDetialViewController
{
    IntraOpDetailsViewController *vc = [[IntraOpDetailsViewController alloc] init];
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    vc.intraOp = self.intraOp;
    vc.intraOpViewController = self;
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}
- (IBAction)showAnesthesiaRecord:(id)sender {
    AnesthesiaRecordController *vc = [[AnesthesiaRecordController alloc] init];;
    for (Form *f in self.intraOp.operation.forms) {
        if ([f.title isEqualToString:@"Anesthesia Record"]) {
            vc.form = f;
        }
    }
    if (!vc.form) {
        Form *f = (Form*)[BBUtil newCoreDataObjectForEntityName:@"Form"];
        f.title = @"Anesthesia Record";
        [self.intraOp.operation addFormsObject:f];
        vc.form = f;
    }
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (IBAction)showPDF:(id)sender {

    [IntraOpPdfGenerator generatePdfForForm:self.intraOp withView:self.view forIntraOp:self];
//    [IntraOpPdfGenerator createPDFfromUIView:self.view saveToDocumentsWithFileName:[BBPdfGenerator getPDFFileNameForIntraOp:self.intraOp]];

    PDFDisplayViewController *vc = [[PDFDisplayViewController alloc] init];
    vc.intraOp = self.intraOp;
    vc.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    vc.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)scrollToBeginning
{
    [self.timeScrollView setStartTime:self.intraOp.anesthesiaStart];
}

-(void)pageForTime:(NSDate*)timeToScroll
{
    [self.timeScrollView setStartTime:timeToScroll];
}


@end
