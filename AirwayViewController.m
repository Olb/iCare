
#import "AirwayViewController.h"
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


@interface AirwayViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *airwayAdequateBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *intubatedBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *difficultReasonUITextField;
@property (weak, nonatomic) IBOutlet UITextField *mallampatiUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *difficultBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *dentitionOkBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *riskOfDamagePtAwareBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *capsCrownsBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *capsUpperBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *capsLowerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *denturesBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *denturesFullBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *denturesPartialBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *denturesFullUpperBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *denturesFullLowerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *denturesPartialUpperBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *denturesPartialLowerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *chippedBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *chippedNumberUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *chippedUpperBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *chippedLowerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *missingBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *missingNumberUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *missingUpperBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *missingLowerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *looseBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *looseNumberUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *looseUpperBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *looseLowerBBCheckBox;
@end

@implementation AirwayViewController
NSString *const AIRWAY_SECTION_TITLE = @"AirwaySectionKey";
static NSString *const AIRWAY_ADEQUATE_KEY = @"AirwayAdequateKey";
static NSString *const INTUBATED_KEY = @"IntubatedKey";
static NSString *const DIFFICULT_REASON_KEY = @"DifficultReasonKey";
static NSString *const MALLAMPATI_KEY = @"MallampatiKey";
static NSString *const DIFFICULT_KEY = @"DifficultKey";
static NSString *const DENTITION_OK_KEY = @"DentitionOkKey";
static NSString *const RISK_OF_DAMAGE_PT_AWARE_KEY = @"RiskOfDamagePtAwareKey";
static NSString *const CAPS_CROWNS_KEY = @"CapsCrownsKey";
static NSString *const CAPS_UPPER_KEY = @"CapsUpperKey";
static NSString *const CAPS_LOWER_KEY = @"CapsLowerKey";
static NSString *const DENTURES_KEY = @"DenturesKey";
static NSString *const DENTURES_FULL_KEY = @"DenturesFullKey";
static NSString *const DENTURES_PARTIAL_KEY = @"DenturesPartialKey";
static NSString *const DENTURES_FULL_UPPER_KEY = @"DenturesFullUpperKey";
static NSString *const DENTURES_FULL_LOWER_KEY = @"DenturesFullLowerKey";
static NSString *const DENTURES_PARTIAL_UPPER_KEY = @"DenturesPartialUpperKey";
static NSString *const DENTURES_PARTIAL_LOWER_KEY = @"DenturesPartialLowerKey";
static NSString *const CHIPPED_KEY = @"ChippedKey";
static NSString *const CHIPPED_NUMBER_KEY = @"ChippedNumberKey";
static NSString *const CHIPPED_UPPER_KEY = @"ChippedUpperKey";
static NSString *const CHIPPED_LOWER_KEY = @"ChippedLowerKey";
static NSString *const MISSING_KEY = @"MissingKey";
static NSString *const MISSING_NUMBER_KEY = @"MissingNumberKey";
static NSString *const MISSING_UPPER_KEY = @"MissingUpperKey";
static NSString *const MISSING_LOWER_KEY = @"MissingLowerKey";
static NSString *const LOOSE_KEY = @"LooseKey";
static NSString *const LOOSE_NUMBER_KEY = @"LooseNumberKey";
static NSString *const LOOSE_UPPER_KEY = @"LooseUpperKey";
static NSString *const LOOSE_LOWER_KEY = @"LooseLowerKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:AIRWAY_ADEQUATE_KEY]){
				 [self.airwayAdequateBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INTUBATED_KEY]){
				 [self.intubatedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DIFFICULT_REASON_KEY]){
				 [self.difficultReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:MALLAMPATI_KEY]){
				 [self.mallampatiUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:DIFFICULT_KEY]){
				 [self.difficultBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTITION_OK_KEY]){
				 [self.dentitionOkBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RISK_OF_DAMAGE_PT_AWARE_KEY]){
				 [self.riskOfDamagePtAwareBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CAPS_CROWNS_KEY]){
				 [self.capsCrownsBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CAPS_UPPER_KEY]){
				 [self.capsUpperBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CAPS_LOWER_KEY]){
				 [self.capsLowerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTURES_KEY]){
				 [self.denturesBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTURES_FULL_KEY]){
				 [self.denturesFullBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTURES_PARTIAL_KEY]){
				 [self.denturesPartialBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTURES_FULL_UPPER_KEY]){
				 [self.denturesFullUpperBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTURES_FULL_LOWER_KEY]){
				 [self.denturesFullLowerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTURES_PARTIAL_UPPER_KEY]){
				 [self.denturesPartialUpperBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DENTURES_PARTIAL_LOWER_KEY]){
				 [self.denturesPartialLowerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CHIPPED_KEY]){
				 [self.chippedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CHIPPED_NUMBER_KEY]){
				 [self.chippedNumberUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:CHIPPED_UPPER_KEY]){
				 [self.chippedUpperBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CHIPPED_LOWER_KEY]){
				 [self.chippedLowerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MISSING_KEY]){
				 [self.missingBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MISSING_NUMBER_KEY]){
				 [self.missingNumberUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:MISSING_UPPER_KEY]){
				 [self.missingUpperBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MISSING_LOWER_KEY]){
				 [self.missingLowerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LOOSE_KEY]){
				 [self.looseBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LOOSE_NUMBER_KEY]){
				 [self.looseNumberUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:LOOSE_UPPER_KEY]){
				 [self.looseUpperBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LOOSE_LOWER_KEY]){
				 [self.looseLowerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:AIRWAY_ADEQUATE_KEY]!= nil, @"AirwayAdequate is nil");
	 NSAssert([section getElementForKey:INTUBATED_KEY]!= nil, @"Intubated is nil");
	 NSAssert([section getElementForKey:DIFFICULT_REASON_KEY]!= nil, @"DifficultReason is nil");
	 NSAssert([section getElementForKey:MALLAMPATI_KEY]!= nil, @"Mallampati is nil");
	 NSAssert([section getElementForKey:DIFFICULT_KEY]!= nil, @"Difficult is nil");
	 NSAssert([section getElementForKey:DENTITION_OK_KEY]!= nil, @"DentitionOk is nil");
	 NSAssert([section getElementForKey:RISK_OF_DAMAGE_PT_AWARE_KEY]!= nil, @"RiskOfDamagePtAware is nil");
	 NSAssert([section getElementForKey:CAPS_CROWNS_KEY]!= nil, @"CapsCrowns is nil");
	 NSAssert([section getElementForKey:CAPS_UPPER_KEY]!= nil, @"CapsUpper is nil");
	 NSAssert([section getElementForKey:CAPS_LOWER_KEY]!= nil, @"CapsLower is nil");
	 NSAssert([section getElementForKey:DENTURES_KEY]!= nil, @"Dentures is nil");
	 NSAssert([section getElementForKey:DENTURES_FULL_KEY]!= nil, @"DenturesFull is nil");
	 NSAssert([section getElementForKey:DENTURES_PARTIAL_KEY]!= nil, @"DenturesPartial is nil");
	 NSAssert([section getElementForKey:DENTURES_FULL_UPPER_KEY]!= nil, @"DenturesFullUpper is nil");
	 NSAssert([section getElementForKey:DENTURES_FULL_LOWER_KEY]!= nil, @"DenturesFullLower is nil");
	 NSAssert([section getElementForKey:DENTURES_PARTIAL_UPPER_KEY]!= nil, @"DenturesPartialUpper is nil");
	 NSAssert([section getElementForKey:DENTURES_PARTIAL_LOWER_KEY]!= nil, @"DenturesPartialLower is nil");
	 NSAssert([section getElementForKey:CHIPPED_KEY]!= nil, @"Chipped is nil");
	 NSAssert([section getElementForKey:CHIPPED_NUMBER_KEY]!= nil, @"ChippedNumber is nil");
	 NSAssert([section getElementForKey:CHIPPED_UPPER_KEY]!= nil, @"ChippedUpper is nil");
	 NSAssert([section getElementForKey:CHIPPED_LOWER_KEY]!= nil, @"ChippedLower is nil");
	 NSAssert([section getElementForKey:MISSING_KEY]!= nil, @"Missing is nil");
	 NSAssert([section getElementForKey:MISSING_NUMBER_KEY]!= nil, @"MissingNumber is nil");
	 NSAssert([section getElementForKey:MISSING_UPPER_KEY]!= nil, @"MissingUpper is nil");
	 NSAssert([section getElementForKey:MISSING_LOWER_KEY]!= nil, @"MissingLower is nil");
	 NSAssert([section getElementForKey:LOOSE_KEY]!= nil, @"Loose is nil");
	 NSAssert([section getElementForKey:LOOSE_NUMBER_KEY]!= nil, @"LooseNumber is nil");
	 NSAssert([section getElementForKey:LOOSE_UPPER_KEY]!= nil, @"LooseUpper is nil");
	 NSAssert([section getElementForKey:LOOSE_LOWER_KEY]!= nil, @"LooseLower is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = AIRWAY_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *airwayAdequate = (BooleanFormElement*)[_section getElementForKey:AIRWAY_ADEQUATE_KEY];
	 if (!airwayAdequate) {
		 airwayAdequate = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 airwayAdequate.key = AIRWAY_ADEQUATE_KEY;
		 [_section addElementsObject:airwayAdequate];
	 }

	 airwayAdequate.value = [NSNumber numberWithBool:self.airwayAdequateBBCheckBox.isSelected];
	 
	 BooleanFormElement *intubated = (BooleanFormElement*)[_section getElementForKey:INTUBATED_KEY];
	 if (!intubated) {
		 intubated = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 intubated.key = INTUBATED_KEY;
		 [_section addElementsObject:intubated];
	 }

	 intubated.value = [NSNumber numberWithBool:self.intubatedBBCheckBox.isSelected];
	 
	 TextElement *difficultReason = (TextElement*)[_section getElementForKey:DIFFICULT_REASON_KEY];
	 if (!difficultReason) {
		 difficultReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 difficultReason.key = DIFFICULT_REASON_KEY;
		 [_section addElementsObject:difficultReason];
	 }

	 difficultReason.value = self.difficultReasonUITextField.text;
	 
	 TextElement *mallampati = (TextElement*)[_section getElementForKey:MALLAMPATI_KEY];
	 if (!mallampati) {
		 mallampati = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 mallampati.key = MALLAMPATI_KEY;
		 [_section addElementsObject:mallampati];
	 }

	 mallampati.value = self.mallampatiUITextField.text;
	 
	 BooleanFormElement *difficult = (BooleanFormElement*)[_section getElementForKey:DIFFICULT_KEY];
	 if (!difficult) {
		 difficult = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 difficult.key = DIFFICULT_KEY;
		 [_section addElementsObject:difficult];
	 }

	 difficult.value = [NSNumber numberWithBool:self.difficultBBCheckBox.isSelected];
	 
	 BooleanFormElement *dentitionOk = (BooleanFormElement*)[_section getElementForKey:DENTITION_OK_KEY];
	 if (!dentitionOk) {
		 dentitionOk = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 dentitionOk.key = DENTITION_OK_KEY;
		 [_section addElementsObject:dentitionOk];
	 }

	 dentitionOk.value = [NSNumber numberWithBool:self.dentitionOkBBCheckBox.isSelected];
	 
	 BooleanFormElement *riskOfDamagePtAware = (BooleanFormElement*)[_section getElementForKey:RISK_OF_DAMAGE_PT_AWARE_KEY];
	 if (!riskOfDamagePtAware) {
		 riskOfDamagePtAware = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 riskOfDamagePtAware.key = RISK_OF_DAMAGE_PT_AWARE_KEY;
		 [_section addElementsObject:riskOfDamagePtAware];
	 }

	 riskOfDamagePtAware.value = [NSNumber numberWithBool:self.riskOfDamagePtAwareBBCheckBox.isSelected];
	 
	 BooleanFormElement *capsCrowns = (BooleanFormElement*)[_section getElementForKey:CAPS_CROWNS_KEY];
	 if (!capsCrowns) {
		 capsCrowns = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 capsCrowns.key = CAPS_CROWNS_KEY;
		 [_section addElementsObject:capsCrowns];
	 }

	 capsCrowns.value = [NSNumber numberWithBool:self.capsCrownsBBCheckBox.isSelected];
	 
	 BooleanFormElement *capsUpper = (BooleanFormElement*)[_section getElementForKey:CAPS_UPPER_KEY];
	 if (!capsUpper) {
		 capsUpper = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 capsUpper.key = CAPS_UPPER_KEY;
		 [_section addElementsObject:capsUpper];
	 }

	 capsUpper.value = [NSNumber numberWithBool:self.capsUpperBBCheckBox.isSelected];
	 
	 BooleanFormElement *capsLower = (BooleanFormElement*)[_section getElementForKey:CAPS_LOWER_KEY];
	 if (!capsLower) {
		 capsLower = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 capsLower.key = CAPS_LOWER_KEY;
		 [_section addElementsObject:capsLower];
	 }

	 capsLower.value = [NSNumber numberWithBool:self.capsLowerBBCheckBox.isSelected];
	 
	 BooleanFormElement *dentures = (BooleanFormElement*)[_section getElementForKey:DENTURES_KEY];
	 if (!dentures) {
		 dentures = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 dentures.key = DENTURES_KEY;
		 [_section addElementsObject:dentures];
	 }

	 dentures.value = [NSNumber numberWithBool:self.denturesBBCheckBox.isSelected];
	 
	 BooleanFormElement *denturesFull = (BooleanFormElement*)[_section getElementForKey:DENTURES_FULL_KEY];
	 if (!denturesFull) {
		 denturesFull = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 denturesFull.key = DENTURES_FULL_KEY;
		 [_section addElementsObject:denturesFull];
	 }

	 denturesFull.value = [NSNumber numberWithBool:self.denturesFullBBCheckBox.isSelected];
	 
	 BooleanFormElement *denturesPartial = (BooleanFormElement*)[_section getElementForKey:DENTURES_PARTIAL_KEY];
	 if (!denturesPartial) {
		 denturesPartial = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 denturesPartial.key = DENTURES_PARTIAL_KEY;
		 [_section addElementsObject:denturesPartial];
	 }

	 denturesPartial.value = [NSNumber numberWithBool:self.denturesPartialBBCheckBox.isSelected];
	 
	 BooleanFormElement *denturesFullUpper = (BooleanFormElement*)[_section getElementForKey:DENTURES_FULL_UPPER_KEY];
	 if (!denturesFullUpper) {
		 denturesFullUpper = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 denturesFullUpper.key = DENTURES_FULL_UPPER_KEY;
		 [_section addElementsObject:denturesFullUpper];
	 }

	 denturesFullUpper.value = [NSNumber numberWithBool:self.denturesFullUpperBBCheckBox.isSelected];
	 
	 BooleanFormElement *denturesFullLower = (BooleanFormElement*)[_section getElementForKey:DENTURES_FULL_LOWER_KEY];
	 if (!denturesFullLower) {
		 denturesFullLower = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 denturesFullLower.key = DENTURES_FULL_LOWER_KEY;
		 [_section addElementsObject:denturesFullLower];
	 }

	 denturesFullLower.value = [NSNumber numberWithBool:self.denturesFullLowerBBCheckBox.isSelected];
	 
	 BooleanFormElement *denturesPartialUpper = (BooleanFormElement*)[_section getElementForKey:DENTURES_PARTIAL_UPPER_KEY];
	 if (!denturesPartialUpper) {
		 denturesPartialUpper = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 denturesPartialUpper.key = DENTURES_PARTIAL_UPPER_KEY;
		 [_section addElementsObject:denturesPartialUpper];
	 }

	 denturesPartialUpper.value = [NSNumber numberWithBool:self.denturesPartialUpperBBCheckBox.isSelected];
	 
	 BooleanFormElement *denturesPartialLower = (BooleanFormElement*)[_section getElementForKey:DENTURES_PARTIAL_LOWER_KEY];
	 if (!denturesPartialLower) {
		 denturesPartialLower = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 denturesPartialLower.key = DENTURES_PARTIAL_LOWER_KEY;
		 [_section addElementsObject:denturesPartialLower];
	 }

	 denturesPartialLower.value = [NSNumber numberWithBool:self.denturesPartialLowerBBCheckBox.isSelected];
	 
	 BooleanFormElement *chipped = (BooleanFormElement*)[_section getElementForKey:CHIPPED_KEY];
	 if (!chipped) {
		 chipped = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 chipped.key = CHIPPED_KEY;
		 [_section addElementsObject:chipped];
	 }

	 chipped.value = [NSNumber numberWithBool:self.chippedBBCheckBox.isSelected];
	 
	 TextElement *chippedNumber = (TextElement*)[_section getElementForKey:CHIPPED_NUMBER_KEY];
	 if (!chippedNumber) {
		 chippedNumber = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 chippedNumber.key = CHIPPED_NUMBER_KEY;
		 [_section addElementsObject:chippedNumber];
	 }

	 chippedNumber.value = self.chippedNumberUITextField.text;
	 
	 BooleanFormElement *chippedUpper = (BooleanFormElement*)[_section getElementForKey:CHIPPED_UPPER_KEY];
	 if (!chippedUpper) {
		 chippedUpper = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 chippedUpper.key = CHIPPED_UPPER_KEY;
		 [_section addElementsObject:chippedUpper];
	 }

	 chippedUpper.value = [NSNumber numberWithBool:self.chippedUpperBBCheckBox.isSelected];
	 
	 BooleanFormElement *chippedLower = (BooleanFormElement*)[_section getElementForKey:CHIPPED_LOWER_KEY];
	 if (!chippedLower) {
		 chippedLower = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 chippedLower.key = CHIPPED_LOWER_KEY;
		 [_section addElementsObject:chippedLower];
	 }

	 chippedLower.value = [NSNumber numberWithBool:self.chippedLowerBBCheckBox.isSelected];
	 
	 BooleanFormElement *missing = (BooleanFormElement*)[_section getElementForKey:MISSING_KEY];
	 if (!missing) {
		 missing = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 missing.key = MISSING_KEY;
		 [_section addElementsObject:missing];
	 }

	 missing.value = [NSNumber numberWithBool:self.missingBBCheckBox.isSelected];
	 
	 TextElement *missingNumber = (TextElement*)[_section getElementForKey:MISSING_NUMBER_KEY];
	 if (!missingNumber) {
		 missingNumber = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 missingNumber.key = MISSING_NUMBER_KEY;
		 [_section addElementsObject:missingNumber];
	 }

	 missingNumber.value = self.missingNumberUITextField.text;
	 
	 BooleanFormElement *missingUpper = (BooleanFormElement*)[_section getElementForKey:MISSING_UPPER_KEY];
	 if (!missingUpper) {
		 missingUpper = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 missingUpper.key = MISSING_UPPER_KEY;
		 [_section addElementsObject:missingUpper];
	 }

	 missingUpper.value = [NSNumber numberWithBool:self.missingUpperBBCheckBox.isSelected];
	 
	 BooleanFormElement *missingLower = (BooleanFormElement*)[_section getElementForKey:MISSING_LOWER_KEY];
	 if (!missingLower) {
		 missingLower = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 missingLower.key = MISSING_LOWER_KEY;
		 [_section addElementsObject:missingLower];
	 }

	 missingLower.value = [NSNumber numberWithBool:self.missingLowerBBCheckBox.isSelected];
	 
	 BooleanFormElement *loose = (BooleanFormElement*)[_section getElementForKey:LOOSE_KEY];
	 if (!loose) {
		 loose = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 loose.key = LOOSE_KEY;
		 [_section addElementsObject:loose];
	 }

	 loose.value = [NSNumber numberWithBool:self.looseBBCheckBox.isSelected];
	 
	 TextElement *looseNumber = (TextElement*)[_section getElementForKey:LOOSE_NUMBER_KEY];
	 if (!looseNumber) {
		 looseNumber = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 looseNumber.key = LOOSE_NUMBER_KEY;
		 [_section addElementsObject:looseNumber];
	 }

	 looseNumber.value = self.looseNumberUITextField.text;
	 
	 BooleanFormElement *looseUpper = (BooleanFormElement*)[_section getElementForKey:LOOSE_UPPER_KEY];
	 if (!looseUpper) {
		 looseUpper = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 looseUpper.key = LOOSE_UPPER_KEY;
		 [_section addElementsObject:looseUpper];
	 }

	 looseUpper.value = [NSNumber numberWithBool:self.looseUpperBBCheckBox.isSelected];
	 
	 BooleanFormElement *looseLower = (BooleanFormElement*)[_section getElementForKey:LOOSE_LOWER_KEY];
	 if (!looseLower) {
		 looseLower = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 looseLower.key = LOOSE_LOWER_KEY;
		 [_section addElementsObject:looseLower];
	 }

	 looseLower.value = [NSNumber numberWithBool:self.looseLowerBBCheckBox.isSelected];
	 
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
	 return AIRWAY_SECTION_TITLE;
}
@end