
#import "MonitorinAndEquipmentViewController.h"
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


@interface MonitorinAndEquipmentViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *equipmentCheckedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *audibleAlarmsOnBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *precordialStethBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nerveStimulatorBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *esophagealStethBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cellSaverBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *tEEBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *fluidWarmerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *intentionalHypothermiaBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *intraOpForcedAirUpperBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *intraOpForcedAirLowerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nibpRightBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nibpLeftBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nibpArmBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nibpLegBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *nibpEveryMinUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *monitoringEquipmentOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *monitoringEquipmentOtherReasonUITextField;
@end

@implementation MonitorinAndEquipmentViewController
NSString *const MONITORIN_AND_EQUIPMENT_SECTION_TITLE = @"MonitorinAndEquipmentSectionKey";
static NSString *const EQUIPMENT_CHECKED_KEY = @"EquipmentCheckedKey";
static NSString *const AUDIBLE_ALARMS_ON_KEY = @"AudibleAlarmsOnKey";
static NSString *const PRECORDIAL_STETH_KEY = @"PrecordialStethKey";
static NSString *const NERVE_STIMULATOR_KEY = @"NerveStimulatorKey";
static NSString *const ESOPHAGEAL_STETH_KEY = @"EsophagealStethKey";
static NSString *const CELL_SAVER_KEY = @"CellSaverKey";
static NSString *const TEE_KEY = @"TEEKey";
static NSString *const FLUID_WARMER_KEY = @"FluidWarmerKey";
static NSString *const INTENTIONAL_HYPOTHERMIA_KEY = @"IntentionalHypothermiaKey";
static NSString *const INTRA_OP_FORCED_AIR_UPPER_KEY = @"IntraOpForcedAirUpperKey";
static NSString *const INTRA_OP_FORCED_AIR_LOWER_KEY = @"IntraOpForcedAirLowerKey";
static NSString *const NIBP_RIGHT_KEY = @"NibpRightKey";
static NSString *const NIBP_LEFT_KEY = @"NibpLeftKey";
static NSString *const NIBP_ARM_KEY = @"NibpArmKey";
static NSString *const NIBP_LEG_KEY = @"NibpLegKey";
static NSString *const NIBP_EVERY_MIN_KEY = @"NibpEveryMinKey";
static NSString *const MONITORING_EQUIPMENT_OTHER_KEY = @"MonitoringEquipmentOtherKey";
static NSString *const MONITORING_EQUIPMENT_OTHER_REASON_KEY = @"MonitoringEquipmentOtherReasonKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:EQUIPMENT_CHECKED_KEY]){
				 [self.equipmentCheckedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:AUDIBLE_ALARMS_ON_KEY]){
				 [self.audibleAlarmsOnBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PRECORDIAL_STETH_KEY]){
				 [self.precordialStethBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NERVE_STIMULATOR_KEY]){
				 [self.nerveStimulatorBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ESOPHAGEAL_STETH_KEY]){
				 [self.esophagealStethBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CELL_SAVER_KEY]){
				 [self.cellSaverBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:TEE_KEY]){
				 [self.tEEBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:FLUID_WARMER_KEY]){
				 [self.fluidWarmerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INTENTIONAL_HYPOTHERMIA_KEY]){
				 [self.intentionalHypothermiaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INTRA_OP_FORCED_AIR_UPPER_KEY]){
				 [self.intraOpForcedAirUpperBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INTRA_OP_FORCED_AIR_LOWER_KEY]){
				 [self.intraOpForcedAirLowerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NIBP_RIGHT_KEY]){
				 [self.nibpRightBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NIBP_LEFT_KEY]){
				 [self.nibpLeftBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NIBP_ARM_KEY]){
				 [self.nibpArmBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NIBP_LEG_KEY]){
				 [self.nibpLegBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NIBP_EVERY_MIN_KEY]){
				 [self.nibpEveryMinUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:MONITORING_EQUIPMENT_OTHER_KEY]){
				 [self.monitoringEquipmentOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MONITORING_EQUIPMENT_OTHER_REASON_KEY]){
				 [self.monitoringEquipmentOtherReasonUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:EQUIPMENT_CHECKED_KEY]!= nil, @"EquipmentChecked is nil");
	 NSAssert([section getElementForKey:AUDIBLE_ALARMS_ON_KEY]!= nil, @"AudibleAlarmsOn is nil");
	 NSAssert([section getElementForKey:PRECORDIAL_STETH_KEY]!= nil, @"PrecordialSteth is nil");
	 NSAssert([section getElementForKey:NERVE_STIMULATOR_KEY]!= nil, @"NerveStimulator is nil");
	 NSAssert([section getElementForKey:ESOPHAGEAL_STETH_KEY]!= nil, @"EsophagealSteth is nil");
	 NSAssert([section getElementForKey:CELL_SAVER_KEY]!= nil, @"CellSaver is nil");
	 NSAssert([section getElementForKey:TEE_KEY]!= nil, @"TEE is nil");
	 NSAssert([section getElementForKey:FLUID_WARMER_KEY]!= nil, @"FluidWarmer is nil");
	 NSAssert([section getElementForKey:INTENTIONAL_HYPOTHERMIA_KEY]!= nil, @"IntentionalHypothermia is nil");
	 NSAssert([section getElementForKey:INTRA_OP_FORCED_AIR_UPPER_KEY]!= nil, @"IntraOpForcedAirUpper is nil");
	 NSAssert([section getElementForKey:INTRA_OP_FORCED_AIR_LOWER_KEY]!= nil, @"IntraOpForcedAirLower is nil");
	 NSAssert([section getElementForKey:NIBP_RIGHT_KEY]!= nil, @"NibpRight is nil");
	 NSAssert([section getElementForKey:NIBP_LEFT_KEY]!= nil, @"NibpLeft is nil");
	 NSAssert([section getElementForKey:NIBP_ARM_KEY]!= nil, @"NibpArm is nil");
	 NSAssert([section getElementForKey:NIBP_LEG_KEY]!= nil, @"NibpLeg is nil");
	 NSAssert([section getElementForKey:NIBP_EVERY_MIN_KEY]!= nil, @"NibpEveryMin is nil");
	 NSAssert([section getElementForKey:MONITORING_EQUIPMENT_OTHER_KEY]!= nil, @"MonitoringEquipmentOther is nil");
	 NSAssert([section getElementForKey:MONITORING_EQUIPMENT_OTHER_REASON_KEY]!= nil, @"MonitoringEquipmentOtherReason is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = MONITORIN_AND_EQUIPMENT_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *equipmentChecked = (BooleanFormElement*)[_section getElementForKey:EQUIPMENT_CHECKED_KEY];
	 if (!equipmentChecked) {
		 equipmentChecked = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 equipmentChecked.key = EQUIPMENT_CHECKED_KEY;
		 [_section addElementsObject:equipmentChecked];
	 }

	 equipmentChecked.value = [NSNumber numberWithBool:self.equipmentCheckedBBCheckBox.isSelected];
	 
	 BooleanFormElement *audibleAlarmsOn = (BooleanFormElement*)[_section getElementForKey:AUDIBLE_ALARMS_ON_KEY];
	 if (!audibleAlarmsOn) {
		 audibleAlarmsOn = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 audibleAlarmsOn.key = AUDIBLE_ALARMS_ON_KEY;
		 [_section addElementsObject:audibleAlarmsOn];
	 }

	 audibleAlarmsOn.value = [NSNumber numberWithBool:self.audibleAlarmsOnBBCheckBox.isSelected];
	 
	 BooleanFormElement *precordialSteth = (BooleanFormElement*)[_section getElementForKey:PRECORDIAL_STETH_KEY];
	 if (!precordialSteth) {
		 precordialSteth = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 precordialSteth.key = PRECORDIAL_STETH_KEY;
		 [_section addElementsObject:precordialSteth];
	 }

	 precordialSteth.value = [NSNumber numberWithBool:self.precordialStethBBCheckBox.isSelected];
	 
	 BooleanFormElement *nerveStimulator = (BooleanFormElement*)[_section getElementForKey:NERVE_STIMULATOR_KEY];
	 if (!nerveStimulator) {
		 nerveStimulator = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nerveStimulator.key = NERVE_STIMULATOR_KEY;
		 [_section addElementsObject:nerveStimulator];
	 }

	 nerveStimulator.value = [NSNumber numberWithBool:self.nerveStimulatorBBCheckBox.isSelected];
	 
	 BooleanFormElement *esophagealSteth = (BooleanFormElement*)[_section getElementForKey:ESOPHAGEAL_STETH_KEY];
	 if (!esophagealSteth) {
		 esophagealSteth = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 esophagealSteth.key = ESOPHAGEAL_STETH_KEY;
		 [_section addElementsObject:esophagealSteth];
	 }

	 esophagealSteth.value = [NSNumber numberWithBool:self.esophagealStethBBCheckBox.isSelected];
	 
	 BooleanFormElement *cellSaver = (BooleanFormElement*)[_section getElementForKey:CELL_SAVER_KEY];
	 if (!cellSaver) {
		 cellSaver = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cellSaver.key = CELL_SAVER_KEY;
		 [_section addElementsObject:cellSaver];
	 }

	 cellSaver.value = [NSNumber numberWithBool:self.cellSaverBBCheckBox.isSelected];
	 
	 BooleanFormElement *tEE = (BooleanFormElement*)[_section getElementForKey:TEE_KEY];
	 if (!tEE) {
		 tEE = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 tEE.key = TEE_KEY;
		 [_section addElementsObject:tEE];
	 }

	 tEE.value = [NSNumber numberWithBool:self.tEEBBCheckBox.isSelected];
	 
	 BooleanFormElement *fluidWarmer = (BooleanFormElement*)[_section getElementForKey:FLUID_WARMER_KEY];
	 if (!fluidWarmer) {
		 fluidWarmer = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 fluidWarmer.key = FLUID_WARMER_KEY;
		 [_section addElementsObject:fluidWarmer];
	 }

	 fluidWarmer.value = [NSNumber numberWithBool:self.fluidWarmerBBCheckBox.isSelected];
	 
	 BooleanFormElement *intentionalHypothermia = (BooleanFormElement*)[_section getElementForKey:INTENTIONAL_HYPOTHERMIA_KEY];
	 if (!intentionalHypothermia) {
		 intentionalHypothermia = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 intentionalHypothermia.key = INTENTIONAL_HYPOTHERMIA_KEY;
		 [_section addElementsObject:intentionalHypothermia];
	 }

	 intentionalHypothermia.value = [NSNumber numberWithBool:self.intentionalHypothermiaBBCheckBox.isSelected];
	 
	 BooleanFormElement *intraOpForcedAirUpper = (BooleanFormElement*)[_section getElementForKey:INTRA_OP_FORCED_AIR_UPPER_KEY];
	 if (!intraOpForcedAirUpper) {
		 intraOpForcedAirUpper = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 intraOpForcedAirUpper.key = INTRA_OP_FORCED_AIR_UPPER_KEY;
		 [_section addElementsObject:intraOpForcedAirUpper];
	 }

	 intraOpForcedAirUpper.value = [NSNumber numberWithBool:self.intraOpForcedAirUpperBBCheckBox.isSelected];
	 
	 BooleanFormElement *intraOpForcedAirLower = (BooleanFormElement*)[_section getElementForKey:INTRA_OP_FORCED_AIR_LOWER_KEY];
	 if (!intraOpForcedAirLower) {
		 intraOpForcedAirLower = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 intraOpForcedAirLower.key = INTRA_OP_FORCED_AIR_LOWER_KEY;
		 [_section addElementsObject:intraOpForcedAirLower];
	 }

	 intraOpForcedAirLower.value = [NSNumber numberWithBool:self.intraOpForcedAirLowerBBCheckBox.isSelected];
	 
	 BooleanFormElement *nibpRight = (BooleanFormElement*)[_section getElementForKey:NIBP_RIGHT_KEY];
	 if (!nibpRight) {
		 nibpRight = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nibpRight.key = NIBP_RIGHT_KEY;
		 [_section addElementsObject:nibpRight];
	 }

	 nibpRight.value = [NSNumber numberWithBool:self.nibpRightBBCheckBox.isSelected];
	 
	 BooleanFormElement *nibpLeft = (BooleanFormElement*)[_section getElementForKey:NIBP_LEFT_KEY];
	 if (!nibpLeft) {
		 nibpLeft = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nibpLeft.key = NIBP_LEFT_KEY;
		 [_section addElementsObject:nibpLeft];
	 }

	 nibpLeft.value = [NSNumber numberWithBool:self.nibpLeftBBCheckBox.isSelected];
	 
	 BooleanFormElement *nibpArm = (BooleanFormElement*)[_section getElementForKey:NIBP_ARM_KEY];
	 if (!nibpArm) {
		 nibpArm = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nibpArm.key = NIBP_ARM_KEY;
		 [_section addElementsObject:nibpArm];
	 }

	 nibpArm.value = [NSNumber numberWithBool:self.nibpArmBBCheckBox.isSelected];
	 
	 BooleanFormElement *nibpLeg = (BooleanFormElement*)[_section getElementForKey:NIBP_LEG_KEY];
	 if (!nibpLeg) {
		 nibpLeg = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nibpLeg.key = NIBP_LEG_KEY;
		 [_section addElementsObject:nibpLeg];
	 }

	 nibpLeg.value = [NSNumber numberWithBool:self.nibpLegBBCheckBox.isSelected];
	 
	 TextElement *nibpEveryMin = (TextElement*)[_section getElementForKey:NIBP_EVERY_MIN_KEY];
	 if (!nibpEveryMin) {
		 nibpEveryMin = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 nibpEveryMin.key = NIBP_EVERY_MIN_KEY;
		 [_section addElementsObject:nibpEveryMin];
	 }

	 nibpEveryMin.value = self.nibpEveryMinUITextField.text;
	 
	 BooleanFormElement *monitoringEquipmentOther = (BooleanFormElement*)[_section getElementForKey:MONITORING_EQUIPMENT_OTHER_KEY];
	 if (!monitoringEquipmentOther) {
		 monitoringEquipmentOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 monitoringEquipmentOther.key = MONITORING_EQUIPMENT_OTHER_KEY;
		 [_section addElementsObject:monitoringEquipmentOther];
	 }

	 monitoringEquipmentOther.value = [NSNumber numberWithBool:self.monitoringEquipmentOtherBBCheckBox.isSelected];
	 
	 TextElement *monitoringEquipmentOtherReason = (TextElement*)[_section getElementForKey:MONITORING_EQUIPMENT_OTHER_REASON_KEY];
	 if (!monitoringEquipmentOtherReason) {
		 monitoringEquipmentOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 monitoringEquipmentOtherReason.key = MONITORING_EQUIPMENT_OTHER_REASON_KEY;
		 [_section addElementsObject:monitoringEquipmentOtherReason];
	 }

	 monitoringEquipmentOtherReason.value = self.monitoringEquipmentOtherReasonUITextField.text;
	 
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
	 return MONITORIN_AND_EQUIPMENT_SECTION_TITLE;
}
@end