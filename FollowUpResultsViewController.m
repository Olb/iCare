/*This file is generated by perlxml.pl. DO NOT MODIFY */

#import "FollowUpResultsViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"

#import "ElementListFormElement.h"

#import "FormElementTableAdapter.h"

#import "FormElementTableCellFactory.h"

#import "AntibioticFormElement.h"

#import "MedicationFormElement.h"


@interface FollowUpResultsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *preOpBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *orBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *pacuBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *postOpLess24BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *postOp24to48BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *postOpGreater48BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *noChangeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *additionalPtCareBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *notApplicableBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *noInjuryBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *injuryBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *deathBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *unresolvedBBCheckBox;
@end

@implementation FollowUpResultsViewController
NSString *const FOLLOW_UP_RESULTS_SECTION_TITLE = @"FollowUpResultsSectionKey";
static NSString *const PRE_OP_KEY = @"PreOpKey";
static NSString *const OR_KEY = @"OrKey";
static NSString *const PACU_KEY = @"PacuKey";
static NSString *const POST_OP_LESS24_KEY = @"PostOpLess24Key";
static NSString *const POST_OP24to48_KEY = @"PostOp24to48Key";
static NSString *const POST_OP_GREATER48_KEY = @"PostOpGreater48Key";
static NSString *const NO_CHANGE_KEY = @"NoChangeKey";
static NSString *const ADDITIONAL_PT_CARE_KEY = @"AdditionalPtCareKey";
static NSString *const NOT_APPLICABLE_KEY = @"NotApplicableKey";
static NSString *const NO_INJURY_KEY = @"NoInjuryKey";
static NSString *const INJURY_KEY = @"InjuryKey";
static NSString *const DEATH_KEY = @"DeathKey";
static NSString *const UNRESOLVED_KEY = @"UnresolvedKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:PRE_OP_KEY]){
				 [self.preOpBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OR_KEY]){
				 [self.orBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PACU_KEY]){
				 [self.pacuBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POST_OP_LESS24_KEY]){
				 [self.postOpLess24BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POST_OP24to48_KEY]){
				 [self.postOp24to48BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POST_OP_GREATER48_KEY]){
				 [self.postOpGreater48BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NO_CHANGE_KEY]){
				 [self.noChangeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ADDITIONAL_PT_CARE_KEY]){
				 [self.additionalPtCareBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NOT_APPLICABLE_KEY]){
				 [self.notApplicableBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NO_INJURY_KEY]){
				 [self.noInjuryBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INJURY_KEY]){
				 [self.injuryBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DEATH_KEY]){
				 [self.deathBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:UNRESOLVED_KEY]){
				 [self.unresolvedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:PRE_OP_KEY]!= nil, @"PreOp is nil");
	 NSAssert([section getElementForKey:OR_KEY]!= nil, @"Or is nil");
	 NSAssert([section getElementForKey:PACU_KEY]!= nil, @"Pacu is nil");
	 NSAssert([section getElementForKey:POST_OP_LESS24_KEY]!= nil, @"PostOpLess24 is nil");
	 NSAssert([section getElementForKey:POST_OP24to48_KEY]!= nil, @"PostOp24to48 is nil");
	 NSAssert([section getElementForKey:POST_OP_GREATER48_KEY]!= nil, @"PostOpGreater48 is nil");
	 NSAssert([section getElementForKey:NO_CHANGE_KEY]!= nil, @"NoChange is nil");
	 NSAssert([section getElementForKey:ADDITIONAL_PT_CARE_KEY]!= nil, @"AdditionalPtCare is nil");
	 NSAssert([section getElementForKey:NOT_APPLICABLE_KEY]!= nil, @"NotApplicable is nil");
	 NSAssert([section getElementForKey:NO_INJURY_KEY]!= nil, @"NoInjury is nil");
	 NSAssert([section getElementForKey:INJURY_KEY]!= nil, @"Injury is nil");
	 NSAssert([section getElementForKey:DEATH_KEY]!= nil, @"Death is nil");
	 NSAssert([section getElementForKey:UNRESOLVED_KEY]!= nil, @"Unresolved is nil");
	 
}

-(BOOL)validateData:(NSString**)errMsg
{
	 return true; 
}

