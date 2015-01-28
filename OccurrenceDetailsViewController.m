/*This file is generated by perlxml.pl. DO NOT MODIFY */

#import "OccurrenceDetailsViewController.h"
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


@interface OccurrenceDetailsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextView *descriptionUITextView;
@property (weak, nonatomic) IBOutlet UITextView *occurrenceUITextView;
@property (weak, nonatomic) IBOutlet UITextView *treatmentUITextView;
@end

@implementation OccurrenceDetailsViewController
NSString *const OCCURRENCE_DETAILS_SECTION_TITLE = @"OccurrenceDetailsSectionKey";
static NSString *const DESCRIPTION_KEY = @"DescriptionKey";
static NSString *const OCCURRENCE_KEY = @"OccurrenceKey";
static NSString *const TREATMENT_KEY = @"TreatmentKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:DESCRIPTION_KEY]){
				 [self.descriptionUITextView setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:OCCURRENCE_KEY]){
				 [self.occurrenceUITextView setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:TREATMENT_KEY]){
				 [self.treatmentUITextView setText:((TextElement*)element).value];
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
	 NSAssert([section getElementForKey:DESCRIPTION_KEY]!= nil, @"Description is nil");
	 NSAssert([section getElementForKey:OCCURRENCE_KEY]!= nil, @"Occurrence is nil");
	 NSAssert([section getElementForKey:TREATMENT_KEY]!= nil, @"Treatment is nil");
	 
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
		 self.section.title = OCCURRENCE_DETAILS_SECTION_TITLE;
	 }
	 
	 TextElement *description = (TextElement*)[_section getElementForKey:DESCRIPTION_KEY];
	 if (!description) {
		 description = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 description.key = DESCRIPTION_KEY;
		 [_section addElementsObject:description];
	 }

	 description.value = self.descriptionUITextView.text;
	 
	 TextElement *occurrence = (TextElement*)[_section getElementForKey:OCCURRENCE_KEY];
	 if (!occurrence) {
		 occurrence = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 occurrence.key = OCCURRENCE_KEY;
		 [_section addElementsObject:occurrence];
	 }

	 occurrence.value = self.occurrenceUITextView.text;
	 
	 TextElement *treatment = (TextElement*)[_section getElementForKey:TREATMENT_KEY];
	 if (!treatment) {
		 treatment = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 treatment.key = TREATMENT_KEY;
		 [_section addElementsObject:treatment];
	 }

	 treatment.value = self.treatmentUITextView.text;
	 
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
	 return OCCURRENCE_DETAILS_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 sender.selected = selected;
}
@end