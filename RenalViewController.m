
#import "RenalViewController.h"
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


@interface RenalViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *renalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *renalNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cRIBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *renalFailureBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *lastDialysisUITextField;
@end

@implementation RenalViewController
NSString *const RENAL_SECTION_TITLE = @"RenalSectionKey";
static NSString *const RENAL_KEY = @"RenalKey";
static NSString *const RENAL_NEGATIVE_KEY = @"RenalNegativeKey";
static NSString *const CRI_KEY = @"CRIKey";
static NSString *const RENAL_FAILURE_KEY = @"RenalFailureKey";
static NSString *const LAST_DIALYSIS_KEY = @"LastDialysisKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:RENAL_KEY]){
				 [self.renalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RENAL_NEGATIVE_KEY]){
				 [self.renalNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CRI_KEY]){
				 [self.cRIBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RENAL_FAILURE_KEY]){
				 [self.renalFailureBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LAST_DIALYSIS_KEY]){
				 [self.lastDialysisUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:RENAL_KEY]!= nil, @"Renal is nil");
	 NSAssert([section getElementForKey:RENAL_NEGATIVE_KEY]!= nil, @"RenalNegative is nil");
	 NSAssert([section getElementForKey:CRI_KEY]!= nil, @"CRI is nil");
	 NSAssert([section getElementForKey:RENAL_FAILURE_KEY]!= nil, @"RenalFailure is nil");
	 NSAssert([section getElementForKey:LAST_DIALYSIS_KEY]!= nil, @"LastDialysis is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = RENAL_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *renal = (BooleanFormElement*)[_section getElementForKey:RENAL_KEY];
	 if (!renal) {
		 renal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 renal.key = RENAL_KEY;
		 [_section addElementsObject:renal];
	 }

	 renal.value = [NSNumber numberWithBool:self.renalBBCheckBox.isSelected];
	 
	 BooleanFormElement *renalNegative = (BooleanFormElement*)[_section getElementForKey:RENAL_NEGATIVE_KEY];
	 if (!renalNegative) {
		 renalNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 renalNegative.key = RENAL_NEGATIVE_KEY;
		 [_section addElementsObject:renalNegative];
	 }

	 renalNegative.value = [NSNumber numberWithBool:self.renalNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *cRI = (BooleanFormElement*)[_section getElementForKey:CRI_KEY];
	 if (!cRI) {
		 cRI = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cRI.key = CRI_KEY;
		 [_section addElementsObject:cRI];
	 }

	 cRI.value = [NSNumber numberWithBool:self.cRIBBCheckBox.isSelected];
	 
	 BooleanFormElement *renalFailure = (BooleanFormElement*)[_section getElementForKey:RENAL_FAILURE_KEY];
	 if (!renalFailure) {
		 renalFailure = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 renalFailure.key = RENAL_FAILURE_KEY;
		 [_section addElementsObject:renalFailure];
	 }

	 renalFailure.value = [NSNumber numberWithBool:self.renalFailureBBCheckBox.isSelected];
	 
	 TextElement *lastDialysis = (TextElement*)[_section getElementForKey:LAST_DIALYSIS_KEY];
	 if (!lastDialysis) {
		 lastDialysis = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 lastDialysis.key = LAST_DIALYSIS_KEY;
		 [_section addElementsObject:lastDialysis];
	 }

	 lastDialysis.value = self.lastDialysisUITextField.text;
	 
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
	 return RENAL_SECTION_TITLE;
}
@end