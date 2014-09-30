
#import "PlanDiscussionViewController.h"
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


@interface PlanDiscussionViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *patientAcceptedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *parentAcceptedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *guardianAcceptedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *viaTranslatorAcceptedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *epiduralBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *generalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *spinalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nerveBlockIVRegionalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *chronicCardioPulmonaryDiseaseBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *immobilityNeededBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *straightLocalNotAdequateBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *arterialLineBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *pulmonaryArteryCathBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *centralVenousCathBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *tEEBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *possiblePostOpVentBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *otherTextField;
@property (weak, nonatomic) IBOutlet UITableView *otherTable;
@property (strong, nonatomic) StringArrayTableAdapter *otherTableAdapter;
@property (weak, nonatomic) IBOutlet BBCheckBox *postopPainManagementDiscussedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *pCABBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *postOpEpiduralBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *spinalOpiateBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nerveBlockContinuousBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nerveBlockSingleShotBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *aSA1BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *aSA2BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *aSA3BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *aSA4BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *aSA5BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *aSA6BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *aSAEBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *preOpEvaluationByUITextField;
@end

@implementation PlanDiscussionViewController
NSString *const PLAN_DISCUSSION_SECTION_TITLE = @"PlanDiscussionSectionKey";
static NSString *const PATIENT_ACCEPTED_KEY = @"PatientAcceptedKey";
static NSString *const PARENT_ACCEPTED_KEY = @"ParentAcceptedKey";
static NSString *const GUARDIAN_ACCEPTED_KEY = @"GuardianAcceptedKey";
static NSString *const VIA_TRANSLATOR_ACCEPTED_KEY = @"ViaTranslatorAcceptedKey";
static NSString *const EPIDURAL_KEY = @"EpiduralKey";
static NSString *const GENERAL_KEY = @"GeneralKey";
static NSString *const SPINAL_KEY = @"SpinalKey";
static NSString *const NERVE_BLOCKIVRegional_KEY = @"NerveBlockIVRegionalKey";
static NSString *const CHRONIC_CARDIO_PULMONARY_DISEASE_KEY = @"ChronicCardioPulmonaryDiseaseKey";
static NSString *const IMMOBILITY_NEEDED_KEY = @"ImmobilityNeededKey";
static NSString *const STRAIGHT_LOCAL_NOT_ADEQUATE_KEY = @"StraightLocalNotAdequateKey";
static NSString *const ARTERIAL_LINE_KEY = @"ArterialLineKey";
static NSString *const PULMONARY_ARTERY_CATH_KEY = @"PulmonaryArteryCathKey";
static NSString *const CENTRAL_VENOUS_CATH_KEY = @"CentralVenousCathKey";
static NSString *const TEE_KEY = @"TEEKey";
static NSString *const POSSIBLE_POST_OP_VENT_KEY = @"PossiblePostOpVentKey";
static NSString *const OTHER_KEY = @"OtherKey";
static NSString *const POSTOP_PAIN_MANAGEMENT_DISCUSSED_KEY = @"PostopPainManagementDiscussedKey";
static NSString *const PCA_KEY = @"PCAKey";
static NSString *const POST_OP_EPIDURAL_KEY = @"PostOpEpiduralKey";
static NSString *const SPINAL_OPIATE_KEY = @"SpinalOpiateKey";
static NSString *const NERVE_BLOCK_CONTINUOUS_KEY = @"NerveBlockContinuousKey";
static NSString *const NERVE_BLOCK_SINGLE_SHOT_KEY = @"NerveBlockSingleShotKey";
static NSString *const ASA1_KEY = @"ASA1Key";
static NSString *const ASA2_KEY = @"ASA2Key";
static NSString *const ASA3_KEY = @"ASA3Key";
static NSString *const ASA4_KEY = @"ASA4Key";
static NSString *const ASA5_KEY = @"ASA5Key";
static NSString *const ASA6_KEY = @"ASA6Key";
static NSString *const ASAE_KEY = @"ASAEKey";
static NSString *const PRE_OP_EVALUATION_BY_KEY = @"PreOpEvaluationByKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.otherTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.otherTable.dataSource = self.otherTableAdapter;
	 self.otherTable.delegate = self.otherTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:PATIENT_ACCEPTED_KEY]){
				 [self.patientAcceptedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PARENT_ACCEPTED_KEY]){
				 [self.parentAcceptedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:GUARDIAN_ACCEPTED_KEY]){
				 [self.guardianAcceptedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:VIA_TRANSLATOR_ACCEPTED_KEY]){
				 [self.viaTranslatorAcceptedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:EPIDURAL_KEY]){
				 [self.epiduralBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:GENERAL_KEY]){
				 [self.generalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SPINAL_KEY]){
				 [self.spinalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NERVE_BLOCKIVRegional_KEY]){
				 [self.nerveBlockIVRegionalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CHRONIC_CARDIO_PULMONARY_DISEASE_KEY]){
				 [self.chronicCardioPulmonaryDiseaseBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:IMMOBILITY_NEEDED_KEY]){
				 [self.immobilityNeededBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:STRAIGHT_LOCAL_NOT_ADEQUATE_KEY]){
				 [self.straightLocalNotAdequateBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ARTERIAL_LINE_KEY]){
				 [self.arterialLineBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PULMONARY_ARTERY_CATH_KEY]){
				 [self.pulmonaryArteryCathBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CENTRAL_VENOUS_CATH_KEY]){
				 [self.centralVenousCathBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:TEE_KEY]){
				 [self.tEEBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POSSIBLE_POST_OP_VENT_KEY]){
				 [self.possiblePostOpVentBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OTHER_KEY]){
				 self.otherTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.otherTable reloadData];
			 }
			 if ([element.key isEqualToString:POSTOP_PAIN_MANAGEMENT_DISCUSSED_KEY]){
				 [self.postopPainManagementDiscussedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PCA_KEY]){
				 [self.pCABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POST_OP_EPIDURAL_KEY]){
				 [self.postOpEpiduralBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SPINAL_OPIATE_KEY]){
				 [self.spinalOpiateBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NERVE_BLOCK_CONTINUOUS_KEY]){
				 [self.nerveBlockContinuousBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NERVE_BLOCK_SINGLE_SHOT_KEY]){
				 [self.nerveBlockSingleShotBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASA1_KEY]){
				 [self.aSA1BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASA2_KEY]){
				 [self.aSA2BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASA3_KEY]){
				 [self.aSA3BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASA4_KEY]){
				 [self.aSA4BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASA5_KEY]){
				 [self.aSA5BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASA6_KEY]){
				 [self.aSA6BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASAE_KEY]){
				 [self.aSAEBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PRE_OP_EVALUATION_BY_KEY]){
				 [self.preOpEvaluationByUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:PATIENT_ACCEPTED_KEY]!= nil, @"PatientAccepted is nil");
	 NSAssert([section getElementForKey:PARENT_ACCEPTED_KEY]!= nil, @"ParentAccepted is nil");
	 NSAssert([section getElementForKey:GUARDIAN_ACCEPTED_KEY]!= nil, @"GuardianAccepted is nil");
	 NSAssert([section getElementForKey:VIA_TRANSLATOR_ACCEPTED_KEY]!= nil, @"ViaTranslatorAccepted is nil");
	 NSAssert([section getElementForKey:EPIDURAL_KEY]!= nil, @"Epidural is nil");
	 NSAssert([section getElementForKey:GENERAL_KEY]!= nil, @"General is nil");
	 NSAssert([section getElementForKey:SPINAL_KEY]!= nil, @"Spinal is nil");
	 NSAssert([section getElementForKey:NERVE_BLOCKIVRegional_KEY]!= nil, @"NerveBlockIVRegional is nil");
	 NSAssert([section getElementForKey:CHRONIC_CARDIO_PULMONARY_DISEASE_KEY]!= nil, @"ChronicCardioPulmonaryDisease is nil");
	 NSAssert([section getElementForKey:IMMOBILITY_NEEDED_KEY]!= nil, @"ImmobilityNeeded is nil");
	 NSAssert([section getElementForKey:STRAIGHT_LOCAL_NOT_ADEQUATE_KEY]!= nil, @"StraightLocalNotAdequate is nil");
	 NSAssert([section getElementForKey:ARTERIAL_LINE_KEY]!= nil, @"ArterialLine is nil");
	 NSAssert([section getElementForKey:PULMONARY_ARTERY_CATH_KEY]!= nil, @"PulmonaryArteryCath is nil");
	 NSAssert([section getElementForKey:CENTRAL_VENOUS_CATH_KEY]!= nil, @"CentralVenousCath is nil");
	 NSAssert([section getElementForKey:TEE_KEY]!= nil, @"TEE is nil");
	 NSAssert([section getElementForKey:POSSIBLE_POST_OP_VENT_KEY]!= nil, @"PossiblePostOpVent is nil");
	 NSAssert([section getElementForKey:OTHER_KEY]!= nil, @"Other is nil");
	 NSAssert([section getElementForKey:POSTOP_PAIN_MANAGEMENT_DISCUSSED_KEY]!= nil, @"PostopPainManagementDiscussed is nil");
	 NSAssert([section getElementForKey:PCA_KEY]!= nil, @"PCA is nil");
	 NSAssert([section getElementForKey:POST_OP_EPIDURAL_KEY]!= nil, @"PostOpEpidural is nil");
	 NSAssert([section getElementForKey:SPINAL_OPIATE_KEY]!= nil, @"SpinalOpiate is nil");
	 NSAssert([section getElementForKey:NERVE_BLOCK_CONTINUOUS_KEY]!= nil, @"NerveBlockContinuous is nil");
	 NSAssert([section getElementForKey:NERVE_BLOCK_SINGLE_SHOT_KEY]!= nil, @"NerveBlockSingleShot is nil");
	 NSAssert([section getElementForKey:ASA1_KEY]!= nil, @"ASA1 is nil");
	 NSAssert([section getElementForKey:ASA2_KEY]!= nil, @"ASA2 is nil");
	 NSAssert([section getElementForKey:ASA3_KEY]!= nil, @"ASA3 is nil");
	 NSAssert([section getElementForKey:ASA4_KEY]!= nil, @"ASA4 is nil");
	 NSAssert([section getElementForKey:ASA5_KEY]!= nil, @"ASA5 is nil");
	 NSAssert([section getElementForKey:ASA6_KEY]!= nil, @"ASA6 is nil");
	 NSAssert([section getElementForKey:ASAE_KEY]!= nil, @"ASAE is nil");
	 NSAssert([section getElementForKey:PRE_OP_EVALUATION_BY_KEY]!= nil, @"PreOpEvaluationBy is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PLAN_DISCUSSION_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *patientAccepted = (BooleanFormElement*)[_section getElementForKey:PATIENT_ACCEPTED_KEY];
	 if (!patientAccepted) {
		 patientAccepted = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 patientAccepted.key = PATIENT_ACCEPTED_KEY;
		 [_section addElementsObject:patientAccepted];
	 }

	 patientAccepted.value = [NSNumber numberWithBool:self.patientAcceptedBBCheckBox.isSelected];
	 
	 BooleanFormElement *parentAccepted = (BooleanFormElement*)[_section getElementForKey:PARENT_ACCEPTED_KEY];
	 if (!parentAccepted) {
		 parentAccepted = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 parentAccepted.key = PARENT_ACCEPTED_KEY;
		 [_section addElementsObject:parentAccepted];
	 }

	 parentAccepted.value = [NSNumber numberWithBool:self.parentAcceptedBBCheckBox.isSelected];
	 
	 BooleanFormElement *guardianAccepted = (BooleanFormElement*)[_section getElementForKey:GUARDIAN_ACCEPTED_KEY];
	 if (!guardianAccepted) {
		 guardianAccepted = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 guardianAccepted.key = GUARDIAN_ACCEPTED_KEY;
		 [_section addElementsObject:guardianAccepted];
	 }

	 guardianAccepted.value = [NSNumber numberWithBool:self.guardianAcceptedBBCheckBox.isSelected];
	 
	 BooleanFormElement *viaTranslatorAccepted = (BooleanFormElement*)[_section getElementForKey:VIA_TRANSLATOR_ACCEPTED_KEY];
	 if (!viaTranslatorAccepted) {
		 viaTranslatorAccepted = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 viaTranslatorAccepted.key = VIA_TRANSLATOR_ACCEPTED_KEY;
		 [_section addElementsObject:viaTranslatorAccepted];
	 }

	 viaTranslatorAccepted.value = [NSNumber numberWithBool:self.viaTranslatorAcceptedBBCheckBox.isSelected];
	 
	 BooleanFormElement *epidural = (BooleanFormElement*)[_section getElementForKey:EPIDURAL_KEY];
	 if (!epidural) {
		 epidural = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 epidural.key = EPIDURAL_KEY;
		 [_section addElementsObject:epidural];
	 }

	 epidural.value = [NSNumber numberWithBool:self.epiduralBBCheckBox.isSelected];
	 
	 BooleanFormElement *general = (BooleanFormElement*)[_section getElementForKey:GENERAL_KEY];
	 if (!general) {
		 general = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 general.key = GENERAL_KEY;
		 [_section addElementsObject:general];
	 }

	 general.value = [NSNumber numberWithBool:self.generalBBCheckBox.isSelected];
	 
	 BooleanFormElement *spinal = (BooleanFormElement*)[_section getElementForKey:SPINAL_KEY];
	 if (!spinal) {
		 spinal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 spinal.key = SPINAL_KEY;
		 [_section addElementsObject:spinal];
	 }

	 spinal.value = [NSNumber numberWithBool:self.spinalBBCheckBox.isSelected];
	 
	 BooleanFormElement *nerveBlockIVRegional = (BooleanFormElement*)[_section getElementForKey:NERVE_BLOCKIVRegional_KEY];
	 if (!nerveBlockIVRegional) {
		 nerveBlockIVRegional = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nerveBlockIVRegional.key = NERVE_BLOCKIVRegional_KEY;
		 [_section addElementsObject:nerveBlockIVRegional];
	 }

	 nerveBlockIVRegional.value = [NSNumber numberWithBool:self.nerveBlockIVRegionalBBCheckBox.isSelected];
	 
	 BooleanFormElement *chronicCardioPulmonaryDisease = (BooleanFormElement*)[_section getElementForKey:CHRONIC_CARDIO_PULMONARY_DISEASE_KEY];
	 if (!chronicCardioPulmonaryDisease) {
		 chronicCardioPulmonaryDisease = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 chronicCardioPulmonaryDisease.key = CHRONIC_CARDIO_PULMONARY_DISEASE_KEY;
		 [_section addElementsObject:chronicCardioPulmonaryDisease];
	 }

	 chronicCardioPulmonaryDisease.value = [NSNumber numberWithBool:self.chronicCardioPulmonaryDiseaseBBCheckBox.isSelected];
	 
	 BooleanFormElement *immobilityNeeded = (BooleanFormElement*)[_section getElementForKey:IMMOBILITY_NEEDED_KEY];
	 if (!immobilityNeeded) {
		 immobilityNeeded = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 immobilityNeeded.key = IMMOBILITY_NEEDED_KEY;
		 [_section addElementsObject:immobilityNeeded];
	 }

	 immobilityNeeded.value = [NSNumber numberWithBool:self.immobilityNeededBBCheckBox.isSelected];
	 
	 BooleanFormElement *straightLocalNotAdequate = (BooleanFormElement*)[_section getElementForKey:STRAIGHT_LOCAL_NOT_ADEQUATE_KEY];
	 if (!straightLocalNotAdequate) {
		 straightLocalNotAdequate = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 straightLocalNotAdequate.key = STRAIGHT_LOCAL_NOT_ADEQUATE_KEY;
		 [_section addElementsObject:straightLocalNotAdequate];
	 }

	 straightLocalNotAdequate.value = [NSNumber numberWithBool:self.straightLocalNotAdequateBBCheckBox.isSelected];
	 
	 BooleanFormElement *arterialLine = (BooleanFormElement*)[_section getElementForKey:ARTERIAL_LINE_KEY];
	 if (!arterialLine) {
		 arterialLine = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 arterialLine.key = ARTERIAL_LINE_KEY;
		 [_section addElementsObject:arterialLine];
	 }

	 arterialLine.value = [NSNumber numberWithBool:self.arterialLineBBCheckBox.isSelected];
	 
	 BooleanFormElement *pulmonaryArteryCath = (BooleanFormElement*)[_section getElementForKey:PULMONARY_ARTERY_CATH_KEY];
	 if (!pulmonaryArteryCath) {
		 pulmonaryArteryCath = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pulmonaryArteryCath.key = PULMONARY_ARTERY_CATH_KEY;
		 [_section addElementsObject:pulmonaryArteryCath];
	 }

	 pulmonaryArteryCath.value = [NSNumber numberWithBool:self.pulmonaryArteryCathBBCheckBox.isSelected];
	 
	 BooleanFormElement *centralVenousCath = (BooleanFormElement*)[_section getElementForKey:CENTRAL_VENOUS_CATH_KEY];
	 if (!centralVenousCath) {
		 centralVenousCath = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 centralVenousCath.key = CENTRAL_VENOUS_CATH_KEY;
		 [_section addElementsObject:centralVenousCath];
	 }

	 centralVenousCath.value = [NSNumber numberWithBool:self.centralVenousCathBBCheckBox.isSelected];
	 
	 BooleanFormElement *tEE = (BooleanFormElement*)[_section getElementForKey:TEE_KEY];
	 if (!tEE) {
		 tEE = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 tEE.key = TEE_KEY;
		 [_section addElementsObject:tEE];
	 }

	 tEE.value = [NSNumber numberWithBool:self.tEEBBCheckBox.isSelected];
	 
	 BooleanFormElement *possiblePostOpVent = (BooleanFormElement*)[_section getElementForKey:POSSIBLE_POST_OP_VENT_KEY];
	 if (!possiblePostOpVent) {
		 possiblePostOpVent = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 possiblePostOpVent.key = POSSIBLE_POST_OP_VENT_KEY;
		 [_section addElementsObject:possiblePostOpVent];
	 }

	 possiblePostOpVent.value = [NSNumber numberWithBool:self.possiblePostOpVentBBCheckBox.isSelected];
	 
	 StringListElement *other = (StringListElement*)[_section getElementForKey:OTHER_KEY];
	 if (!other) {
		 other = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 other.key = OTHER_KEY;
		 [_section addElementsObject:other];
	 }

	 NSMutableArray *otherStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.otherTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.otherTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [otherStringArray addObject:cell.textLabel.text];
	 }
	 other.value = otherStringArray;
	 
	 BooleanFormElement *postopPainManagementDiscussed = (BooleanFormElement*)[_section getElementForKey:POSTOP_PAIN_MANAGEMENT_DISCUSSED_KEY];
	 if (!postopPainManagementDiscussed) {
		 postopPainManagementDiscussed = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 postopPainManagementDiscussed.key = POSTOP_PAIN_MANAGEMENT_DISCUSSED_KEY;
		 [_section addElementsObject:postopPainManagementDiscussed];
	 }

	 postopPainManagementDiscussed.value = [NSNumber numberWithBool:self.postopPainManagementDiscussedBBCheckBox.isSelected];
	 
	 BooleanFormElement *pCA = (BooleanFormElement*)[_section getElementForKey:PCA_KEY];
	 if (!pCA) {
		 pCA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pCA.key = PCA_KEY;
		 [_section addElementsObject:pCA];
	 }

	 pCA.value = [NSNumber numberWithBool:self.pCABBCheckBox.isSelected];
	 
	 BooleanFormElement *postOpEpidural = (BooleanFormElement*)[_section getElementForKey:POST_OP_EPIDURAL_KEY];
	 if (!postOpEpidural) {
		 postOpEpidural = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 postOpEpidural.key = POST_OP_EPIDURAL_KEY;
		 [_section addElementsObject:postOpEpidural];
	 }

	 postOpEpidural.value = [NSNumber numberWithBool:self.postOpEpiduralBBCheckBox.isSelected];
	 
	 BooleanFormElement *spinalOpiate = (BooleanFormElement*)[_section getElementForKey:SPINAL_OPIATE_KEY];
	 if (!spinalOpiate) {
		 spinalOpiate = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 spinalOpiate.key = SPINAL_OPIATE_KEY;
		 [_section addElementsObject:spinalOpiate];
	 }

	 spinalOpiate.value = [NSNumber numberWithBool:self.spinalOpiateBBCheckBox.isSelected];
	 
	 BooleanFormElement *nerveBlockContinuous = (BooleanFormElement*)[_section getElementForKey:NERVE_BLOCK_CONTINUOUS_KEY];
	 if (!nerveBlockContinuous) {
		 nerveBlockContinuous = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nerveBlockContinuous.key = NERVE_BLOCK_CONTINUOUS_KEY;
		 [_section addElementsObject:nerveBlockContinuous];
	 }

	 nerveBlockContinuous.value = [NSNumber numberWithBool:self.nerveBlockContinuousBBCheckBox.isSelected];
	 
	 BooleanFormElement *nerveBlockSingleShot = (BooleanFormElement*)[_section getElementForKey:NERVE_BLOCK_SINGLE_SHOT_KEY];
	 if (!nerveBlockSingleShot) {
		 nerveBlockSingleShot = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nerveBlockSingleShot.key = NERVE_BLOCK_SINGLE_SHOT_KEY;
		 [_section addElementsObject:nerveBlockSingleShot];
	 }

	 nerveBlockSingleShot.value = [NSNumber numberWithBool:self.nerveBlockSingleShotBBCheckBox.isSelected];
	 
	 BooleanFormElement *aSA1 = (BooleanFormElement*)[_section getElementForKey:ASA1_KEY];
	 if (!aSA1) {
		 aSA1 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aSA1.key = ASA1_KEY;
		 [_section addElementsObject:aSA1];
	 }

	 aSA1.value = [NSNumber numberWithBool:self.aSA1BBCheckBox.isSelected];
	 
	 BooleanFormElement *aSA2 = (BooleanFormElement*)[_section getElementForKey:ASA2_KEY];
	 if (!aSA2) {
		 aSA2 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aSA2.key = ASA2_KEY;
		 [_section addElementsObject:aSA2];
	 }

	 aSA2.value = [NSNumber numberWithBool:self.aSA2BBCheckBox.isSelected];
	 
	 BooleanFormElement *aSA3 = (BooleanFormElement*)[_section getElementForKey:ASA3_KEY];
	 if (!aSA3) {
		 aSA3 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aSA3.key = ASA3_KEY;
		 [_section addElementsObject:aSA3];
	 }

	 aSA3.value = [NSNumber numberWithBool:self.aSA3BBCheckBox.isSelected];
	 
	 BooleanFormElement *aSA4 = (BooleanFormElement*)[_section getElementForKey:ASA4_KEY];
	 if (!aSA4) {
		 aSA4 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aSA4.key = ASA4_KEY;
		 [_section addElementsObject:aSA4];
	 }

	 aSA4.value = [NSNumber numberWithBool:self.aSA4BBCheckBox.isSelected];
	 
	 BooleanFormElement *aSA5 = (BooleanFormElement*)[_section getElementForKey:ASA5_KEY];
	 if (!aSA5) {
		 aSA5 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aSA5.key = ASA5_KEY;
		 [_section addElementsObject:aSA5];
	 }

	 aSA5.value = [NSNumber numberWithBool:self.aSA5BBCheckBox.isSelected];
	 
	 BooleanFormElement *aSA6 = (BooleanFormElement*)[_section getElementForKey:ASA6_KEY];
	 if (!aSA6) {
		 aSA6 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aSA6.key = ASA6_KEY;
		 [_section addElementsObject:aSA6];
	 }

	 aSA6.value = [NSNumber numberWithBool:self.aSA6BBCheckBox.isSelected];
	 
	 BooleanFormElement *aSAE = (BooleanFormElement*)[_section getElementForKey:ASAE_KEY];
	 if (!aSAE) {
		 aSAE = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aSAE.key = ASAE_KEY;
		 [_section addElementsObject:aSAE];
	 }

	 aSAE.value = [NSNumber numberWithBool:self.aSAEBBCheckBox.isSelected];
	 
	 TextElement *preOpEvaluationBy = (TextElement*)[_section getElementForKey:PRE_OP_EVALUATION_BY_KEY];
	 if (!preOpEvaluationBy) {
		 preOpEvaluationBy = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 preOpEvaluationBy.key = PRE_OP_EVALUATION_BY_KEY;
		 [_section addElementsObject:preOpEvaluationBy];
	 }

	 preOpEvaluationBy.value = self.preOpEvaluationByUITextField.text;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOther:(id)sender {
	 [self.otherTableAdapter.items addObject:self.otherTextField.text];
	 [self.otherTable reloadData];
	 self.otherTextField.text = @"";
	 [self.otherTextField resignFirstResponder];
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
	 return PLAN_DISCUSSION_SECTION_TITLE;
}
@end