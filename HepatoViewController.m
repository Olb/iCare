/*This file is generated by perlxml.pl. DO NOT MODIFY */

#import "HepatoViewController.h"
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


@interface HepatoViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *gIHepaticBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *gIHepaticNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *gERDBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cirrhosisBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hepatitisBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *obstructionBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextView *notesUITextView;
@end

@implementation HepatoViewController
NSString *const HEPATO_SECTION_TITLE = @"HepatoSectionKey";
static NSString *const GIHepatic_KEY = @"GIHepaticKey";
static NSString *const GIHepatic_NEGATIVE_KEY = @"GIHepaticNegativeKey";
static NSString *const GERD_KEY = @"GERDKey";
static NSString *const CIRRHOSIS_KEY = @"CirrhosisKey";
static NSString *const HEPATITIS_KEY = @"HepatitisKey";
static NSString *const OBSTRUCTION_KEY = @"ObstructionKey";
static NSString *const NOTES_KEY = @"NotesKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 [self.gIHepaticBBCheckBox addTarget:self action:@selector(radioGroup1:) forControlEvents:UIControlEventTouchUpInside];
	 [self.gIHepaticNegativeBBCheckBox addTarget:self action:@selector(radioGroup1:) forControlEvents:UIControlEventTouchUpInside];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:GIHepatic_KEY]){
				 [self.gIHepaticBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:GIHepatic_NEGATIVE_KEY]){
				 [self.gIHepaticNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:GERD_KEY]){
				 [self.gERDBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CIRRHOSIS_KEY]){
				 [self.cirrhosisBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HEPATITIS_KEY]){
				 [self.hepatitisBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OBSTRUCTION_KEY]){
				 [self.obstructionBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
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
	 NSAssert([section getElementForKey:GIHepatic_KEY]!= nil, @"GIHepatic is nil");
	 NSAssert([section getElementForKey:GIHepatic_NEGATIVE_KEY]!= nil, @"GIHepaticNegative is nil");
	 NSAssert([section getElementForKey:GERD_KEY]!= nil, @"GERD is nil");
	 NSAssert([section getElementForKey:CIRRHOSIS_KEY]!= nil, @"Cirrhosis is nil");
	 NSAssert([section getElementForKey:HEPATITIS_KEY]!= nil, @"Hepatitis is nil");
	 NSAssert([section getElementForKey:OBSTRUCTION_KEY]!= nil, @"Obstruction is nil");
	 NSAssert([section getElementForKey:NOTES_KEY]!= nil, @"Notes is nil");
	 
}

-(BOOL)validateData:(NSString**)errMsg
{
	 if( self.gIHepaticNegativeBBCheckBox.selected ){ 
		 if( !((!self.gERDBBCheckBox.selected) && (!self.cirrhosisBBCheckBox.selected) && (!self.hepatitisBBCheckBox.selected) && (!self.obstructionBBCheckBox.selected)) ){ 
			 *errMsg = @"GERD must be unselected and Cirrhosis must be unselected and Hepatitis must be unselected and Obstruction must be unselected when GIHepaticNegative is selected"; 
			 return false; 
		 }
	 }
	 if( self.gIHepaticBBCheckBox.selected ){ 
		 if( !(self.gERDBBCheckBox.selected || self.cirrhosisBBCheckBox.selected || self.hepatitisBBCheckBox.selected || self.obstructionBBCheckBox.selected) ){ 
			 *errMsg = @"GERD must be selected or Cirrhosis must be selected or Hepatitis must be selected or Obstruction must be selected when GIHepatic is selected"; 
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
		 self.section.title = HEPATO_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *gIHepatic = (BooleanFormElement*)[_section getElementForKey:GIHepatic_KEY];
	 if (!gIHepatic) {
		 gIHepatic = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 gIHepatic.key = GIHepatic_KEY;
		 [_section addElementsObject:gIHepatic];
	 }

	 gIHepatic.value = [NSNumber numberWithBool:self.gIHepaticBBCheckBox.isSelected];
	 
	 BooleanFormElement *gIHepaticNegative = (BooleanFormElement*)[_section getElementForKey:GIHepatic_NEGATIVE_KEY];
	 if (!gIHepaticNegative) {
		 gIHepaticNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 gIHepaticNegative.key = GIHepatic_NEGATIVE_KEY;
		 [_section addElementsObject:gIHepaticNegative];
	 }

	 gIHepaticNegative.value = [NSNumber numberWithBool:self.gIHepaticNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *gERD = (BooleanFormElement*)[_section getElementForKey:GERD_KEY];
	 if (!gERD) {
		 gERD = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 gERD.key = GERD_KEY;
		 [_section addElementsObject:gERD];
	 }

	 gERD.value = [NSNumber numberWithBool:self.gERDBBCheckBox.isSelected];
	 
	 BooleanFormElement *cirrhosis = (BooleanFormElement*)[_section getElementForKey:CIRRHOSIS_KEY];
	 if (!cirrhosis) {
		 cirrhosis = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cirrhosis.key = CIRRHOSIS_KEY;
		 [_section addElementsObject:cirrhosis];
	 }

	 cirrhosis.value = [NSNumber numberWithBool:self.cirrhosisBBCheckBox.isSelected];
	 
	 BooleanFormElement *hepatitis = (BooleanFormElement*)[_section getElementForKey:HEPATITIS_KEY];
	 if (!hepatitis) {
		 hepatitis = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hepatitis.key = HEPATITIS_KEY;
		 [_section addElementsObject:hepatitis];
	 }

	 hepatitis.value = [NSNumber numberWithBool:self.hepatitisBBCheckBox.isSelected];
	 
	 BooleanFormElement *obstruction = (BooleanFormElement*)[_section getElementForKey:OBSTRUCTION_KEY];
	 if (!obstruction) {
		 obstruction = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 obstruction.key = OBSTRUCTION_KEY;
		 [_section addElementsObject:obstruction];
	 }

	 obstruction.value = [NSNumber numberWithBool:self.obstructionBBCheckBox.isSelected];
	 
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
	 return HEPATO_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 self.gIHepaticBBCheckBox.selected = NO;
	 self.gIHepaticNegativeBBCheckBox.selected = NO;
	 sender.selected = selected;
}
@end