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
#import "StringListElement.h"
NSString *const SECTION_TITLE = @"Anesthesia PreOp time used to";
NSString *const CONSENT_KEY = @"Check consents and review chart/plan with Pt";
NSString *const START_IV_KEY = @"Start IV";
NSString *const OTHER_PREOP_ACTIONS = @"OtherPreopActions";

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
    
    [self validateSection:_section];
}

-(void)validateSection:(FormSection*)section
{
    if (_section) {
        NSAssert([SECTION_TITLE isEqualToString:self.section.title], @"Invalid section title");
        NSAssert([_section.groups count] == 1, @"Invalid number of groups");
        FormGroup *group = [_section.groups firstObject];
        NSAssert([group getElementForKey:CONSENT_KEY]!= nil, @"Consent Element nil");
        NSAssert([group getElementForKey:START_IV_KEY]!= nil, @"Start IV Element nil");
        NSAssert([group getElementForKey:OTHER_PREOP_ACTIONS]!= nil, @"Other Actions Element nil");
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
    
    BooleanFormElement *checkConsents = (BooleanFormElement*)[group getElementForKey:CONSENT_KEY];
    if (!checkConsents) {
        checkConsents = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
        [group addElementsObject:checkConsents];
    }
    checkConsents.value = [NSNumber numberWithBool:self.checkConsentsCheckBox.isSelected];
    
    BooleanFormElement *startIV = (BooleanFormElement*)[group getElementForKey:START_IV_KEY];
    if (!startIV) {
        startIV = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
        [group addElementsObject:startIV];
    }
    startIV.value = [NSNumber numberWithBool:self.satrtIvCheckBox.isSelected];
    
    StringListElement *stringListElement = (StringListElement*)[group getElementForKey:OTHER_PREOP_ACTIONS];
    if (!stringListElement) {
        stringListElement = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
        [group addElementsObject:stringListElement];
    }
    
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.otherActionsTable numberOfRowsInSection:0]; i++) {
        UITableViewCell *cell = [self.otherActionsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [stringArray addObject:cell.textLabel.text];
    }
    stringListElement.value = stringArray;
    
    [self.delegate sectionCreated:self.section];
}

@end
