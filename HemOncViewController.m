
#import "HemOncViewController.h"
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


@interface HemOncViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *hemOncBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hemOncNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *anemiaBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *dVTBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *bloodRefusalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *coagulopathyBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cancerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *chemoBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *radiationBBCheckBox;
@end

@implementation HemOncViewController
NSString *const HEM_ONC_SECTION_TITLE = @"HemOncSectionKey";
static NSString *const HEM_ONC_KEY = @"HemOncKey";
static NSString *const HEM_ONC_NEGATIVE_KEY = @"HemOncNegativeKey";
static NSString *const ANEMIA_KEY = @"AnemiaKey";
static NSString *const DVT_KEY = @"DVTKey";
static NSString *const BLOOD_REFUSAL_KEY = @"BloodRefusalKey";
static NSString *const COAGULOPATHY_KEY = @"CoagulopathyKey";
static NSString *const CANCER_KEY = @"CancerKey";
static NSString *const CHEMO_KEY = @"ChemoKey";
static NSString *const RADIATION_KEY = @"RadiationKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:HEM_ONC_KEY]){
				 [self.hemOncBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HEM_ONC_NEGATIVE_KEY]){
				 [self.hemOncNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ANEMIA_KEY]){
				 [self.anemiaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DVT_KEY]){
				 [self.dVTBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:BLOOD_REFUSAL_KEY]){
				 [self.bloodRefusalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:COAGULOPATHY_KEY]){
				 [self.coagulopathyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CANCER_KEY]){
				 [self.cancerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CHEMO_KEY]){
				 [self.chemoBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RADIATION_KEY]){
				 [self.radiationBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:HEM_ONC_KEY]!= nil, @"HemOnc is nil");
	 NSAssert([section getElementForKey:HEM_ONC_NEGATIVE_KEY]!= nil, @"HemOncNegative is nil");
	 NSAssert([section getElementForKey:ANEMIA_KEY]!= nil, @"Anemia is nil");
	 NSAssert([section getElementForKey:DVT_KEY]!= nil, @"DVT is nil");
	 NSAssert([section getElementForKey:BLOOD_REFUSAL_KEY]!= nil, @"BloodRefusal is nil");
	 NSAssert([section getElementForKey:COAGULOPATHY_KEY]!= nil, @"Coagulopathy is nil");
	 NSAssert([section getElementForKey:CANCER_KEY]!= nil, @"Cancer is nil");
	 NSAssert([section getElementForKey:CHEMO_KEY]!= nil, @"Chemo is nil");
	 NSAssert([section getElementForKey:RADIATION_KEY]!= nil, @"Radiation is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = HEM_ONC_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *hemOnc = (BooleanFormElement*)[_section getElementForKey:HEM_ONC_KEY];
	 if (!hemOnc) {
		 hemOnc = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hemOnc.key = HEM_ONC_KEY;
		 [_section addElementsObject:hemOnc];
	 }

	 hemOnc.value = [NSNumber numberWithBool:self.hemOncBBCheckBox.isSelected];
	 
	 BooleanFormElement *hemOncNegative = (BooleanFormElement*)[_section getElementForKey:HEM_ONC_NEGATIVE_KEY];
	 if (!hemOncNegative) {
		 hemOncNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hemOncNegative.key = HEM_ONC_NEGATIVE_KEY;
		 [_section addElementsObject:hemOncNegative];
	 }

	 hemOncNegative.value = [NSNumber numberWithBool:self.hemOncNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *anemia = (BooleanFormElement*)[_section getElementForKey:ANEMIA_KEY];
	 if (!anemia) {
		 anemia = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 anemia.key = ANEMIA_KEY;
		 [_section addElementsObject:anemia];
	 }

	 anemia.value = [NSNumber numberWithBool:self.anemiaBBCheckBox.isSelected];
	 
	 BooleanFormElement *dVT = (BooleanFormElement*)[_section getElementForKey:DVT_KEY];
	 if (!dVT) {
		 dVT = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 dVT.key = DVT_KEY;
		 [_section addElementsObject:dVT];
	 }

	 dVT.value = [NSNumber numberWithBool:self.dVTBBCheckBox.isSelected];
	 
	 BooleanFormElement *bloodRefusal = (BooleanFormElement*)[_section getElementForKey:BLOOD_REFUSAL_KEY];
	 if (!bloodRefusal) {
		 bloodRefusal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 bloodRefusal.key = BLOOD_REFUSAL_KEY;
		 [_section addElementsObject:bloodRefusal];
	 }

	 bloodRefusal.value = [NSNumber numberWithBool:self.bloodRefusalBBCheckBox.isSelected];
	 
	 BooleanFormElement *coagulopathy = (BooleanFormElement*)[_section getElementForKey:COAGULOPATHY_KEY];
	 if (!coagulopathy) {
		 coagulopathy = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 coagulopathy.key = COAGULOPATHY_KEY;
		 [_section addElementsObject:coagulopathy];
	 }

	 coagulopathy.value = [NSNumber numberWithBool:self.coagulopathyBBCheckBox.isSelected];
	 
	 BooleanFormElement *cancer = (BooleanFormElement*)[_section getElementForKey:CANCER_KEY];
	 if (!cancer) {
		 cancer = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cancer.key = CANCER_KEY;
		 [_section addElementsObject:cancer];
	 }

	 cancer.value = [NSNumber numberWithBool:self.cancerBBCheckBox.isSelected];
	 
	 BooleanFormElement *chemo = (BooleanFormElement*)[_section getElementForKey:CHEMO_KEY];
	 if (!chemo) {
		 chemo = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 chemo.key = CHEMO_KEY;
		 [_section addElementsObject:chemo];
	 }

	 chemo.value = [NSNumber numberWithBool:self.chemoBBCheckBox.isSelected];
	 
	 BooleanFormElement *radiation = (BooleanFormElement*)[_section getElementForKey:RADIATION_KEY];
	 if (!radiation) {
		 radiation = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 radiation.key = RADIATION_KEY;
		 [_section addElementsObject:radiation];
	 }

	 radiation.value = [NSNumber numberWithBool:self.radiationBBCheckBox.isSelected];
	 
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
	 return HEM_ONC_SECTION_TITLE;
}
@end