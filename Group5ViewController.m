/*This file is generated by perlxml.pl. DO NOT MODIFY */

#import "Group5ViewController.h"
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


@interface Group5ViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *obLowApgarBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *obInfantDeathBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *awarenessBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *patientComplaintBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextView *otherUITextView;
@end

@implementation Group5ViewController
NSString *const GROUP5_SECTION_TITLE = @"Group5SectionKey";
static NSString *const OB_LOW_APGAR_KEY = @"ObLowApgarKey";
static NSString *const OB_INFANT_DEATH_KEY = @"ObInfantDeathKey";
static NSString *const AWARENESS_KEY = @"AwarenessKey";
static NSString *const PATIENT_COMPLAINT_KEY = @"PatientComplaintKey";
static NSString *const OTHER_KEY = @"OtherKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:OB_LOW_APGAR_KEY]){
				 [self.obLowApgarBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OB_INFANT_DEATH_KEY]){
				 [self.obInfantDeathBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:AWARENESS_KEY]){
				 [self.awarenessBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PATIENT_COMPLAINT_KEY]){
				 [self.patientComplaintBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OTHER_KEY]){
				 [self.otherUITextView setText:((TextElement*)element).value];
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
	 NSAssert([section getElementForKey:OB_LOW_APGAR_KEY]!= nil, @"ObLowApgar is nil");
	 NSAssert([section getElementForKey:OB_INFANT_DEATH_KEY]!= nil, @"ObInfantDeath is nil");
	 NSAssert([section getElementForKey:AWARENESS_KEY]!= nil, @"Awareness is nil");
	 NSAssert([section getElementForKey:PATIENT_COMPLAINT_KEY]!= nil, @"PatientComplaint is nil");
	 NSAssert([section getElementForKey:OTHER_KEY]!= nil, @"Other is nil");
	 
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
		 self.section.title = GROUP5_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *obLowApgar = (BooleanFormElement*)[_section getElementForKey:OB_LOW_APGAR_KEY];
	 if (!obLowApgar) {
		 obLowApgar = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 obLowApgar.key = OB_LOW_APGAR_KEY;
		 [_section addElementsObject:obLowApgar];
	 }

	 obLowApgar.value = [NSNumber numberWithBool:self.obLowApgarBBCheckBox.isSelected];
	 
	 BooleanFormElement *obInfantDeath = (BooleanFormElement*)[_section getElementForKey:OB_INFANT_DEATH_KEY];
	 if (!obInfantDeath) {
		 obInfantDeath = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 obInfantDeath.key = OB_INFANT_DEATH_KEY;
		 [_section addElementsObject:obInfantDeath];
	 }

	 obInfantDeath.value = [NSNumber numberWithBool:self.obInfantDeathBBCheckBox.isSelected];
	 
	 BooleanFormElement *awareness = (BooleanFormElement*)[_section getElementForKey:AWARENESS_KEY];
	 if (!awareness) {
		 awareness = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 awareness.key = AWARENESS_KEY;
		 [_section addElementsObject:awareness];
	 }

	 awareness.value = [NSNumber numberWithBool:self.awarenessBBCheckBox.isSelected];
	 
	 BooleanFormElement *patientComplaint = (BooleanFormElement*)[_section getElementForKey:PATIENT_COMPLAINT_KEY];
	 if (!patientComplaint) {
		 patientComplaint = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 patientComplaint.key = PATIENT_COMPLAINT_KEY;
		 [_section addElementsObject:patientComplaint];
	 }

	 patientComplaint.value = [NSNumber numberWithBool:self.patientComplaintBBCheckBox.isSelected];
	 
	 TextElement *other = (TextElement*)[_section getElementForKey:OTHER_KEY];
	 if (!other) {
		 other = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 other.key = OTHER_KEY;
		 [_section addElementsObject:other];
	 }

	 other.value = self.otherUITextView.text;
	 
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
	 return GROUP5_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 sender.selected = selected;
}
@end