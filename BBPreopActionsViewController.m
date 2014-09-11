//
//  BBPreopActionsViewController.m
//  iCare
//
//  Created by Bogdan Marinescu on 8/26/14.
//  Copyright (c) 2014 Bogdan Marinescu. All rights reserved.
//

#import "BBPreopActionsViewController.h"
#import "BBCheckBox.h"
#import "FormSection.h"
#import "BBUtil.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BooleanFormElement.h"

const NSString *SECTION_TITLE = @"Anesthesia PreOp time used to";

@interface BBPreopActionsViewController ()
@property (weak, nonatomic) IBOutlet BBCheckBox *checkConsentsCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *satrtIvCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;
@property (weak, nonatomic) IBOutlet UITableView *otherActionsTable;

@end

@implementation BBPreopActionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_section){
        NSAssert([SECTION_TITLE isEqualToString:self.section.title], @"Invalid section title");
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOtherAction:(id)sender {
    
}

- (IBAction)accept:(id)sender {
    if ( !self.section ){
        self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
    }
    
    FormGroup *group = [self.section.groups firstObject];
    if ( !group ){
        group =(FormGroup*)[BBUtil newCoreDataObjectForEntityName:@"FormGroup"];
        [self.section addGroupsObject:group];
    }
    
    BooleanFormElement *checkConsents = [group getElementForKey:@"Check consents and review chart/plan with Pt"];
}

@end
