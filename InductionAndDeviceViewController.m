
#import "InductionAndDeviceViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface InductionAndDeviceViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *ivBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *imBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *inhalationBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *preO2BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *rapidSequenceBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *oralAirwayBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *lMABBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nasalAirwayBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *maskBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *sizeUITextField;
@end

@implementation InductionAndDeviceViewController
NSString *const INDUCTION_AND_DEVICE_SECTION_TITLE = @"InductionAndDeviceSectionKey";
static NSString *const IV_KEY = @"IvKey";
static NSString *const IM_KEY = @"ImKey";
static NSString *const INHALATION_KEY = @"InhalationKey";
static NSString *const PREO2_KEY = @"PreO2Key";
static NSString *const RAPID_SEQUENCE_KEY = @"RapidSequenceKey";
static NSString *const ORAL_AIRWAY_KEY = @"OralAirwayKey";
static NSString *const LMA_KEY = @"LMAKey";
static NSString *const NASAL_AIRWAY_KEY = @"NasalAirwayKey";
static NSString *const MASK_KEY = @"MaskKey";
static NSString *const SIZE_KEY = @"SizeKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:IV_KEY]){
				 [self.ivBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:IM_KEY]){
				 [self.imBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INHALATION_KEY]){
				 [self.inhalationBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PREO2_KEY]){
				 [self.preO2BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RAPID_SEQUENCE_KEY]){
				 [self.rapidSequenceBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ORAL_AIRWAY_KEY]){
				 [self.oralAirwayBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LMA_KEY]){
				 [self.lMABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NASAL_AIRWAY_KEY]){
				 [self.nasalAirwayBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MASK_KEY]){
				 [self.maskBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SIZE_KEY]){
				 [self.sizeUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:IV_KEY]!= nil, @"Iv is nil");
	 NSAssert([section getElementForKey:IM_KEY]!= nil, @"Im is nil");
	 NSAssert([section getElementForKey:INHALATION_KEY]!= nil, @"Inhalation is nil");
	 NSAssert([section getElementForKey:PREO2_KEY]!= nil, @"PreO2 is nil");
	 NSAssert([section getElementForKey:RAPID_SEQUENCE_KEY]!= nil, @"RapidSequence is nil");
	 NSAssert([section getElementForKey:ORAL_AIRWAY_KEY]!= nil, @"OralAirway is nil");
	 NSAssert([section getElementForKey:LMA_KEY]!= nil, @"LMA is nil");
	 NSAssert([section getElementForKey:NASAL_AIRWAY_KEY]!= nil, @"NasalAirway is nil");
	 NSAssert([section getElementForKey:MASK_KEY]!= nil, @"Mask is nil");
	 NSAssert([section getElementForKey:SIZE_KEY]!= nil, @"Size is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = INDUCTION_AND_DEVICE_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *iv = (BooleanFormElement*)[_section getElementForKey:IV_KEY];
	 if (!iv) {
		 iv = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 iv.key = IV_KEY;
		 [_section addElementsObject:iv];
	 }

	 iv.value = [NSNumber numberWithBool:self.ivBBCheckBox.isSelected];
	 
	 BooleanFormElement *im = (BooleanFormElement*)[_section getElementForKey:IM_KEY];
	 if (!im) {
		 im = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 im.key = IM_KEY;
		 [_section addElementsObject:im];
	 }

	 im.value = [NSNumber numberWithBool:self.imBBCheckBox.isSelected];
	 
	 BooleanFormElement *inhalation = (BooleanFormElement*)[_section getElementForKey:INHALATION_KEY];
	 if (!inhalation) {
		 inhalation = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 inhalation.key = INHALATION_KEY;
		 [_section addElementsObject:inhalation];
	 }

	 inhalation.value = [NSNumber numberWithBool:self.inhalationBBCheckBox.isSelected];
	 
	 BooleanFormElement *preO2 = (BooleanFormElement*)[_section getElementForKey:PREO2_KEY];
	 if (!preO2) {
		 preO2 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 preO2.key = PREO2_KEY;
		 [_section addElementsObject:preO2];
	 }

	 preO2.value = [NSNumber numberWithBool:self.preO2BBCheckBox.isSelected];
	 
	 BooleanFormElement *rapidSequence = (BooleanFormElement*)[_section getElementForKey:RAPID_SEQUENCE_KEY];
	 if (!rapidSequence) {
		 rapidSequence = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 rapidSequence.key = RAPID_SEQUENCE_KEY;
		 [_section addElementsObject:rapidSequence];
	 }

	 rapidSequence.value = [NSNumber numberWithBool:self.rapidSequenceBBCheckBox.isSelected];
	 
	 BooleanFormElement *oralAirway = (BooleanFormElement*)[_section getElementForKey:ORAL_AIRWAY_KEY];
	 if (!oralAirway) {
		 oralAirway = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 oralAirway.key = ORAL_AIRWAY_KEY;
		 [_section addElementsObject:oralAirway];
	 }

	 oralAirway.value = [NSNumber numberWithBool:self.oralAirwayBBCheckBox.isSelected];
	 
	 BooleanFormElement *lMA = (BooleanFormElement*)[_section getElementForKey:LMA_KEY];
	 if (!lMA) {
		 lMA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 lMA.key = LMA_KEY;
		 [_section addElementsObject:lMA];
	 }

	 lMA.value = [NSNumber numberWithBool:self.lMABBCheckBox.isSelected];
	 
	 BooleanFormElement *nasalAirway = (BooleanFormElement*)[_section getElementForKey:NASAL_AIRWAY_KEY];
	 if (!nasalAirway) {
		 nasalAirway = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nasalAirway.key = NASAL_AIRWAY_KEY;
		 [_section addElementsObject:nasalAirway];
	 }

	 nasalAirway.value = [NSNumber numberWithBool:self.nasalAirwayBBCheckBox.isSelected];
	 
	 BooleanFormElement *mask = (BooleanFormElement*)[_section getElementForKey:MASK_KEY];
	 if (!mask) {
		 mask = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 mask.key = MASK_KEY;
		 [_section addElementsObject:mask];
	 }

	 mask.value = [NSNumber numberWithBool:self.maskBBCheckBox.isSelected];
	 
	 TextElement *size = (TextElement*)[_section getElementForKey:SIZE_KEY];
	 if (!size) {
		 size = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 size.key = SIZE_KEY;
		 [_section addElementsObject:size];
	 }

	 size.value = self.sizeUITextField.text;
	 
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
	 return INDUCTION_AND_DEVICE_SECTION_TITLE;
}
@end