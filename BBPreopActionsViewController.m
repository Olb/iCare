//
//  BBPreopActionsViewController.m
//  iCare
//
//  Created by Bogdan Marinescu on 8/26/14.
//  Copyright (c) 2014 Bogdan Marinescu. All rights reserved.
//

#import "BBPreopActionsViewController.h"
#import "FormSection.h"
#import "BBUtil.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "BBStringArrayTableAdapter.h"

NSString *const SECTION_TITLE = @"Anesthesia PreOp time used to";
NSString *const CONSENT_KEY = @"Check consents and review chart/plan with Pt";
NSString *const START_IV_KEY = @"Start IV";
NSString *const OTHER_PREOP_ACTIONS = @"OtherPreopActions";

@interface BBPreopActionsViewController () <BBStringArrayTableDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *checkConsentsCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *startIvCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;
@property (weak, nonatomic) IBOutlet UITableView *otherActionsTable;
@property (strong, nonatomic) BBStringArrayTableAdapter *stringArrayTableAdapter;
@end

@implementation BBPreopActionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.stringArrayTableAdapter = [[BBStringArrayTableAdapter alloc] init];
    self.otherActionsTable.dataSource = self.stringArrayTableAdapter;
    self.otherActionsTable.delegate = self.stringArrayTableAdapter;
    
    [self validateSection:_section];
    NSArray *elements = [_section allElements];
    for (FormElement *element in elements) {
        
        if ([element.key isEqualToString:CONSENT_KEY]) {
            [self.checkConsentsCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
        }
        if ([element.key isEqualToString:START_IV_KEY]) {
            [self.checkConsentsCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
        }
        if ([element.key isEqualToString:OTHER_PREOP_ACTIONS]) {
            self.stringArrayTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
        }
    }
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

- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)accept:(id)sender {
    if ( !self.section ){
        self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
        self.section.title = SECTION_TITLE;
    }
    
    FormGroup *group = [self.section.groups firstObject];
    if ( !group ){
        group =(FormGroup*)[BBUtil newCoreDataObjectForEntityName:@"FormGroup"];
        [self.section addGroupsObject:group];
    }
    
    BooleanFormElement *checkConsents = (BooleanFormElement*)[group getElementForKey:CONSENT_KEY];
    if (!checkConsents) {
        checkConsents = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
        checkConsents.key = CONSENT_KEY;
        [group addElementsObject:checkConsents];
    }
    checkConsents.value = [NSNumber numberWithBool:self.checkConsentsCheckBox.isSelected];
    
    BooleanFormElement *startIV = (BooleanFormElement*)[group getElementForKey:START_IV_KEY];
    if (!startIV) {
        startIV = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
        startIV.key = START_IV_KEY;
        [group addElementsObject:startIV];
    }
    startIV.value = [NSNumber numberWithBool:self.satrtIvCheckBox.isSelected];
    
    StringListElement *stringListElement = (StringListElement*)[group getElementForKey:OTHER_PREOP_ACTIONS];
    if (!stringListElement) {
        stringListElement = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
        stringListElement.key = OTHER_PREOP_ACTIONS;
        [group addElementsObject:stringListElement];
    }
    
    NSMutableArray *stringArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < [self.otherActionsTable numberOfRowsInSection:0]; i++) {
        UITableViewCell *cell = [self.otherActionsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [stringArray addObject:cell.textLabel.text];
    }
    stringListElement.value = stringArray;
    
    [self.delegate sectionCreated:self.section];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOtherAction:(id)sender {
    [self.stringArrayTableAdapter.items addObject:self.otherTextField.text];
    [self.otherActionsTable reloadData];
    self.otherTextField.text = @"";
    [self.otherTextField resignFirstResponder];
}

#pragma mark - Tableview delegate methods

-(void) itemDeleted:(NSString*)item atIndexPathRow:(NSInteger)row
{
    [self.stringArrayTableAdapter.items removeObjectAtIndex:row];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (![textField.text isEqualToString:@""]) {
        [self.stringArrayTableAdapter.items addObject:textField.text];
        [self.otherActionsTable reloadData];
        textField.text = @"";
    }
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)disablesAutomaticKeyboardDismissal {
    return NO;
}


@end
