//
//  OverviewViewController.m
//  iCare2
//
//  Created by billy bray on 8/26/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "OverviewViewController.h"
#import "BBCheckBox.h"

@interface OverviewViewController ()
@property (weak, nonatomic) IBOutlet BBCheckBox *betaBlockerCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *medicalSuplimentsTextField;
@property (weak, nonatomic) IBOutlet UITextField *pastSurgicalProceduresTextField;
@property (weak, nonatomic) IBOutlet UITextField *alergicReactionsTextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *anesthProblemsNoneCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *anesthProblemsPatientCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *anesthProblemsFamilyCheckBox;

@end

@implementation OverviewViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)addMedicalSupliment:(id)sender {
}
- (IBAction)addPastSurgicalProcedure:(id)sender {
}
- (IBAction)addAlergicReaction:(id)sender {
}

- (IBAction)hxAnesthProblems:(id)sender {
}
@end
