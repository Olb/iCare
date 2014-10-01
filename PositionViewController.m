
#import "PositionViewController.h"
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


@interface PositionViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *tapedShutBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *lubricatedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *shieldBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *headNeckNeutralBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *axillaryRollBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *pressurePointsProtectedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *armsElbowsOnPaddedArmBoardBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *armsElbowsOnPaddedArmBoardUpBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *armsElbowsOnPaddedArmBoardDownBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *armsTuckedNeutralPositionBBCheckBox;
@end

@implementation PositionViewController
NSString *const POSITION_SECTION_TITLE = @"PositionSectionKey";
static NSString *const TAPED_SHUT_KEY = @"TapedShutKey";
static NSString *const LUBRICATED_KEY = @"LubricatedKey";
static NSString *const SHIELD_KEY = @"ShieldKey";
static NSString *const HEAD_NECK_NEUTRAL_KEY = @"HeadNeckNeutralKey";
static NSString *const AXILLARY_ROLL_KEY = @"AxillaryRollKey";
static NSString *const PRESSURE_POINTS_PROTECTED_KEY = @"PressurePointsProtectedKey";
static NSString *const ARMS_ELBOWS_ON_PADDED_ARM_BOARD_KEY = @"ArmsElbowsOnPaddedArmBoardKey";
static NSString *const ARMS_ELBOWS_ON_PADDED_ARM_BOARD_UP_KEY = @"ArmsElbowsOnPaddedArmBoardUpKey";
static NSString *const ARMS_ELBOWS_ON_PADDED_ARM_BOARD_DOWN_KEY = @"ArmsElbowsOnPaddedArmBoardDownKey";
static NSString *const ARMS_TUCKED_NEUTRAL_POSITION_KEY = @"ArmsTuckedNeutralPositionKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:TAPED_SHUT_KEY]){
				 [self.tapedShutBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LUBRICATED_KEY]){
				 [self.lubricatedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SHIELD_KEY]){
				 [self.shieldBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HEAD_NECK_NEUTRAL_KEY]){
				 [self.headNeckNeutralBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:AXILLARY_ROLL_KEY]){
				 [self.axillaryRollBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PRESSURE_POINTS_PROTECTED_KEY]){
				 [self.pressurePointsProtectedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_KEY]){
				 [self.armsElbowsOnPaddedArmBoardBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_UP_KEY]){
				 [self.armsElbowsOnPaddedArmBoardUpBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_DOWN_KEY]){
				 [self.armsElbowsOnPaddedArmBoardDownBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ARMS_TUCKED_NEUTRAL_POSITION_KEY]){
				 [self.armsTuckedNeutralPositionBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:TAPED_SHUT_KEY]!= nil, @"TapedShut is nil");
	 NSAssert([section getElementForKey:LUBRICATED_KEY]!= nil, @"Lubricated is nil");
	 NSAssert([section getElementForKey:SHIELD_KEY]!= nil, @"Shield is nil");
	 NSAssert([section getElementForKey:HEAD_NECK_NEUTRAL_KEY]!= nil, @"HeadNeckNeutral is nil");
	 NSAssert([section getElementForKey:AXILLARY_ROLL_KEY]!= nil, @"AxillaryRoll is nil");
	 NSAssert([section getElementForKey:PRESSURE_POINTS_PROTECTED_KEY]!= nil, @"PressurePointsProtected is nil");
	 NSAssert([section getElementForKey:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_KEY]!= nil, @"ArmsElbowsOnPaddedArmBoard is nil");
	 NSAssert([section getElementForKey:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_UP_KEY]!= nil, @"ArmsElbowsOnPaddedArmBoardUp is nil");
	 NSAssert([section getElementForKey:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_DOWN_KEY]!= nil, @"ArmsElbowsOnPaddedArmBoardDown is nil");
	 NSAssert([section getElementForKey:ARMS_TUCKED_NEUTRAL_POSITION_KEY]!= nil, @"ArmsTuckedNeutralPosition is nil");
	 
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
		 self.section.title = POSITION_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *tapedShut = (BooleanFormElement*)[_section getElementForKey:TAPED_SHUT_KEY];
	 if (!tapedShut) {
		 tapedShut = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 tapedShut.key = TAPED_SHUT_KEY;
		 [_section addElementsObject:tapedShut];
	 }

	 tapedShut.value = [NSNumber numberWithBool:self.tapedShutBBCheckBox.isSelected];
	 
	 BooleanFormElement *lubricated = (BooleanFormElement*)[_section getElementForKey:LUBRICATED_KEY];
	 if (!lubricated) {
		 lubricated = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 lubricated.key = LUBRICATED_KEY;
		 [_section addElementsObject:lubricated];
	 }

	 lubricated.value = [NSNumber numberWithBool:self.lubricatedBBCheckBox.isSelected];
	 
	 BooleanFormElement *shield = (BooleanFormElement*)[_section getElementForKey:SHIELD_KEY];
	 if (!shield) {
		 shield = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 shield.key = SHIELD_KEY;
		 [_section addElementsObject:shield];
	 }

	 shield.value = [NSNumber numberWithBool:self.shieldBBCheckBox.isSelected];
	 
	 BooleanFormElement *headNeckNeutral = (BooleanFormElement*)[_section getElementForKey:HEAD_NECK_NEUTRAL_KEY];
	 if (!headNeckNeutral) {
		 headNeckNeutral = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 headNeckNeutral.key = HEAD_NECK_NEUTRAL_KEY;
		 [_section addElementsObject:headNeckNeutral];
	 }

	 headNeckNeutral.value = [NSNumber numberWithBool:self.headNeckNeutralBBCheckBox.isSelected];
	 
	 BooleanFormElement *axillaryRoll = (BooleanFormElement*)[_section getElementForKey:AXILLARY_ROLL_KEY];
	 if (!axillaryRoll) {
		 axillaryRoll = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 axillaryRoll.key = AXILLARY_ROLL_KEY;
		 [_section addElementsObject:axillaryRoll];
	 }

	 axillaryRoll.value = [NSNumber numberWithBool:self.axillaryRollBBCheckBox.isSelected];
	 
	 BooleanFormElement *pressurePointsProtected = (BooleanFormElement*)[_section getElementForKey:PRESSURE_POINTS_PROTECTED_KEY];
	 if (!pressurePointsProtected) {
		 pressurePointsProtected = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pressurePointsProtected.key = PRESSURE_POINTS_PROTECTED_KEY;
		 [_section addElementsObject:pressurePointsProtected];
	 }

	 pressurePointsProtected.value = [NSNumber numberWithBool:self.pressurePointsProtectedBBCheckBox.isSelected];
	 
	 BooleanFormElement *armsElbowsOnPaddedArmBoard = (BooleanFormElement*)[_section getElementForKey:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_KEY];
	 if (!armsElbowsOnPaddedArmBoard) {
		 armsElbowsOnPaddedArmBoard = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 armsElbowsOnPaddedArmBoard.key = ARMS_ELBOWS_ON_PADDED_ARM_BOARD_KEY;
		 [_section addElementsObject:armsElbowsOnPaddedArmBoard];
	 }

	 armsElbowsOnPaddedArmBoard.value = [NSNumber numberWithBool:self.armsElbowsOnPaddedArmBoardBBCheckBox.isSelected];
	 
	 BooleanFormElement *armsElbowsOnPaddedArmBoardUp = (BooleanFormElement*)[_section getElementForKey:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_UP_KEY];
	 if (!armsElbowsOnPaddedArmBoardUp) {
		 armsElbowsOnPaddedArmBoardUp = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 armsElbowsOnPaddedArmBoardUp.key = ARMS_ELBOWS_ON_PADDED_ARM_BOARD_UP_KEY;
		 [_section addElementsObject:armsElbowsOnPaddedArmBoardUp];
	 }

	 armsElbowsOnPaddedArmBoardUp.value = [NSNumber numberWithBool:self.armsElbowsOnPaddedArmBoardUpBBCheckBox.isSelected];
	 
	 BooleanFormElement *armsElbowsOnPaddedArmBoardDown = (BooleanFormElement*)[_section getElementForKey:ARMS_ELBOWS_ON_PADDED_ARM_BOARD_DOWN_KEY];
	 if (!armsElbowsOnPaddedArmBoardDown) {
		 armsElbowsOnPaddedArmBoardDown = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 armsElbowsOnPaddedArmBoardDown.key = ARMS_ELBOWS_ON_PADDED_ARM_BOARD_DOWN_KEY;
		 [_section addElementsObject:armsElbowsOnPaddedArmBoardDown];
	 }

	 armsElbowsOnPaddedArmBoardDown.value = [NSNumber numberWithBool:self.armsElbowsOnPaddedArmBoardDownBBCheckBox.isSelected];
	 
	 BooleanFormElement *armsTuckedNeutralPosition = (BooleanFormElement*)[_section getElementForKey:ARMS_TUCKED_NEUTRAL_POSITION_KEY];
	 if (!armsTuckedNeutralPosition) {
		 armsTuckedNeutralPosition = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 armsTuckedNeutralPosition.key = ARMS_TUCKED_NEUTRAL_POSITION_KEY;
		 [_section addElementsObject:armsTuckedNeutralPosition];
	 }

	 armsTuckedNeutralPosition.value = [NSNumber numberWithBool:self.armsTuckedNeutralPositionBBCheckBox.isSelected];
	 
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
	 return POSITION_SECTION_TITLE;
}
@end