
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
@property (weak, nonatomic) IBOutlet BBCheckBox *otherBoolBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *otherTextUITextField;
@property (weak, nonatomic) IBOutlet UITextField *bpUITextField;
@property (weak, nonatomic) IBOutlet UITextField *bp2UITextField;
@property (weak, nonatomic) IBOutlet UITextField *hrUITextField;
@property (weak, nonatomic) IBOutlet UITextField *rrUITextField;
@property (weak, nonatomic) IBOutlet UITextField *tempUITextField;
@property (weak, nonatomic) IBOutlet UITextField *spO2UITextField;
@end

@implementation PostProcedureGeneralViewController
NSString *const POST_PROCEDURE_GENERAL_SECTION_TITLE = @"PostProcedureGeneralSectionKey";
static NSString *const STABLE_KEY = @"StableKey";
static NSString *const DENTITION_INTACT_KEY = @"DentitionIntactKey";
static NSString *const OTHER_BOOL_KEY = @"OtherBoolKey";
static NSString *const OTHER_TEXT_KEY = @"OtherTextKey";
static NSString *const BP_KEY = @"BpKey";
static NSString *const BP2_KEY = @"Bp2Key";
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
			 if ([element.key isEqualToString:OTHER_BOOL_KEY]){
				 [self.otherBoolBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OTHER_TEXT_KEY]){
				 [self.otherTextUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:BP_KEY]){
				 [self.bpUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:BP2_KEY]){
				 [self.bp2UITextField setText:((TextElement*)element).value];
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
	 NSAssert([section getElementForKey:OTHER_BOOL_KEY]!= nil, @"OtherBool is nil");
	 NSAssert([section getElementForKey:OTHER_TEXT_KEY]!= nil, @"OtherText is nil");
	 NSAssert([section getElementForKey:BP_KEY]!= nil, @"Bp is nil");
	 NSAssert([section getElementForKey:BP2_KEY]!= nil, @"Bp2 is nil");
	 NSAssert([section getElementForKey:HR_KEY]!= nil, @"Hr is nil");
	 NSAssert([section getElementForKey:RR_KEY]!= nil, @"Rr is nil");
	 NSAssert([section getElementForKey:TEMP_KEY]!= nil, @"Temp is nil");
	 NSAssert([section getElementForKey:SPO2_KEY]!= nil, @"SpO2 is nil");
	 
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
	 
	 BooleanFormElement *otherBool = (BooleanFormElement*)[_section getElementForKey:OTHER_BOOL_KEY];
	 if (!otherBool) {
		 otherBool = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 otherBool.key = OTHER_BOOL_KEY;
		 [_section addElementsObject:otherBool];
	 }

	 otherBool.value = [NSNumber numberWithBool:self.otherBoolBBCheckBox.isSelected];
	 
	 TextElement *otherText = (TextElement*)[_section getElementForKey:OTHER_TEXT_KEY];
	 if (!otherText) {
		 otherText = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 otherText.key = OTHER_TEXT_KEY;
		 [_section addElementsObject:otherText];
	 }

	 otherText.value = self.otherTextUITextField.text;
	 
	 TextElement *bp = (TextElement*)[_section getElementForKey:BP_KEY];
	 if (!bp) {
		 bp = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 bp.key = BP_KEY;
		 [_section addElementsObject:bp];
	 }

	 bp.value = self.bpUITextField.text;
	 
	 TextElement *bp2 = (TextElement*)[_section getElementForKey:BP2_KEY];
	 if (!bp2) {
		 bp2 = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 bp2.key = BP2_KEY;
		 [_section addElementsObject:bp2];
	 }

	 bp2.value = self.bp2UITextField.text;
	 
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
	 [BBUtil refreshManagedObject:_section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return POST_PROCEDURE_GENERAL_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 sender.selected = selected;
}
@end