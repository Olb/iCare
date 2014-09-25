
#import "PhysicalExamViewController.h"
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


@interface PhysicalExamViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *heartRegularBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *heartOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *heartOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *lungsClearBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *lungsOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *lungsOtherReasonUITextField;
@end

@implementation PhysicalExamViewController
NSString *const PHYSICAL_EXAM_SECTION_TITLE = @"PhysicalExamSectionKey";
static NSString *const HEART_REGULAR_KEY = @"HeartRegularKey";
static NSString *const HEART_OTHER_KEY = @"HeartOtherKey";
static NSString *const HEART_OTHER_REASON_KEY = @"HeartOtherReasonKey";
static NSString *const LUNGS_CLEAR_KEY = @"LungsClearKey";
static NSString *const LUNGS_OTHER_KEY = @"LungsOtherKey";
static NSString *const LUNGS_OTHER_REASON_KEY = @"LungsOtherReasonKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:HEART_REGULAR_KEY]){
				 [self.heartRegularBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HEART_OTHER_KEY]){
				 [self.heartOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HEART_OTHER_REASON_KEY]){
				 [self.heartOtherReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:LUNGS_CLEAR_KEY]){
				 [self.lungsClearBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LUNGS_OTHER_KEY]){
				 [self.lungsOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LUNGS_OTHER_REASON_KEY]){
				 [self.lungsOtherReasonUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:HEART_REGULAR_KEY]!= nil, @"HeartRegular is nil");
	 NSAssert([section getElementForKey:HEART_OTHER_KEY]!= nil, @"HeartOther is nil");
	 NSAssert([section getElementForKey:HEART_OTHER_REASON_KEY]!= nil, @"HeartOtherReason is nil");
	 NSAssert([section getElementForKey:LUNGS_CLEAR_KEY]!= nil, @"LungsClear is nil");
	 NSAssert([section getElementForKey:LUNGS_OTHER_KEY]!= nil, @"LungsOther is nil");
	 NSAssert([section getElementForKey:LUNGS_OTHER_REASON_KEY]!= nil, @"LungsOtherReason is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PHYSICAL_EXAM_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *heartRegular = (BooleanFormElement*)[_section getElementForKey:HEART_REGULAR_KEY];
	 if (!heartRegular) {
		 heartRegular = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 heartRegular.key = HEART_REGULAR_KEY;
		 [_section addElementsObject:heartRegular];
	 }

	 heartRegular.value = [NSNumber numberWithBool:self.heartRegularBBCheckBox.isSelected];
	 
	 BooleanFormElement *heartOther = (BooleanFormElement*)[_section getElementForKey:HEART_OTHER_KEY];
	 if (!heartOther) {
		 heartOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 heartOther.key = HEART_OTHER_KEY;
		 [_section addElementsObject:heartOther];
	 }

	 heartOther.value = [NSNumber numberWithBool:self.heartOtherBBCheckBox.isSelected];
	 
	 TextElement *heartOtherReason = (TextElement*)[_section getElementForKey:HEART_OTHER_REASON_KEY];
	 if (!heartOtherReason) {
		 heartOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 heartOtherReason.key = HEART_OTHER_REASON_KEY;
		 [_section addElementsObject:heartOtherReason];
	 }

	 heartOtherReason.value = self.heartOtherReasonUITextField.text;
	 
	 BooleanFormElement *lungsClear = (BooleanFormElement*)[_section getElementForKey:LUNGS_CLEAR_KEY];
	 if (!lungsClear) {
		 lungsClear = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 lungsClear.key = LUNGS_CLEAR_KEY;
		 [_section addElementsObject:lungsClear];
	 }

	 lungsClear.value = [NSNumber numberWithBool:self.lungsClearBBCheckBox.isSelected];
	 
	 BooleanFormElement *lungsOther = (BooleanFormElement*)[_section getElementForKey:LUNGS_OTHER_KEY];
	 if (!lungsOther) {
		 lungsOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 lungsOther.key = LUNGS_OTHER_KEY;
		 [_section addElementsObject:lungsOther];
	 }

	 lungsOther.value = [NSNumber numberWithBool:self.lungsOtherBBCheckBox.isSelected];
	 
	 TextElement *lungsOtherReason = (TextElement*)[_section getElementForKey:LUNGS_OTHER_REASON_KEY];
	 if (!lungsOtherReason) {
		 lungsOtherReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 lungsOtherReason.key = LUNGS_OTHER_REASON_KEY;
		 [_section addElementsObject:lungsOtherReason];
	 }

	 lungsOtherReason.value = self.lungsOtherReasonUITextField.text;
	 
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
	 return PHYSICAL_EXAM_SECTION_TITLE;
}
@end