/*This file is generated by perlxml.pl. DO NOT MODIFY */

#import "NeuroligcViewController.h"
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


@interface NeuroligcViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *neurologicBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *neurologicNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *dementiaBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *neuropathyBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *backPainBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *neckPainBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cVABBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *tIABBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *alteredMentalStatusBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *seizuresBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextView *notesUITextView;
@end

@implementation NeuroligcViewController
NSString *const NEUROLIGC_SECTION_TITLE = @"NeuroligcSectionKey";
static NSString *const NEUROLOGIC_KEY = @"NeurologicKey";
static NSString *const NEUROLOGIC_NEGATIVE_KEY = @"NeurologicNegativeKey";
static NSString *const DEMENTIA_KEY = @"DementiaKey";
static NSString *const NEUROPATHY_KEY = @"NeuropathyKey";
static NSString *const BACK_PAIN_KEY = @"BackPainKey";
static NSString *const NECK_PAIN_KEY = @"NeckPainKey";
static NSString *const CVA_KEY = @"CVAKey";
static NSString *const TIA_KEY = @"TIAKey";
static NSString *const ALTERED_MENTAL_STATUS_KEY = @"AlteredMentalStatusKey";
static NSString *const SEIZURES_KEY = @"SeizuresKey";
static NSString *const NOTES_KEY = @"NotesKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 [self.neurologicBBCheckBox addTarget:self action:@selector(radioGroup1:) forControlEvents:UIControlEventTouchUpInside];
	 [self.neurologicNegativeBBCheckBox addTarget:self action:@selector(radioGroup1:) forControlEvents:UIControlEventTouchUpInside];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:NEUROLOGIC_KEY]){
				 [self.neurologicBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NEUROLOGIC_NEGATIVE_KEY]){
				 [self.neurologicNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DEMENTIA_KEY]){
				 [self.dementiaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NEUROPATHY_KEY]){
				 [self.neuropathyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:BACK_PAIN_KEY]){
				 [self.backPainBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NECK_PAIN_KEY]){
				 [self.neckPainBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CVA_KEY]){
				 [self.cVABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:TIA_KEY]){
				 [self.tIABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ALTERED_MENTAL_STATUS_KEY]){
				 [self.alteredMentalStatusBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SEIZURES_KEY]){
				 [self.seizuresBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
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
	 NSAssert([section getElementForKey:NEUROLOGIC_KEY]!= nil, @"Neurologic is nil");
	 NSAssert([section getElementForKey:NEUROLOGIC_NEGATIVE_KEY]!= nil, @"NeurologicNegative is nil");
	 NSAssert([section getElementForKey:DEMENTIA_KEY]!= nil, @"Dementia is nil");
	 NSAssert([section getElementForKey:NEUROPATHY_KEY]!= nil, @"Neuropathy is nil");
	 NSAssert([section getElementForKey:BACK_PAIN_KEY]!= nil, @"BackPain is nil");
	 NSAssert([section getElementForKey:NECK_PAIN_KEY]!= nil, @"NeckPain is nil");
	 NSAssert([section getElementForKey:CVA_KEY]!= nil, @"CVA is nil");
	 NSAssert([section getElementForKey:TIA_KEY]!= nil, @"TIA is nil");
	 NSAssert([section getElementForKey:ALTERED_MENTAL_STATUS_KEY]!= nil, @"AlteredMentalStatus is nil");
	 NSAssert([section getElementForKey:SEIZURES_KEY]!= nil, @"Seizures is nil");
	 NSAssert([section getElementForKey:NOTES_KEY]!= nil, @"Notes is nil");
	 
}

-(BOOL)validateData:(NSString**)errMsg
{
	 if( self.neurologicNegativeBBCheckBox.selected ){ 
		 if( !((!self.dementiaBBCheckBox.selected) && (!self.neuropathyBBCheckBox.selected) && (!self.backPainBBCheckBox.selected) && (!self.neckPainBBCheckBox.selected) && (!self.cVABBCheckBox.selected) && (!self.tIABBCheckBox.selected) && (!self.alteredMentalStatusBBCheckBox.selected) && (!self.seizuresBBCheckBox.selected)) ){ 
			 *errMsg = @"Dementia must be unselected and Neuropathy must be unselected and BackPain must be unselected and NeckPain must be unselected and CVA must be unselected and TIA must be unselected and AlteredMentalStatus must be unselected and Seizures must be unselected when NeurologicNegative is selected"; 
			 return false; 
		 }
	 }
	 if( self.neurologicBBCheckBox.selected ){ 
		 if( !(self.dementiaBBCheckBox.selected || self.neuropathyBBCheckBox.selected || self.backPainBBCheckBox.selected || self.neckPainBBCheckBox.selected || self.cVABBCheckBox.selected || self.tIABBCheckBox.selected || self.alteredMentalStatusBBCheckBox.selected || self.seizuresBBCheckBox.selected) ){ 
			 *errMsg = @"Dementia must be selected or Neuropathy must be selected or BackPain must be selected or NeckPain must be selected or CVA must be selected or TIA must be selected or AlteredMentalStatus must be selected or Seizures must be selected when Neurologic is selected"; 
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
		 self.section.title = NEUROLIGC_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *neurologic = (BooleanFormElement*)[_section getElementForKey:NEUROLOGIC_KEY];
	 if (!neurologic) {
		 neurologic = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 neurologic.key = NEUROLOGIC_KEY;
		 [_section addElementsObject:neurologic];
	 }

	 neurologic.value = [NSNumber numberWithBool:self.neurologicBBCheckBox.isSelected];
	 
	 BooleanFormElement *neurologicNegative = (BooleanFormElement*)[_section getElementForKey:NEUROLOGIC_NEGATIVE_KEY];
	 if (!neurologicNegative) {
		 neurologicNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 neurologicNegative.key = NEUROLOGIC_NEGATIVE_KEY;
		 [_section addElementsObject:neurologicNegative];
	 }

	 neurologicNegative.value = [NSNumber numberWithBool:self.neurologicNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *dementia = (BooleanFormElement*)[_section getElementForKey:DEMENTIA_KEY];
	 if (!dementia) {
		 dementia = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 dementia.key = DEMENTIA_KEY;
		 [_section addElementsObject:dementia];
	 }

	 dementia.value = [NSNumber numberWithBool:self.dementiaBBCheckBox.isSelected];
	 
	 BooleanFormElement *neuropathy = (BooleanFormElement*)[_section getElementForKey:NEUROPATHY_KEY];
	 if (!neuropathy) {
		 neuropathy = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 neuropathy.key = NEUROPATHY_KEY;
		 [_section addElementsObject:neuropathy];
	 }

	 neuropathy.value = [NSNumber numberWithBool:self.neuropathyBBCheckBox.isSelected];
	 
	 BooleanFormElement *backPain = (BooleanFormElement*)[_section getElementForKey:BACK_PAIN_KEY];
	 if (!backPain) {
		 backPain = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 backPain.key = BACK_PAIN_KEY;
		 [_section addElementsObject:backPain];
	 }

	 backPain.value = [NSNumber numberWithBool:self.backPainBBCheckBox.isSelected];
	 
	 BooleanFormElement *neckPain = (BooleanFormElement*)[_section getElementForKey:NECK_PAIN_KEY];
	 if (!neckPain) {
		 neckPain = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 neckPain.key = NECK_PAIN_KEY;
		 [_section addElementsObject:neckPain];
	 }

	 neckPain.value = [NSNumber numberWithBool:self.neckPainBBCheckBox.isSelected];
	 
	 BooleanFormElement *cVA = (BooleanFormElement*)[_section getElementForKey:CVA_KEY];
	 if (!cVA) {
		 cVA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cVA.key = CVA_KEY;
		 [_section addElementsObject:cVA];
	 }

	 cVA.value = [NSNumber numberWithBool:self.cVABBCheckBox.isSelected];
	 
	 BooleanFormElement *tIA = (BooleanFormElement*)[_section getElementForKey:TIA_KEY];
	 if (!tIA) {
		 tIA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 tIA.key = TIA_KEY;
		 [_section addElementsObject:tIA];
	 }

	 tIA.value = [NSNumber numberWithBool:self.tIABBCheckBox.isSelected];
	 
	 BooleanFormElement *alteredMentalStatus = (BooleanFormElement*)[_section getElementForKey:ALTERED_MENTAL_STATUS_KEY];
	 if (!alteredMentalStatus) {
		 alteredMentalStatus = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 alteredMentalStatus.key = ALTERED_MENTAL_STATUS_KEY;
		 [_section addElementsObject:alteredMentalStatus];
	 }

	 alteredMentalStatus.value = [NSNumber numberWithBool:self.alteredMentalStatusBBCheckBox.isSelected];
	 
	 BooleanFormElement *seizures = (BooleanFormElement*)[_section getElementForKey:SEIZURES_KEY];
	 if (!seizures) {
		 seizures = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 seizures.key = SEIZURES_KEY;
		 [_section addElementsObject:seizures];
	 }

	 seizures.value = [NSNumber numberWithBool:self.seizuresBBCheckBox.isSelected];
	 
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
		 sender.titleLabel.text = @"mcg";
	 } else if ([sender.titleLabel.text isEqualToString: @"mcg"]) {
		 sender.titleLabel.text = @"mg";
	 } else if ([sender.titleLabel.text isEqualToString: @"mg"]) {
		 sender.titleLabel.text = @"g";
	 } else if ([sender.titleLabel.text isEqualToString: @"g"]) {
		 sender.titleLabel.text = @"cc";
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
	 return NEUROLIGC_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 self.neurologicBBCheckBox.selected = NO;
	 self.neurologicNegativeBBCheckBox.selected = NO;
	 sender.selected = selected;
}
@end