
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
@end

@implementation InductionAndDeviceViewController
NSString *const INDUCTION_AND_DEVICE_SECTION_TITLE = @"InductionAndDeviceSectionKey";
NSString *const IV_KEY = @"IvKey";
NSString *const IM_KEY = @"ImKey";
NSString *const INHALATION_KEY = @"InhalationKey";
NSString *const PREO2_KEY = @"PreO2Key";
NSString *const RAPID_SEQUENCE_KEY = @"RapidSequenceKey";

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