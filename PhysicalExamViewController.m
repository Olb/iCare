/*This file is generated by perlxml.pl. DO NOT MODIFY */

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

#import "BBData.h"

#import "BBAutoCompleteTextField.h"


@interface PhysicalExamViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *heartRegularBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *heartOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *heartOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *lungsClearBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *lungsOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *lungsOtherReasonUITextField;
@property (weak, nonatomic) IBOutlet UITextView *notesUITextView;
@end

@implementation PhysicalExamViewController
NSString *const PHYSICAL_EXAM_SECTION_TITLE = @"PhysicalExamSectionKey";
static NSString *const HEART_REGULAR_KEY = @"HeartRegularKey";
static NSString *const HEART_OTHER_KEY = @"HeartOtherKey";
static NSString *const HEART_OTHER_REASON_KEY = @"HeartOtherReasonKey";
static NSString *const LUNGS_CLEAR_KEY = @"LungsClearKey";
static NSString *const LUNGS_OTHER_KEY = @"LungsOtherKey";
static NSString *const LUNGS_OTHER_REASON_KEY = @"LungsOtherReasonKey";
static NSString *const NOTES_KEY = @"NotesKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 [self.heartRegularBBCheckBox addTarget:self action:@selector(radioGroup1:) forControlEvents:UIControlEventTouchUpInside];
	 [self.heartOtherBBCheckBox addTarget:self action:@selector(radioGroup1:) forControlEvents:UIControlEventTouchUpInside];
	 [self.lungsClearBBCheckBox addTarget:self action:@selector(radioGroup2:) forControlEvents:UIControlEventTouchUpInside];
	 [self.lungsOtherBBCheckBox addTarget:self action:@selector(radioGroup2:) forControlEvents:UIControlEventTouchUpInside];
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
			 if ([element.key isEqualToString:NOTES_KEY]){
				 [self.notesUITextView setText:((TextElement*)element).value];
			 }
		 }
	 }
}


-(void)addDatePicker: (UITextField*)textField withSelector: (SEL)selector {
	 UIDatePicker *datePicker = [[UIDatePicker alloc] init];
	 datePicker.datePickerMode = UIDatePickerModeDate;
	 [textField setInputView:datePicker];
	 UIToolbar *myToolbar = [[UIToolbar alloc] initWithFrame: CGRectMake(0,0,340,44)];
	 UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:selector];
	 [myToolbar setItems:[NSArray arrayWithObject: doneButton] animated:NO];
	 textField.inputAccessoryView = myToolbar;
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:HEART_REGULAR_KEY]!= nil, @"HeartRegular is nil");
	 NSAssert([section getElementForKey:HEART_OTHER_KEY]!= nil, @"HeartOther is nil");
	 NSAssert([section getElementForKey:HEART_OTHER_REASON_KEY]!= nil, @"HeartOtherReason is nil");
	 NSAssert([section getElementForKey:LUNGS_CLEAR_KEY]!= nil, @"LungsClear is nil");
	 NSAssert([section getElementForKey:LUNGS_OTHER_KEY]!= nil, @"LungsOther is nil");
	 NSAssert([section getElementForKey:LUNGS_OTHER_REASON_KEY]!= nil, @"LungsOtherReason is nil");
	 NSAssert([section getElementForKey:NOTES_KEY]!= nil, @"Notes is nil");
	 
}

-(BOOL)validateData:(NSString**)errMsg
{
	 if( self.heartOtherBBCheckBox.selected ){ 
		 if( !(![self.heartOtherReasonUITextField.text isEqualToString:@""]) ){ 
			 *errMsg = @"HeartOtherReason must be not empty when HeartOther is selected"; 
			 return false; 
		 }
	 }
	 if( self.lungsOtherBBCheckBox.selected ){ 
		 if( !(![self.lungsOtherReasonUITextField.text isEqualToString:@""]) ){ 
			 *errMsg = @"LungsOtherReason must be not empty when LungsOther is selected"; 
			 return false; 
		 }
	 }
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
	 
	 TextElement *notes = (TextElement*)[_section getElementForKey:NOTES_KEY];
	 if (!notes) {
		 notes = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 notes.key = NOTES_KEY;
		 [_section addElementsObject:notes];
	 }

	 notes.value = self.notesUITextView.text;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)changeMedUnit:(UIButton*)sender {
	 if ([sender.titleLabel.text isEqualToString: @"cc"]) { 
		 [sender setTitle:@"mcg" forState:UIControlStateNormal];
	 } else if ([sender.titleLabel.text isEqualToString: @"mcg"]) {
		 [sender setTitle:@"mg" forState:UIControlStateNormal];
	 } else if ([sender.titleLabel.text isEqualToString: @"mg"]) {
		 [sender setTitle:@"G" forState:UIControlStateNormal];
	 } else if ([sender.titleLabel.text isEqualToString: @"G"]) {
		 [sender setTitle:@"none" forState:UIControlStateNormal];
	 } else if ([sender.titleLabel.text isEqualToString: @"none"]) {
		 [sender setTitle:@"cc" forState:UIControlStateNormal];
	 } 
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
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 self.heartRegularBBCheckBox.selected = NO;
	 self.heartOtherBBCheckBox.selected = NO;
	 sender.selected = selected;
}
-(void)radioGroup2:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 self.lungsClearBBCheckBox.selected = NO;
	 self.lungsOtherBBCheckBox.selected = NO;
	 sender.selected = selected;
}
@end