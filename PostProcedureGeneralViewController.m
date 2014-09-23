
#import "PostProcedureGeneralViewController.h"
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


@interface PostProcedureGeneralViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *stableBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *dentitionIntactBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *postProcedureGeneralConditionOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *postProcedureGeneralConditionOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet UITextField *bpSystolicUITextField;
@property (weak, nonatomic) IBOutlet UITextField *diastolicUITextField;
@property (weak, nonatomic) IBOutlet UITextField *hrUITextField;
@property (weak, nonatomic) IBOutlet UITextField *rrUITextField;
@property (weak, nonatomic) IBOutlet UITextField *tempUITextField;
@property (weak, nonatomic) IBOutlet UITextField *spO2UITextField;
@end

@implementation PostProcedureGeneralViewController
NSString *const POST_PROCEDURE_GENERAL_SECTION_TITLE = @"PostProcedureGeneralSectionKey";
static NSString *const STABLE_KEY = @"StableKey";
static NSString *const DENTITION_INTACT_KEY = @"DentitionIntactKey";
static NSString *const POST_PROCEDURE_GENERAL_CONDITION_OTHER_KEY = @"PostProcedureGeneralConditionOtherKey";
static NSString *const POST_PROCEDURE_GENERAL_CONDITION_OTHER_REASON_KEY = @"PostProcedureGeneralConditionOtherReasonKey";
static NSString *const BP_SYSTOLIC_KEY = @"BpSystolicKey";
static NSString *const DIASTOLIC_KEY = @"DiastolicKey";
static NSString *const HR_KEY = @"HrKey";
static NSString *const RR_KEY = @"RrKey";
static NSString *const TEMP_KEY = @"TempKey";
static NSString *const SPO2_KEY = @"SpO2Key";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:STABLE_KEY]){
				 [self.stableBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTITION_INTACT_KEY]){
				 [self.dentitionIntactBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POST_PROCEDURE_GENERAL_CONDITION_OTHER_KEY]){
				 [self.postProcedureGeneralConditionOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POST_PROCEDURE_GENERAL_CONDITION_OTHER_REASON_KEY]){
				 [self.postProcedureGeneralConditionOtherReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:BP_SYSTOLIC_KEY]){
				 [self.bpSystolicUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:DIASTOLIC_KEY]){
				 [self.diastolicUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:HR_KEY]){
				 [self.hrUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:RR_KEY]){
				 [self.rrUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:TEMP_KEY]){
				 [self.tempUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:SPO2_KEY]){
				 [self.spO2UITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:STABLE_KEY]!= nil, @"Stable is nil");
	 NSAssert([section getElementForKey:DENTITION_INTACT_KEY]!= nil, @"DentitionIntact is nil");
	 NSAssert([section getElementForKey:POST_PROCEDURE_GENERAL_CONDITION_OTHER_KEY]!= nil, @"PostProcedureGeneralConditionOther is nil");
	 NSAssert([section getElementForKey:POST_PROCEDURE_GENERAL_CONDITION_OTHER_REASON_KEY]!= nil, @"PostProcedureGeneralConditionOtherReason is nil");
	 NSAssert([section getElementForKey:BP_SYSTOLIC_KEY]!= nil, @"BpSystolic is nil");
	 NSAssert([section getElementForKey:DIASTOLIC_KEY]!= nil, @"Diastolic is nil");
	 NSAssert([section getElementForKey:HR_KEY]!= nil, @"Hr is nil");
	 NSAssert([section getElementForKey:RR_KEY]!= nil, @"Rr is nil");
	 NSAssert([section getElementForKey:TEMP_KEY]!= nil, @"Temp is nil");
	 NSAssert([section getElementForKey:SPO2_KEY]!= nil, @"SpO2 is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = POST_PROCEDURE_GENERAL_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *stable = (BooleanFormElement*)[_section getElementForKey:STABLE_KEY];
	 if (!stable) {
		 stable = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 stable.key = STABLE_KEY;
		 [_section addElementsObject:stable];
	 }

	 stable.value = [NSNumber numberWithBool:self.stableBBCheckBox.isSelected];
	 
	 BooleanFormElement *dentitionIntact = (BooleanFormElement*)[_section getElementForKey:DENTITION_INTACT_KEY];
	 if (!dentitionIntact) {
		 dentitionIntact = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 dentitionIntact.key = DENTITION_INTACT_KEY;
		 [_section addElementsObject:dentitionIntact];
	 }

	 dentitionIntact.value = [NSNumber numberWithBool:self.dentitionIntactBBCheckBox.isSelected];
	 
	 BooleanFormElement *postProcedureGeneralConditionOther = (BooleanFormElement*)[_section getElementForKey:POST_PROCEDURE_GENERAL_CONDITION_OTHER_KEY];
	 if (!postProcedureGeneralConditionOther) {
		 postProcedureGeneralConditionOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 postProcedureGeneralConditionOther.key = POST_PROCEDURE_GENERAL_CONDITION_OTHER_KEY;
		 [_section addElementsObject:postProcedureGeneralConditionOther];
	 }

	 postProcedureGeneralConditionOther.value = [NSNumber numberWithBool:self.postProcedureGeneralConditionOtherBBCheckBox.isSelected];
	 
	 TextElement *postProcedureGeneralConditionOtherReason = (TextElement*)[_section getElementForKey:POST_PROCEDURE_GENERAL_CONDITION_OTHER_REASON_KEY];
	 if (!postProcedureGeneralConditionOtherReason) {
		 postProcedureGeneralConditionOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 postProcedureGeneralConditionOtherReason.key = POST_PROCEDURE_GENERAL_CONDITION_OTHER_REASON_KEY;
		 [_section addElementsObject:postProcedureGeneralConditionOtherReason];
	 }

	 postProcedureGeneralConditionOtherReason.value = self.postProcedureGeneralConditionOtherReasonUITextField.text;
	 
	 TextElement *bpSystolic = (TextElement*)[_section getElementForKey:BP_SYSTOLIC_KEY];
	 if (!bpSystolic) {
		 bpSystolic = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 bpSystolic.key = BP_SYSTOLIC_KEY;
		 [_section addElementsObject:bpSystolic];
	 }

	 bpSystolic.value = self.bpSystolicUITextField.text;
	 
	 TextElement *diastolic = (TextElement*)[_section getElementForKey:DIASTOLIC_KEY];
	 if (!diastolic) {
		 diastolic = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 diastolic.key = DIASTOLIC_KEY;
		 [_section addElementsObject:diastolic];
	 }

	 diastolic.value = self.diastolicUITextField.text;
	 
	 TextElement *hr = (TextElement*)[_section getElementForKey:HR_KEY];
	 if (!hr) {
		 hr = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 hr.key = HR_KEY;
		 [_section addElementsObject:hr];
	 }

	 hr.value = self.hrUITextField.text;
	 
	 TextElement *rr = (TextElement*)[_section getElementForKey:RR_KEY];
	 if (!rr) {
		 rr = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 rr.key = RR_KEY;
		 [_section addElementsObject:rr];
	 }

	 rr.value = self.rrUITextField.text;
	 
	 TextElement *temp = (TextElement*)[_section getElementForKey:TEMP_KEY];
	 if (!temp) {
		 temp = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 temp.key = TEMP_KEY;
		 [_section addElementsObject:temp];
	 }

	 temp.value = self.tempUITextField.text;
	 
	 TextElement *spO2 = (TextElement*)[_section getElementForKey:SPO2_KEY];
	 if (!spO2) {
		 spO2 = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 spO2.key = SPO2_KEY;
		 [_section addElementsObject:spO2];
	 }

	 spO2.value = self.spO2UITextField.text;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return POST_PROCEDURE_GENERAL_SECTION_TITLE;
}
@end