
#import "NeuroligcViewController.h"
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


@interface NeuroligcViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *neurologicBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *neurologicNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *dementiaBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *neuropathyBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *backPainBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *neckPainBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cVABBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *tIABBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *alteredMentalStatusBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *seizuresBBCheckBox;
@end

@implementation NeuroligcViewController
NSString *const NEUROLIGC_SECTION_TITLE = @"NeuroligcSectionKey";
static NSString *const NEUROLOGIC_KEY = @"NeurologicKey";
static NSString *const NEUROLOGIC_NEGATIVE_KEY = @"NeurologicNegativeKey";
static NSString *const DEMENTIA_KEY = @"DementiaKey";
static NSString *const NEUROPATHY_KEY = @"NeuropathyKey";
static NSString *const BACK_PAIN_KEY = @"BackPainKey";
static NSString *const NECK_PAIN_KEY = @"NeckPainKey";
static NSString *const CVA_KEY = @"CVAKey";
static NSString *const TIA_KEY = @"TIAKey";
static NSString *const ALTERED_MENTAL_STATUS_KEY = @"AlteredMentalStatusKey";
static NSString *const SEIZURES_KEY = @"SeizuresKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:NEUROLOGIC_KEY]){
				 [self.neurologicBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NEUROLOGIC_NEGATIVE_KEY]){
				 [self.neurologicNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DEMENTIA_KEY]){
				 [self.dementiaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NEUROPATHY_KEY]){
				 [self.neuropathyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:BACK_PAIN_KEY]){
				 [self.backPainBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NECK_PAIN_KEY]){
				 [self.neckPainBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CVA_KEY]){
				 [self.cVABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:TIA_KEY]){
				 [self.tIABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ALTERED_MENTAL_STATUS_KEY]){
				 [self.alteredMentalStatusBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SEIZURES_KEY]){
				 [self.seizuresBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:NEUROLOGIC_KEY]!= nil, @"Neurologic is nil");
	 NSAssert([section getElementForKey:NEUROLOGIC_NEGATIVE_KEY]!= nil, @"NeurologicNegative is nil");
	 NSAssert([section getElementForKey:DEMENTIA_KEY]!= nil, @"Dementia is nil");
	 NSAssert([section getElementForKey:NEUROPATHY_KEY]!= nil, @"Neuropathy is nil");
	 NSAssert([section getElementForKey:BACK_PAIN_KEY]!= nil, @"BackPain is nil");
	 NSAssert([section getElementForKey:NECK_PAIN_KEY]!= nil, @"NeckPain is nil");
	 NSAssert([section getElementForKey:CVA_KEY]!= nil, @"CVA is nil");
	 NSAssert([section getElementForKey:TIA_KEY]!= nil, @"TIA is nil");
	 NSAssert([section getElementForKey:ALTERED_MENTAL_STATUS_KEY]!= nil, @"AlteredMentalStatus is nil");
	 NSAssert([section getElementForKey:SEIZURES_KEY]!= nil, @"Seizures is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = NEUROLIGC_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *neurologic = (BooleanFormElement*)[_section getElementForKey:NEUROLOGIC_KEY];
	 if (!neurologic) {
		 neurologic = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 neurologic.key = NEUROLOGIC_KEY;
		 [_section addElementsObject:neurologic];
	 }

	 neurologic.value = [NSNumber numberWithBool:self.neurologicBBCheckBox.isSelected];
	 
	 BooleanFormElement *neurologicNegative = (BooleanFormElement*)[_section getElementForKey:NEUROLOGIC_NEGATIVE_KEY];
	 if (!neurologicNegative) {
		 neurologicNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 neurologicNegative.key = NEUROLOGIC_NEGATIVE_KEY;
		 [_section addElementsObject:neurologicNegative];
	 }

	 neurologicNegative.value = [NSNumber numberWithBool:self.neurologicNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *dementia = (BooleanFormElement*)[_section getElementForKey:DEMENTIA_KEY];
	 if (!dementia) {
		 dementia = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 dementia.key = DEMENTIA_KEY;
		 [_section addElementsObject:dementia];
	 }

	 dementia.value = [NSNumber numberWithBool:self.dementiaBBCheckBox.isSelected];
	 
	 BooleanFormElement *neuropathy = (BooleanFormElement*)[_section getElementForKey:NEUROPATHY_KEY];
	 if (!neuropathy) {
		 neuropathy = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 neuropathy.key = NEUROPATHY_KEY;
		 [_section addElementsObject:neuropathy];
	 }

	 neuropathy.value = [NSNumber numberWithBool:self.neuropathyBBCheckBox.isSelected];
	 
	 BooleanFormElement *backPain = (BooleanFormElement*)[_section getElementForKey:BACK_PAIN_KEY];
	 if (!backPain) {
		 backPain = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 backPain.key = BACK_PAIN_KEY;
		 [_section addElementsObject:backPain];
	 }

	 backPain.value = [NSNumber numberWithBool:self.backPainBBCheckBox.isSelected];
	 
	 BooleanFormElement *neckPain = (BooleanFormElement*)[_section getElementForKey:NECK_PAIN_KEY];
	 if (!neckPain) {
		 neckPain = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 neckPain.key = NECK_PAIN_KEY;
		 [_section addElementsObject:neckPain];
	 }

	 neckPain.value = [NSNumber numberWithBool:self.neckPainBBCheckBox.isSelected];
	 
	 BooleanFormElement *cVA = (BooleanFormElement*)[_section getElementForKey:CVA_KEY];
	 if (!cVA) {
		 cVA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cVA.key = CVA_KEY;
		 [_section addElementsObject:cVA];
	 }

	 cVA.value = [NSNumber numberWithBool:self.cVABBCheckBox.isSelected];
	 
	 BooleanFormElement *tIA = (BooleanFormElement*)[_section getElementForKey:TIA_KEY];
	 if (!tIA) {
		 tIA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 tIA.key = TIA_KEY;
		 [_section addElementsObject:tIA];
	 }

	 tIA.value = [NSNumber numberWithBool:self.tIABBCheckBox.isSelected];
	 
	 BooleanFormElement *alteredMentalStatus = (BooleanFormElement*)[_section getElementForKey:ALTERED_MENTAL_STATUS_KEY];
	 if (!alteredMentalStatus) {
		 alteredMentalStatus = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 alteredMentalStatus.key = ALTERED_MENTAL_STATUS_KEY;
		 [_section addElementsObject:alteredMentalStatus];
	 }

	 alteredMentalStatus.value = [NSNumber numberWithBool:self.alteredMentalStatusBBCheckBox.isSelected];
	 
	 BooleanFormElement *seizures = (BooleanFormElement*)[_section getElementForKey:SEIZURES_KEY];
	 if (!seizures) {
		 seizures = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 seizures.key = SEIZURES_KEY;
		 [_section addElementsObject:seizures];
	 }

	 seizures.value = [NSNumber numberWithBool:self.seizuresBBCheckBox.isSelected];
	 
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
	 return NEUROLIGC_SECTION_TITLE;
}
@end