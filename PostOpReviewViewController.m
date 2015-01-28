/*This file is generated by perlxml.pl. DO NOT MODIFY */

#import "PostOpReviewViewController.h"
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


@interface PostOpReviewViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *submittedByUITextField;
@property (weak, nonatomic) IBOutlet UITextField *submittedByDateUITextField;
@property (weak, nonatomic) IBOutlet UITextField *reviewedByUITextField;
@property (weak, nonatomic) IBOutlet UITextField *reviewedByDateUITextField;
@property (weak, nonatomic) IBOutlet UITextView *notesUITextView;
@end

@implementation PostOpReviewViewController
NSString *const POST_OP_REVIEW_SECTION_TITLE = @"PostOpReviewSectionKey";
static NSString *const SUBMITTED_BY_KEY = @"SubmittedByKey";
static NSString *const SUBMITTED_BY_DATE_KEY = @"SubmittedByDateKey";
static NSString *const REVIEWED_BY_KEY = @"ReviewedByKey";
static NSString *const REVIEWED_BY_DATE_KEY = @"ReviewedByDateKey";
static NSString *const NOTES_KEY = @"NotesKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:SUBMITTED_BY_KEY]){
				 [self.submittedByUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:SUBMITTED_BY_DATE_KEY]){
				 [self.submittedByDateUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:REVIEWED_BY_KEY]){
				 [self.reviewedByUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:REVIEWED_BY_DATE_KEY]){
				 [self.reviewedByDateUITextField setText:((TextElement*)element).value];
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
	 NSAssert([section getElementForKey:SUBMITTED_BY_KEY]!= nil, @"SubmittedBy is nil");
	 NSAssert([section getElementForKey:SUBMITTED_BY_DATE_KEY]!= nil, @"SubmittedByDate is nil");
	 NSAssert([section getElementForKey:REVIEWED_BY_KEY]!= nil, @"ReviewedBy is nil");
	 NSAssert([section getElementForKey:REVIEWED_BY_DATE_KEY]!= nil, @"ReviewedByDate is nil");
	 NSAssert([section getElementForKey:NOTES_KEY]!= nil, @"Notes is nil");
	 
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
		 self.section.title = POST_OP_REVIEW_SECTION_TITLE;
	 }
	 
	 TextElement *submittedBy = (TextElement*)[_section getElementForKey:SUBMITTED_BY_KEY];
	 if (!submittedBy) {
		 submittedBy = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 submittedBy.key = SUBMITTED_BY_KEY;
		 [_section addElementsObject:submittedBy];
	 }

	 submittedBy.value = self.submittedByUITextField.text;
	 
	 TextElement *submittedByDate = (TextElement*)[_section getElementForKey:SUBMITTED_BY_DATE_KEY];
	 if (!submittedByDate) {
		 submittedByDate = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 submittedByDate.key = SUBMITTED_BY_DATE_KEY;
		 [_section addElementsObject:submittedByDate];
	 }

	 submittedByDate.value = self.submittedByDateUITextField.text;
	 
	 TextElement *reviewedBy = (TextElement*)[_section getElementForKey:REVIEWED_BY_KEY];
	 if (!reviewedBy) {
		 reviewedBy = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 reviewedBy.key = REVIEWED_BY_KEY;
		 [_section addElementsObject:reviewedBy];
	 }

	 reviewedBy.value = self.reviewedByUITextField.text;
	 
	 TextElement *reviewedByDate = (TextElement*)[_section getElementForKey:REVIEWED_BY_DATE_KEY];
	 if (!reviewedByDate) {
		 reviewedByDate = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 reviewedByDate.key = REVIEWED_BY_DATE_KEY;
		 [_section addElementsObject:reviewedByDate];
	 }

	 reviewedByDate.value = self.reviewedByDateUITextField.text;
	 
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
	 return POST_OP_REVIEW_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 sender.selected = selected;
}
@end