
#import "EndotrachealTubeViewController.h"
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


@interface EndotrachealTubeViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *endoTrachealTubeSizeUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *oralBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cuftUpToSealBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nasalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *trachBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *eTCO2IncreaseBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *bronchBlockerBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *bsbeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *isolationCheckBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *doubleLumenEttBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *securedAtCmUITextField;
@property (weak, nonatomic) IBOutlet UITextField *doubleLumenSizeUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *doubleLumenLeftBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *doubleLumenRightBBCheckBox;
@end

@implementation EndotrachealTubeViewController
NSString *const ENDOTRACHEAL_TUBE_SECTION_TITLE = @"EndotrachealTubeSectionKey";
static NSString *const ENDO_TRACHEAL_TUBE_SIZE_KEY = @"EndoTrachealTubeSizeKey";
static NSString *const ORAL_KEY = @"OralKey";
static NSString *const CUFT_UP_TO_SEAL_KEY = @"CuftUpToSealKey";
static NSString *const NASAL_KEY = @"NasalKey";
static NSString *const TRACH_KEY = @"TrachKey";
static NSString *const ETCO2Increase_KEY = @"ETCO2IncreaseKey";
static NSString *const BRONCH_BLOCKER_KEY = @"BronchBlockerKey";
static NSString *const BSBE_KEY = @"BsbeKey";
static NSString *const ISOLATION_CHECK_KEY = @"IsolationCheckKey";
static NSString *const DOUBLE_LUMEN_ETT_KEY = @"DoubleLumenEttKey";
static NSString *const SECURED_AT_CM_KEY = @"SecuredAtCmKey";
static NSString *const DOUBLE_LUMEN_SIZE_KEY = @"DoubleLumenSizeKey";
static NSString *const DOUBLE_LUMEN_LEFT_KEY = @"DoubleLumenLeftKey";
static NSString *const DOUBLE_LUMEN_RIGHT_KEY = @"DoubleLumenRightKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:ENDO_TRACHEAL_TUBE_SIZE_KEY]){
				 [self.endoTrachealTubeSizeUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:ORAL_KEY]){
				 [self.oralBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CUFT_UP_TO_SEAL_KEY]){
				 [self.cuftUpToSealBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NASAL_KEY]){
				 [self.nasalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:TRACH_KEY]){
				 [self.trachBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ETCO2Increase_KEY]){
				 [self.eTCO2IncreaseBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:BRONCH_BLOCKER_KEY]){
				 [self.bronchBlockerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:BSBE_KEY]){
				 [self.bsbeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ISOLATION_CHECK_KEY]){
				 [self.isolationCheckBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DOUBLE_LUMEN_ETT_KEY]){
				 [self.doubleLumenEttBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SECURED_AT_CM_KEY]){
				 [self.securedAtCmUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:DOUBLE_LUMEN_SIZE_KEY]){
				 [self.doubleLumenSizeUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:DOUBLE_LUMEN_LEFT_KEY]){
				 [self.doubleLumenLeftBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DOUBLE_LUMEN_RIGHT_KEY]){
				 [self.doubleLumenRightBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:ENDO_TRACHEAL_TUBE_SIZE_KEY]!= nil, @"EndoTrachealTubeSize is nil");
	 NSAssert([section getElementForKey:ORAL_KEY]!= nil, @"Oral is nil");
	 NSAssert([section getElementForKey:CUFT_UP_TO_SEAL_KEY]!= nil, @"CuftUpToSeal is nil");
	 NSAssert([section getElementForKey:NASAL_KEY]!= nil, @"Nasal is nil");
	 NSAssert([section getElementForKey:TRACH_KEY]!= nil, @"Trach is nil");
	 NSAssert([section getElementForKey:ETCO2Increase_KEY]!= nil, @"ETCO2Increase is nil");
	 NSAssert([section getElementForKey:BRONCH_BLOCKER_KEY]!= nil, @"BronchBlocker is nil");
	 NSAssert([section getElementForKey:BSBE_KEY]!= nil, @"Bsbe is nil");
	 NSAssert([section getElementForKey:ISOLATION_CHECK_KEY]!= nil, @"IsolationCheck is nil");
	 NSAssert([section getElementForKey:DOUBLE_LUMEN_ETT_KEY]!= nil, @"DoubleLumenEtt is nil");
	 NSAssert([section getElementForKey:SECURED_AT_CM_KEY]!= nil, @"SecuredAtCm is nil");
	 NSAssert([section getElementForKey:DOUBLE_LUMEN_SIZE_KEY]!= nil, @"DoubleLumenSize is nil");
	 NSAssert([section getElementForKey:DOUBLE_LUMEN_LEFT_KEY]!= nil, @"DoubleLumenLeft is nil");
	 NSAssert([section getElementForKey:DOUBLE_LUMEN_RIGHT_KEY]!= nil, @"DoubleLumenRight is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = ENDOTRACHEAL_TUBE_SECTION_TITLE;
	 }
	 
	 TextElement *endoTrachealTubeSize = (TextElement*)[_section getElementForKey:ENDO_TRACHEAL_TUBE_SIZE_KEY];
	 if (!endoTrachealTubeSize) {
		 endoTrachealTubeSize = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 endoTrachealTubeSize.key = ENDO_TRACHEAL_TUBE_SIZE_KEY;
		 [_section addElementsObject:endoTrachealTubeSize];
	 }

	 endoTrachealTubeSize.value = self.endoTrachealTubeSizeUITextField.text;
	 
	 BooleanFormElement *oral = (BooleanFormElement*)[_section getElementForKey:ORAL_KEY];
	 if (!oral) {
		 oral = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 oral.key = ORAL_KEY;
		 [_section addElementsObject:oral];
	 }

	 oral.value = [NSNumber numberWithBool:self.oralBBCheckBox.isSelected];
	 
	 BooleanFormElement *cuftUpToSeal = (BooleanFormElement*)[_section getElementForKey:CUFT_UP_TO_SEAL_KEY];
	 if (!cuftUpToSeal) {
		 cuftUpToSeal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cuftUpToSeal.key = CUFT_UP_TO_SEAL_KEY;
		 [_section addElementsObject:cuftUpToSeal];
	 }

	 cuftUpToSeal.value = [NSNumber numberWithBool:self.cuftUpToSealBBCheckBox.isSelected];
	 
	 BooleanFormElement *nasal = (BooleanFormElement*)[_section getElementForKey:NASAL_KEY];
	 if (!nasal) {
		 nasal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nasal.key = NASAL_KEY;
		 [_section addElementsObject:nasal];
	 }

	 nasal.value = [NSNumber numberWithBool:self.nasalBBCheckBox.isSelected];
	 
	 BooleanFormElement *trach = (BooleanFormElement*)[_section getElementForKey:TRACH_KEY];
	 if (!trach) {
		 trach = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 trach.key = TRACH_KEY;
		 [_section addElementsObject:trach];
	 }

	 trach.value = [NSNumber numberWithBool:self.trachBBCheckBox.isSelected];
	 
	 BooleanFormElement *eTCO2Increase = (BooleanFormElement*)[_section getElementForKey:ETCO2Increase_KEY];
	 if (!eTCO2Increase) {
		 eTCO2Increase = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 eTCO2Increase.key = ETCO2Increase_KEY;
		 [_section addElementsObject:eTCO2Increase];
	 }

	 eTCO2Increase.value = [NSNumber numberWithBool:self.eTCO2IncreaseBBCheckBox.isSelected];
	 
	 BooleanFormElement *bronchBlocker = (BooleanFormElement*)[_section getElementForKey:BRONCH_BLOCKER_KEY];
	 if (!bronchBlocker) {
		 bronchBlocker = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 bronchBlocker.key = BRONCH_BLOCKER_KEY;
		 [_section addElementsObject:bronchBlocker];
	 }

	 bronchBlocker.value = [NSNumber numberWithBool:self.bronchBlockerBBCheckBox.isSelected];
	 
	 BooleanFormElement *bsbe = (BooleanFormElement*)[_section getElementForKey:BSBE_KEY];
	 if (!bsbe) {
		 bsbe = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 bsbe.key = BSBE_KEY;
		 [_section addElementsObject:bsbe];
	 }

	 bsbe.value = [NSNumber numberWithBool:self.bsbeBBCheckBox.isSelected];
	 
	 BooleanFormElement *isolationCheck = (BooleanFormElement*)[_section getElementForKey:ISOLATION_CHECK_KEY];
	 if (!isolationCheck) {
		 isolationCheck = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 isolationCheck.key = ISOLATION_CHECK_KEY;
		 [_section addElementsObject:isolationCheck];
	 }

	 isolationCheck.value = [NSNumber numberWithBool:self.isolationCheckBBCheckBox.isSelected];
	 
	 BooleanFormElement *doubleLumenEtt = (BooleanFormElement*)[_section getElementForKey:DOUBLE_LUMEN_ETT_KEY];
	 if (!doubleLumenEtt) {
		 doubleLumenEtt = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 doubleLumenEtt.key = DOUBLE_LUMEN_ETT_KEY;
		 [_section addElementsObject:doubleLumenEtt];
	 }

	 doubleLumenEtt.value = [NSNumber numberWithBool:self.doubleLumenEttBBCheckBox.isSelected];
	 
	 TextElement *securedAtCm = (TextElement*)[_section getElementForKey:SECURED_AT_CM_KEY];
	 if (!securedAtCm) {
		 securedAtCm = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 securedAtCm.key = SECURED_AT_CM_KEY;
		 [_section addElementsObject:securedAtCm];
	 }

	 securedAtCm.value = self.securedAtCmUITextField.text;
	 
	 TextElement *doubleLumenSize = (TextElement*)[_section getElementForKey:DOUBLE_LUMEN_SIZE_KEY];
	 if (!doubleLumenSize) {
		 doubleLumenSize = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 doubleLumenSize.key = DOUBLE_LUMEN_SIZE_KEY;
		 [_section addElementsObject:doubleLumenSize];
	 }

	 doubleLumenSize.value = self.doubleLumenSizeUITextField.text;
	 
	 BooleanFormElement *doubleLumenLeft = (BooleanFormElement*)[_section getElementForKey:DOUBLE_LUMEN_LEFT_KEY];
	 if (!doubleLumenLeft) {
		 doubleLumenLeft = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 doubleLumenLeft.key = DOUBLE_LUMEN_LEFT_KEY;
		 [_section addElementsObject:doubleLumenLeft];
	 }

	 doubleLumenLeft.value = [NSNumber numberWithBool:self.doubleLumenLeftBBCheckBox.isSelected];
	 
	 BooleanFormElement *doubleLumenRight = (BooleanFormElement*)[_section getElementForKey:DOUBLE_LUMEN_RIGHT_KEY];
	 if (!doubleLumenRight) {
		 doubleLumenRight = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 doubleLumenRight.key = DOUBLE_LUMEN_RIGHT_KEY;
		 [_section addElementsObject:doubleLumenRight];
	 }

	 doubleLumenRight.value = [NSNumber numberWithBool:self.doubleLumenRightBBCheckBox.isSelected];
	 
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
	 return ENDOTRACHEAL_TUBE_SECTION_TITLE;
}
@end