- (IBAction)accept:(id)sender {
	 NSString* errMsg;
	 if ( ! [self validateData: &errMsg] ){
		 [BBUtil showAlertWithMessage:errMsg];
		 return;
	 }
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = FOLLOW_UP_RESULTS_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *preOp = (BooleanFormElement*)[_section getElementForKey:PRE_OP_KEY];
	 if (!preOp) {
		 preOp = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 preOp.key = PRE_OP_KEY;
		 [_section addElementsObject:preOp];
	 }

	 preOp.value = [NSNumber numberWithBool:self.preOpBBCheckBox.isSelected];
	 
	 BooleanFormElement *or = (BooleanFormElement*)[_section getElementForKey:OR_KEY];
	 if (!or) {
		 or = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 or.key = OR_KEY;
		 [_section addElementsObject:or];
	 }

	 or.value = [NSNumber numberWithBool:self.orBBCheckBox.isSelected];
	 
	 BooleanFormElement *pacu = (BooleanFormElement*)[_section getElementForKey:PACU_KEY];
	 if (!pacu) {
		 pacu = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pacu.key = PACU_KEY;
		 [_section addElementsObject:pacu];
	 }

	 pacu.value = [NSNumber numberWithBool:self.pacuBBCheckBox.isSelected];
	 
	 BooleanFormElement *postOpLess24 = (BooleanFormElement*)[_section getElementForKey:POST_OP_LESS24_KEY];
	 if (!postOpLess24) {
		 postOpLess24 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 postOpLess24.key = POST_OP_LESS24_KEY;
		 [_section addElementsObject:postOpLess24];
	 }

	 postOpLess24.value = [NSNumber numberWithBool:self.postOpLess24BBCheckBox.isSelected];
	 
	 BooleanFormElement *postOp24to48 = (BooleanFormElement*)[_section getElementForKey:POST_OP24to48_KEY];
	 if (!postOp24to48) {
		 postOp24to48 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 postOp24to48.key = POST_OP24to48_KEY;
		 [_section addElementsObject:postOp24to48];
	 }

	 postOp24to48.value = [NSNumber numberWithBool:self.postOp24to48BBCheckBox.isSelected];
	 
	 BooleanFormElement *postOpGreater48 = (BooleanFormElement*)[_section getElementForKey:POST_OP_GREATER48_KEY];
	 if (!postOpGreater48) {
		 postOpGreater48 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 postOpGreater48.key = POST_OP_GREATER48_KEY;
		 [_section addElementsObject:postOpGreater48];
	 }

	 postOpGreater48.value = [NSNumber numberWithBool:self.postOpGreater48BBCheckBox.isSelected];
	 
	 BooleanFormElement *noChange = (BooleanFormElement*)[_section getElementForKey:NO_CHANGE_KEY];
	 if (!noChange) {
		 noChange = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 noChange.key = NO_CHANGE_KEY;
		 [_section addElementsObject:noChange];
	 }

	 noChange.value = [NSNumber numberWithBool:self.noChangeBBCheckBox.isSelected];
	 
	 BooleanFormElement *additionalPtCare = (BooleanFormElement*)[_section getElementForKey:ADDITIONAL_PT_CARE_KEY];
	 if (!additionalPtCare) {
		 additionalPtCare = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 additionalPtCare.key = ADDITIONAL_PT_CARE_KEY;
		 [_section addElementsObject:additionalPtCare];
	 }

	 additionalPtCare.value = [NSNumber numberWithBool:self.additionalPtCareBBCheckBox.isSelected];
	 
	 BooleanFormElement *notApplicable = (BooleanFormElement*)[_section getElementForKey:NOT_APPLICABLE_KEY];
	 if (!notApplicable) {
		 notApplicable = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 notApplicable.key = NOT_APPLICABLE_KEY;
		 [_section addElementsObject:notApplicable];
	 }

	 notApplicable.value = [NSNumber numberWithBool:self.notApplicableBBCheckBox.isSelected];
	 
	 BooleanFormElement *noInjury = (BooleanFormElement*)[_section getElementForKey:NO_INJURY_KEY];
	 if (!noInjury) {
		 noInjury = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 noInjury.key = NO_INJURY_KEY;
		 [_section addElementsObject:noInjury];
	 }

	 noInjury.value = [NSNumber numberWithBool:self.noInjuryBBCheckBox.isSelected];
	 
	 BooleanFormElement *injury = (BooleanFormElement*)[_section getElementForKey:INJURY_KEY];
	 if (!injury) {
		 injury = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 injury.key = INJURY_KEY;
		 [_section addElementsObject:injury];
	 }

	 injury.value = [NSNumber numberWithBool:self.injuryBBCheckBox.isSelected];
	 
	 BooleanFormElement *death = (BooleanFormElement*)[_section getElementForKey:DEATH_KEY];
	 if (!death) {
		 death = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 death.key = DEATH_KEY;
		 [_section addElementsObject:death];
	 }

	 death.value = [NSNumber numberWithBool:self.deathBBCheckBox.isSelected];
	 
	 BooleanFormElement *unresolved = (BooleanFormElement*)[_section getElementForKey:UNRESOLVED_KEY];
	 if (!unresolved) {
		 unresolved = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 unresolved.key = UNRESOLVED_KEY;
		 [_section addElementsObject:unresolved];
	 }

	 unresolved.value = [NSNumber numberWithBool:self.unresolvedBBCheckBox.isSelected];
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [BBUtil refreshManagedObject:_section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return FOLLOW_UP_RESULTS_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 sender.selected = selected;
}
@end