
#import "PostAnesthesiaEvalViewController.h"
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


@interface PostAnesthesiaEvalViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *bpSystolicUITextField;
@property (weak, nonatomic) IBOutlet UITextField *bpDiastolicUITextField;
@property (weak, nonatomic) IBOutlet UITextField *heartRateUITextField;
@property (weak, nonatomic) IBOutlet UITextField *temperatureUITextField;
@property (weak, nonatomic) IBOutlet UITextField *spO2UITextField;
@property (weak, nonatomic) IBOutlet UITextField *respiratoryRateUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *arousableBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *awakeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *stableBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *mentalStatusOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *mentalStatusOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *cardiacRespAirwayStatusOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *cardiacRespAirwayStatusOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *complicationsNoneBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *complicationsOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *complicationsOtherReasonUITextField;
@end

@implementation PostAnesthesiaEvalViewController
NSString *const POST_ANESTHESIA_EVAL_SECTION_TITLE = @"PostAnesthesiaEvalSectionKey";
static NSString *const BP_SYSTOLIC_KEY = @"BpSystolicKey";
static NSString *const BP_DIASTOLIC_KEY = @"BpDiastolicKey";
static NSString *const HEART_RATE_KEY = @"HeartRateKey";
static NSString *const TEMPERATURE_KEY = @"TemperatureKey";
static NSString *const SPO2_KEY = @"SpO2Key";
static NSString *const RESPIRATORY_RATE_KEY = @"RespiratoryRateKey";
static NSString *const AROUSABLE_KEY = @"ArousableKey";
static NSString *const AWAKE_KEY = @"AwakeKey";
static NSString *const STABLE_KEY = @"StableKey";
static NSString *const MENTAL_STATUS_OTHER_KEY = @"MentalStatusOtherKey";
static NSString *const MENTAL_STATUS_OTHER_REASON_KEY = @"MentalStatusOtherReasonKey";
static NSString *const CARDIAC_RESP_AIRWAY_STATUS_OTHER_KEY = @"CardiacRespAirwayStatusOtherKey";
static NSString *const CARDIAC_RESP_AIRWAY_STATUS_OTHER_REASON_KEY = @"CardiacRespAirwayStatusOtherReasonKey";
static NSString *const COMPLICATIONS_NONE_KEY = @"ComplicationsNoneKey";
static NSString *const COMPLICATIONS_OTHER_KEY = @"ComplicationsOtherKey";
static NSString *const COMPLICATIONS_OTHER_REASON_KEY = @"ComplicationsOtherReasonKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:BP_SYSTOLIC_KEY]){
				 [self.bpSystolicUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:BP_DIASTOLIC_KEY]){
				 [self.bpDiastolicUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:HEART_RATE_KEY]){
				 [self.heartRateUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:TEMPERATURE_KEY]){
				 [self.temperatureUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:SPO2_KEY]){
				 [self.spO2UITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:RESPIRATORY_RATE_KEY]){
				 [self.respiratoryRateUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:AROUSABLE_KEY]){
				 [self.arousableBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:AWAKE_KEY]){
				 [self.awakeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:STABLE_KEY]){
				 [self.stableBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MENTAL_STATUS_OTHER_KEY]){
				 [self.mentalStatusOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MENTAL_STATUS_OTHER_REASON_KEY]){
				 [self.mentalStatusOtherReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:CARDIAC_RESP_AIRWAY_STATUS_OTHER_KEY]){
				 [self.cardiacRespAirwayStatusOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CARDIAC_RESP_AIRWAY_STATUS_OTHER_REASON_KEY]){
				 [self.cardiacRespAirwayStatusOtherReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:COMPLICATIONS_NONE_KEY]){
				 [self.complicationsNoneBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:COMPLICATIONS_OTHER_KEY]){
				 [self.complicationsOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:COMPLICATIONS_OTHER_REASON_KEY]){
				 [self.complicationsOtherReasonUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:BP_SYSTOLIC_KEY]!= nil, @"BpSystolic is nil");
	 NSAssert([section getElementForKey:BP_DIASTOLIC_KEY]!= nil, @"BpDiastolic is nil");
	 NSAssert([section getElementForKey:HEART_RATE_KEY]!= nil, @"HeartRate is nil");
	 NSAssert([section getElementForKey:TEMPERATURE_KEY]!= nil, @"Temperature is nil");
	 NSAssert([section getElementForKey:SPO2_KEY]!= nil, @"SpO2 is nil");
	 NSAssert([section getElementForKey:RESPIRATORY_RATE_KEY]!= nil, @"RespiratoryRate is nil");
	 NSAssert([section getElementForKey:AROUSABLE_KEY]!= nil, @"Arousable is nil");
	 NSAssert([section getElementForKey:AWAKE_KEY]!= nil, @"Awake is nil");
	 NSAssert([section getElementForKey:STABLE_KEY]!= nil, @"Stable is nil");
	 NSAssert([section getElementForKey:MENTAL_STATUS_OTHER_KEY]!= nil, @"MentalStatusOther is nil");
	 NSAssert([section getElementForKey:MENTAL_STATUS_OTHER_REASON_KEY]!= nil, @"MentalStatusOtherReason is nil");
	 NSAssert([section getElementForKey:CARDIAC_RESP_AIRWAY_STATUS_OTHER_KEY]!= nil, @"CardiacRespAirwayStatusOther is nil");
	 NSAssert([section getElementForKey:CARDIAC_RESP_AIRWAY_STATUS_OTHER_REASON_KEY]!= nil, @"CardiacRespAirwayStatusOtherReason is nil");
	 NSAssert([section getElementForKey:COMPLICATIONS_NONE_KEY]!= nil, @"ComplicationsNone is nil");
	 NSAssert([section getElementForKey:COMPLICATIONS_OTHER_KEY]!= nil, @"ComplicationsOther is nil");
	 NSAssert([section getElementForKey:COMPLICATIONS_OTHER_REASON_KEY]!= nil, @"ComplicationsOtherReason is nil");
	 
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
		 self.section.title = POST_ANESTHESIA_EVAL_SECTION_TITLE;
	 }
	 
	 TextElement *bpSystolic = (TextElement*)[_section getElementForKey:BP_SYSTOLIC_KEY];
	 if (!bpSystolic) {
		 bpSystolic = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 bpSystolic.key = BP_SYSTOLIC_KEY;
		 [_section addElementsObject:bpSystolic];
	 }

	 bpSystolic.value = self.bpSystolicUITextField.text;
	 
	 TextElement *bpDiastolic = (TextElement*)[_section getElementForKey:BP_DIASTOLIC_KEY];
	 if (!bpDiastolic) {
		 bpDiastolic = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 bpDiastolic.key = BP_DIASTOLIC_KEY;
		 [_section addElementsObject:bpDiastolic];
	 }

	 bpDiastolic.value = self.bpDiastolicUITextField.text;
	 
	 TextElement *heartRate = (TextElement*)[_section getElementForKey:HEART_RATE_KEY];
	 if (!heartRate) {
		 heartRate = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 heartRate.key = HEART_RATE_KEY;
		 [_section addElementsObject:heartRate];
	 }

	 heartRate.value = self.heartRateUITextField.text;
	 
	 TextElement *temperature = (TextElement*)[_section getElementForKey:TEMPERATURE_KEY];
	 if (!temperature) {
		 temperature = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 temperature.key = TEMPERATURE_KEY;
		 [_section addElementsObject:temperature];
	 }

	 temperature.value = self.temperatureUITextField.text;
	 
	 TextElement *spO2 = (TextElement*)[_section getElementForKey:SPO2_KEY];
	 if (!spO2) {
		 spO2 = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 spO2.key = SPO2_KEY;
		 [_section addElementsObject:spO2];
	 }

	 spO2.value = self.spO2UITextField.text;
	 
	 TextElement *respiratoryRate = (TextElement*)[_section getElementForKey:RESPIRATORY_RATE_KEY];
	 if (!respiratoryRate) {
		 respiratoryRate = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 respiratoryRate.key = RESPIRATORY_RATE_KEY;
		 [_section addElementsObject:respiratoryRate];
	 }

	 respiratoryRate.value = self.respiratoryRateUITextField.text;
	 
	 BooleanFormElement *arousable = (BooleanFormElement*)[_section getElementForKey:AROUSABLE_KEY];
	 if (!arousable) {
		 arousable = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 arousable.key = AROUSABLE_KEY;
		 [_section addElementsObject:arousable];
	 }

	 arousable.value = [NSNumber numberWithBool:self.arousableBBCheckBox.isSelected];
	 
	 BooleanFormElement *awake = (BooleanFormElement*)[_section getElementForKey:AWAKE_KEY];
	 if (!awake) {
		 awake = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 awake.key = AWAKE_KEY;
		 [_section addElementsObject:awake];
	 }

	 awake.value = [NSNumber numberWithBool:self.awakeBBCheckBox.isSelected];
	 
	 BooleanFormElement *stable = (BooleanFormElement*)[_section getElementForKey:STABLE_KEY];
	 if (!stable) {
		 stable = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 stable.key = STABLE_KEY;
		 [_section addElementsObject:stable];
	 }

	 stable.value = [NSNumber numberWithBool:self.stableBBCheckBox.isSelected];
	 
	 BooleanFormElement *mentalStatusOther = (BooleanFormElement*)[_section getElementForKey:MENTAL_STATUS_OTHER_KEY];
	 if (!mentalStatusOther) {
		 mentalStatusOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 mentalStatusOther.key = MENTAL_STATUS_OTHER_KEY;
		 [_section addElementsObject:mentalStatusOther];
	 }

	 mentalStatusOther.value = [NSNumber numberWithBool:self.mentalStatusOtherBBCheckBox.isSelected];
	 
	 TextElement *mentalStatusOtherReason = (TextElement*)[_section getElementForKey:MENTAL_STATUS_OTHER_REASON_KEY];
	 if (!mentalStatusOtherReason) {
		 mentalStatusOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 mentalStatusOtherReason.key = MENTAL_STATUS_OTHER_REASON_KEY;
		 [_section addElementsObject:mentalStatusOtherReason];
	 }

	 mentalStatusOtherReason.value = self.mentalStatusOtherReasonUITextField.text;
	 
	 BooleanFormElement *cardiacRespAirwayStatusOther = (BooleanFormElement*)[_section getElementForKey:CARDIAC_RESP_AIRWAY_STATUS_OTHER_KEY];
	 if (!cardiacRespAirwayStatusOther) {
		 cardiacRespAirwayStatusOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cardiacRespAirwayStatusOther.key = CARDIAC_RESP_AIRWAY_STATUS_OTHER_KEY;
		 [_section addElementsObject:cardiacRespAirwayStatusOther];
	 }

	 cardiacRespAirwayStatusOther.value = [NSNumber numberWithBool:self.cardiacRespAirwayStatusOtherBBCheckBox.isSelected];
	 
	 TextElement *cardiacRespAirwayStatusOtherReason = (TextElement*)[_section getElementForKey:CARDIAC_RESP_AIRWAY_STATUS_OTHER_REASON_KEY];
	 if (!cardiacRespAirwayStatusOtherReason) {
		 cardiacRespAirwayStatusOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 cardiacRespAirwayStatusOtherReason.key = CARDIAC_RESP_AIRWAY_STATUS_OTHER_REASON_KEY;
		 [_section addElementsObject:cardiacRespAirwayStatusOtherReason];
	 }

	 cardiacRespAirwayStatusOtherReason.value = self.cardiacRespAirwayStatusOtherReasonUITextField.text;
	 
	 BooleanFormElement *complicationsNone = (BooleanFormElement*)[_section getElementForKey:COMPLICATIONS_NONE_KEY];
	 if (!complicationsNone) {
		 complicationsNone = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 complicationsNone.key = COMPLICATIONS_NONE_KEY;
		 [_section addElementsObject:complicationsNone];
	 }

	 complicationsNone.value = [NSNumber numberWithBool:self.complicationsNoneBBCheckBox.isSelected];
	 
	 BooleanFormElement *complicationsOther = (BooleanFormElement*)[_section getElementForKey:COMPLICATIONS_OTHER_KEY];
	 if (!complicationsOther) {
		 complicationsOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 complicationsOther.key = COMPLICATIONS_OTHER_KEY;
		 [_section addElementsObject:complicationsOther];
	 }

	 complicationsOther.value = [NSNumber numberWithBool:self.complicationsOtherBBCheckBox.isSelected];
	 
	 TextElement *complicationsOtherReason = (TextElement*)[_section getElementForKey:COMPLICATIONS_OTHER_REASON_KEY];
	 if (!complicationsOtherReason) {
		 complicationsOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 complicationsOtherReason.key = COMPLICATIONS_OTHER_REASON_KEY;
		 [_section addElementsObject:complicationsOtherReason];
	 }

	 complicationsOtherReason.value = self.complicationsOtherReasonUITextField.text;
	 
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
	 return POST_ANESTHESIA_EVAL_SECTION_TITLE;
}
@end