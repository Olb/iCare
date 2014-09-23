
#import "SpinalAnesthesiaViewController.h"
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


@interface SpinalAnesthesiaViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *csfClearBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *csfCloudyBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *csfBloodyBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *positionSitBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *positionRtLatBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *positionLtLatBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *asepticBetadineBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *asepticAlcoholBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *asepticDuraPrepBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *interspaceUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *localInflitrationBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *paresthesiaNoneBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *paresthesiaOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *paresthesiaOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet UITextField *spiNeedleGramsUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *pencilPointBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *spiNeedleOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *spiNeedleOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet UITextField *nrAttemptsUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *bupivacaineBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *bupivacaineMlUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *medOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *medOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet UITextField *fentanylUITextField;
@property (weak, nonatomic) IBOutlet UITextField *duramorphUITextField;
@end

@implementation SpinalAnesthesiaViewController
NSString *const SPINAL_ANESTHESIA_SECTION_TITLE = @"SpinalAnesthesiaSectionKey";
static NSString *const CSF_CLEAR_KEY = @"CsfClearKey";
static NSString *const CSF_CLOUDY_KEY = @"CsfCloudyKey";
static NSString *const CSF_BLOODY_KEY = @"CsfBloodyKey";
static NSString *const POSITION_SIT_KEY = @"PositionSitKey";
static NSString *const POSITION_RT_LAT_KEY = @"PositionRtLatKey";
static NSString *const POSITION_LT_LAT_KEY = @"PositionLtLatKey";
static NSString *const ASEPTIC_BETADINE_KEY = @"AsepticBetadineKey";
static NSString *const ASEPTIC_ALCOHOL_KEY = @"AsepticAlcoholKey";
static NSString *const ASEPTIC_DURA_PREP_KEY = @"AsepticDuraPrepKey";
static NSString *const INTERSPACE_KEY = @"InterspaceKey";
static NSString *const LOCAL_INFLITRATION_KEY = @"LocalInflitrationKey";
static NSString *const PARESTHESIA_NONE_KEY = @"ParesthesiaNoneKey";
static NSString *const PARESTHESIA_OTHER_KEY = @"ParesthesiaOtherKey";
static NSString *const PARESTHESIA_OTHER_REASON_KEY = @"ParesthesiaOtherReasonKey";
static NSString *const SPI_NEEDLE_GRAMS_KEY = @"SpiNeedleGramsKey";
static NSString *const PENCIL_POINT_KEY = @"PencilPointKey";
static NSString *const SPI_NEEDLE_OTHER_KEY = @"SpiNeedleOtherKey";
static NSString *const SPI_NEEDLE_OTHER_REASON_KEY = @"SpiNeedleOtherReasonKey";
static NSString *const NR_ATTEMPTS_KEY = @"NrAttemptsKey";
static NSString *const BUPIVACAINE_KEY = @"BupivacaineKey";
static NSString *const BUPIVACAINE_ML_KEY = @"BupivacaineMlKey";
static NSString *const MED_OTHER_KEY = @"MedOtherKey";
static NSString *const MED_OTHER_REASON_KEY = @"MedOtherReasonKey";
static NSString *const FENTANYL_KEY = @"FentanylKey";
static NSString *const DURAMORPH_KEY = @"DuramorphKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:CSF_CLEAR_KEY]){
				 [self.csfClearBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CSF_CLOUDY_KEY]){
				 [self.csfCloudyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CSF_BLOODY_KEY]){
				 [self.csfBloodyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POSITION_SIT_KEY]){
				 [self.positionSitBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POSITION_RT_LAT_KEY]){
				 [self.positionRtLatBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:POSITION_LT_LAT_KEY]){
				 [self.positionLtLatBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASEPTIC_BETADINE_KEY]){
				 [self.asepticBetadineBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASEPTIC_ALCOHOL_KEY]){
				 [self.asepticAlcoholBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASEPTIC_DURA_PREP_KEY]){
				 [self.asepticDuraPrepBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INTERSPACE_KEY]){
				 [self.interspaceUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:LOCAL_INFLITRATION_KEY]){
				 [self.localInflitrationBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PARESTHESIA_NONE_KEY]){
				 [self.paresthesiaNoneBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PARESTHESIA_OTHER_KEY]){
				 [self.paresthesiaOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PARESTHESIA_OTHER_REASON_KEY]){
				 [self.paresthesiaOtherReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:SPI_NEEDLE_GRAMS_KEY]){
				 [self.spiNeedleGramsUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:PENCIL_POINT_KEY]){
				 [self.pencilPointBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SPI_NEEDLE_OTHER_KEY]){
				 [self.spiNeedleOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SPI_NEEDLE_OTHER_REASON_KEY]){
				 [self.spiNeedleOtherReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:NR_ATTEMPTS_KEY]){
				 [self.nrAttemptsUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:BUPIVACAINE_KEY]){
				 [self.bupivacaineBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:BUPIVACAINE_ML_KEY]){
				 [self.bupivacaineMlUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:MED_OTHER_KEY]){
				 [self.medOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MED_OTHER_REASON_KEY]){
				 [self.medOtherReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:FENTANYL_KEY]){
				 [self.fentanylUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:DURAMORPH_KEY]){
				 [self.duramorphUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:CSF_CLEAR_KEY]!= nil, @"CsfClear is nil");
	 NSAssert([section getElementForKey:CSF_CLOUDY_KEY]!= nil, @"CsfCloudy is nil");
	 NSAssert([section getElementForKey:CSF_BLOODY_KEY]!= nil, @"CsfBloody is nil");
	 NSAssert([section getElementForKey:POSITION_SIT_KEY]!= nil, @"PositionSit is nil");
	 NSAssert([section getElementForKey:POSITION_RT_LAT_KEY]!= nil, @"PositionRtLat is nil");
	 NSAssert([section getElementForKey:POSITION_LT_LAT_KEY]!= nil, @"PositionLtLat is nil");
	 NSAssert([section getElementForKey:ASEPTIC_BETADINE_KEY]!= nil, @"AsepticBetadine is nil");
	 NSAssert([section getElementForKey:ASEPTIC_ALCOHOL_KEY]!= nil, @"AsepticAlcohol is nil");
	 NSAssert([section getElementForKey:ASEPTIC_DURA_PREP_KEY]!= nil, @"AsepticDuraPrep is nil");
	 NSAssert([section getElementForKey:INTERSPACE_KEY]!= nil, @"Interspace is nil");
	 NSAssert([section getElementForKey:LOCAL_INFLITRATION_KEY]!= nil, @"LocalInflitration is nil");
	 NSAssert([section getElementForKey:PARESTHESIA_NONE_KEY]!= nil, @"ParesthesiaNone is nil");
	 NSAssert([section getElementForKey:PARESTHESIA_OTHER_KEY]!= nil, @"ParesthesiaOther is nil");
	 NSAssert([section getElementForKey:PARESTHESIA_OTHER_REASON_KEY]!= nil, @"ParesthesiaOtherReason is nil");
	 NSAssert([section getElementForKey:SPI_NEEDLE_GRAMS_KEY]!= nil, @"SpiNeedleGrams is nil");
	 NSAssert([section getElementForKey:PENCIL_POINT_KEY]!= nil, @"PencilPoint is nil");
	 NSAssert([section getElementForKey:SPI_NEEDLE_OTHER_KEY]!= nil, @"SpiNeedleOther is nil");
	 NSAssert([section getElementForKey:SPI_NEEDLE_OTHER_REASON_KEY]!= nil, @"SpiNeedleOtherReason is nil");
	 NSAssert([section getElementForKey:NR_ATTEMPTS_KEY]!= nil, @"NrAttempts is nil");
	 NSAssert([section getElementForKey:BUPIVACAINE_KEY]!= nil, @"Bupivacaine is nil");
	 NSAssert([section getElementForKey:BUPIVACAINE_ML_KEY]!= nil, @"BupivacaineMl is nil");
	 NSAssert([section getElementForKey:MED_OTHER_KEY]!= nil, @"MedOther is nil");
	 NSAssert([section getElementForKey:MED_OTHER_REASON_KEY]!= nil, @"MedOtherReason is nil");
	 NSAssert([section getElementForKey:FENTANYL_KEY]!= nil, @"Fentanyl is nil");
	 NSAssert([section getElementForKey:DURAMORPH_KEY]!= nil, @"Duramorph is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = SPINAL_ANESTHESIA_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *csfClear = (BooleanFormElement*)[_section getElementForKey:CSF_CLEAR_KEY];
	 if (!csfClear) {
		 csfClear = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 csfClear.key = CSF_CLEAR_KEY;
		 [_section addElementsObject:csfClear];
	 }

	 csfClear.value = [NSNumber numberWithBool:self.csfClearBBCheckBox.isSelected];
	 
	 BooleanFormElement *csfCloudy = (BooleanFormElement*)[_section getElementForKey:CSF_CLOUDY_KEY];
	 if (!csfCloudy) {
		 csfCloudy = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 csfCloudy.key = CSF_CLOUDY_KEY;
		 [_section addElementsObject:csfCloudy];
	 }

	 csfCloudy.value = [NSNumber numberWithBool:self.csfCloudyBBCheckBox.isSelected];
	 
	 BooleanFormElement *csfBloody = (BooleanFormElement*)[_section getElementForKey:CSF_BLOODY_KEY];
	 if (!csfBloody) {
		 csfBloody = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 csfBloody.key = CSF_BLOODY_KEY;
		 [_section addElementsObject:csfBloody];
	 }

	 csfBloody.value = [NSNumber numberWithBool:self.csfBloodyBBCheckBox.isSelected];
	 
	 BooleanFormElement *positionSit = (BooleanFormElement*)[_section getElementForKey:POSITION_SIT_KEY];
	 if (!positionSit) {
		 positionSit = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 positionSit.key = POSITION_SIT_KEY;
		 [_section addElementsObject:positionSit];
	 }

	 positionSit.value = [NSNumber numberWithBool:self.positionSitBBCheckBox.isSelected];
	 
	 BooleanFormElement *positionRtLat = (BooleanFormElement*)[_section getElementForKey:POSITION_RT_LAT_KEY];
	 if (!positionRtLat) {
		 positionRtLat = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 positionRtLat.key = POSITION_RT_LAT_KEY;
		 [_section addElementsObject:positionRtLat];
	 }

	 positionRtLat.value = [NSNumber numberWithBool:self.positionRtLatBBCheckBox.isSelected];
	 
	 BooleanFormElement *positionLtLat = (BooleanFormElement*)[_section getElementForKey:POSITION_LT_LAT_KEY];
	 if (!positionLtLat) {
		 positionLtLat = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 positionLtLat.key = POSITION_LT_LAT_KEY;
		 [_section addElementsObject:positionLtLat];
	 }

	 positionLtLat.value = [NSNumber numberWithBool:self.positionLtLatBBCheckBox.isSelected];
	 
	 BooleanFormElement *asepticBetadine = (BooleanFormElement*)[_section getElementForKey:ASEPTIC_BETADINE_KEY];
	 if (!asepticBetadine) {
		 asepticBetadine = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 asepticBetadine.key = ASEPTIC_BETADINE_KEY;
		 [_section addElementsObject:asepticBetadine];
	 }

	 asepticBetadine.value = [NSNumber numberWithBool:self.asepticBetadineBBCheckBox.isSelected];
	 
	 BooleanFormElement *asepticAlcohol = (BooleanFormElement*)[_section getElementForKey:ASEPTIC_ALCOHOL_KEY];
	 if (!asepticAlcohol) {
		 asepticAlcohol = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 asepticAlcohol.key = ASEPTIC_ALCOHOL_KEY;
		 [_section addElementsObject:asepticAlcohol];
	 }

	 asepticAlcohol.value = [NSNumber numberWithBool:self.asepticAlcoholBBCheckBox.isSelected];
	 
	 BooleanFormElement *asepticDuraPrep = (BooleanFormElement*)[_section getElementForKey:ASEPTIC_DURA_PREP_KEY];
	 if (!asepticDuraPrep) {
		 asepticDuraPrep = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 asepticDuraPrep.key = ASEPTIC_DURA_PREP_KEY;
		 [_section addElementsObject:asepticDuraPrep];
	 }

	 asepticDuraPrep.value = [NSNumber numberWithBool:self.asepticDuraPrepBBCheckBox.isSelected];
	 
	 TextElement *interspace = (TextElement*)[_section getElementForKey:INTERSPACE_KEY];
	 if (!interspace) {
		 interspace = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 interspace.key = INTERSPACE_KEY;
		 [_section addElementsObject:interspace];
	 }

	 interspace.value = self.interspaceUITextField.text;
	 
	 BooleanFormElement *localInflitration = (BooleanFormElement*)[_section getElementForKey:LOCAL_INFLITRATION_KEY];
	 if (!localInflitration) {
		 localInflitration = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 localInflitration.key = LOCAL_INFLITRATION_KEY;
		 [_section addElementsObject:localInflitration];
	 }

	 localInflitration.value = [NSNumber numberWithBool:self.localInflitrationBBCheckBox.isSelected];
	 
	 BooleanFormElement *paresthesiaNone = (BooleanFormElement*)[_section getElementForKey:PARESTHESIA_NONE_KEY];
	 if (!paresthesiaNone) {
		 paresthesiaNone = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 paresthesiaNone.key = PARESTHESIA_NONE_KEY;
		 [_section addElementsObject:paresthesiaNone];
	 }

	 paresthesiaNone.value = [NSNumber numberWithBool:self.paresthesiaNoneBBCheckBox.isSelected];
	 
	 BooleanFormElement *paresthesiaOther = (BooleanFormElement*)[_section getElementForKey:PARESTHESIA_OTHER_KEY];
	 if (!paresthesiaOther) {
		 paresthesiaOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 paresthesiaOther.key = PARESTHESIA_OTHER_KEY;
		 [_section addElementsObject:paresthesiaOther];
	 }

	 paresthesiaOther.value = [NSNumber numberWithBool:self.paresthesiaOtherBBCheckBox.isSelected];
	 
	 TextElement *paresthesiaOtherReason = (TextElement*)[_section getElementForKey:PARESTHESIA_OTHER_REASON_KEY];
	 if (!paresthesiaOtherReason) {
		 paresthesiaOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 paresthesiaOtherReason.key = PARESTHESIA_OTHER_REASON_KEY;
		 [_section addElementsObject:paresthesiaOtherReason];
	 }

	 paresthesiaOtherReason.value = self.paresthesiaOtherReasonUITextField.text;
	 
	 TextElement *spiNeedleGrams = (TextElement*)[_section getElementForKey:SPI_NEEDLE_GRAMS_KEY];
	 if (!spiNeedleGrams) {
		 spiNeedleGrams = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 spiNeedleGrams.key = SPI_NEEDLE_GRAMS_KEY;
		 [_section addElementsObject:spiNeedleGrams];
	 }

	 spiNeedleGrams.value = self.spiNeedleGramsUITextField.text;
	 
	 BooleanFormElement *pencilPoint = (BooleanFormElement*)[_section getElementForKey:PENCIL_POINT_KEY];
	 if (!pencilPoint) {
		 pencilPoint = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pencilPoint.key = PENCIL_POINT_KEY;
		 [_section addElementsObject:pencilPoint];
	 }

	 pencilPoint.value = [NSNumber numberWithBool:self.pencilPointBBCheckBox.isSelected];
	 
	 BooleanFormElement *spiNeedleOther = (BooleanFormElement*)[_section getElementForKey:SPI_NEEDLE_OTHER_KEY];
	 if (!spiNeedleOther) {
		 spiNeedleOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 spiNeedleOther.key = SPI_NEEDLE_OTHER_KEY;
		 [_section addElementsObject:spiNeedleOther];
	 }

	 spiNeedleOther.value = [NSNumber numberWithBool:self.spiNeedleOtherBBCheckBox.isSelected];
	 
	 TextElement *spiNeedleOtherReason = (TextElement*)[_section getElementForKey:SPI_NEEDLE_OTHER_REASON_KEY];
	 if (!spiNeedleOtherReason) {
		 spiNeedleOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 spiNeedleOtherReason.key = SPI_NEEDLE_OTHER_REASON_KEY;
		 [_section addElementsObject:spiNeedleOtherReason];
	 }

	 spiNeedleOtherReason.value = self.spiNeedleOtherReasonUITextField.text;
	 
	 TextElement *nrAttempts = (TextElement*)[_section getElementForKey:NR_ATTEMPTS_KEY];
	 if (!nrAttempts) {
		 nrAttempts = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 nrAttempts.key = NR_ATTEMPTS_KEY;
		 [_section addElementsObject:nrAttempts];
	 }

	 nrAttempts.value = self.nrAttemptsUITextField.text;
	 
	 BooleanFormElement *bupivacaine = (BooleanFormElement*)[_section getElementForKey:BUPIVACAINE_KEY];
	 if (!bupivacaine) {
		 bupivacaine = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 bupivacaine.key = BUPIVACAINE_KEY;
		 [_section addElementsObject:bupivacaine];
	 }

	 bupivacaine.value = [NSNumber numberWithBool:self.bupivacaineBBCheckBox.isSelected];
	 
	 TextElement *bupivacaineMl = (TextElement*)[_section getElementForKey:BUPIVACAINE_ML_KEY];
	 if (!bupivacaineMl) {
		 bupivacaineMl = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 bupivacaineMl.key = BUPIVACAINE_ML_KEY;
		 [_section addElementsObject:bupivacaineMl];
	 }

	 bupivacaineMl.value = self.bupivacaineMlUITextField.text;
	 
	 BooleanFormElement *medOther = (BooleanFormElement*)[_section getElementForKey:MED_OTHER_KEY];
	 if (!medOther) {
		 medOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 medOther.key = MED_OTHER_KEY;
		 [_section addElementsObject:medOther];
	 }

	 medOther.value = [NSNumber numberWithBool:self.medOtherBBCheckBox.isSelected];
	 
	 TextElement *medOtherReason = (TextElement*)[_section getElementForKey:MED_OTHER_REASON_KEY];
	 if (!medOtherReason) {
		 medOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 medOtherReason.key = MED_OTHER_REASON_KEY;
		 [_section addElementsObject:medOtherReason];
	 }

	 medOtherReason.value = self.medOtherReasonUITextField.text;
	 
	 TextElement *fentanyl = (TextElement*)[_section getElementForKey:FENTANYL_KEY];
	 if (!fentanyl) {
		 fentanyl = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 fentanyl.key = FENTANYL_KEY;
		 [_section addElementsObject:fentanyl];
	 }

	 fentanyl.value = self.fentanylUITextField.text;
	 
	 TextElement *duramorph = (TextElement*)[_section getElementForKey:DURAMORPH_KEY];
	 if (!duramorph) {
		 duramorph = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 duramorph.key = DURAMORPH_KEY;
		 [_section addElementsObject:duramorph];
	 }

	 duramorph.value = self.duramorphUITextField.text;
	 
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
	 return SPINAL_ANESTHESIA_SECTION_TITLE;
}
@end