
#import "PreOpReviewViewController.h"
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


@interface PreOpReviewViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *noneChangesNotedBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *changesNotedUITextField;
@property (weak, nonatomic) IBOutlet UITextField *bPUITextField;
@property (weak, nonatomic) IBOutlet UITextField *hRUITextField;
@property (weak, nonatomic) IBOutlet UITextField *spO2UITextField;
@property (weak, nonatomic) IBOutlet UITextField *rRUITextField;
@property (weak, nonatomic) IBOutlet UITextField *tempUITextField;
@property (weak, nonatomic) IBOutlet UITextField *nPOTimeUITextField;
@property (weak, nonatomic) IBOutlet UITextField *nameMDUITextField;
@property (weak, nonatomic) IBOutlet UITextField *reviewDateUITextField;
@property (weak, nonatomic) IBOutlet UITextField *reviewTimeUITextField;
@end

@implementation PreOpReviewViewController
NSString *const PRE_OP_REVIEW_SECTION_TITLE = @"PreOpReviewSectionKey";
static NSString *const NONE_CHANGES_NOTED_KEY = @"NoneChangesNotedKey";
static NSString *const CHANGES_NOTED_KEY = @"ChangesNotedKey";
static NSString *const BP_KEY = @"BPKey";
static NSString *const HR_KEY = @"HRKey";
static NSString *const SPO2_KEY = @"SpO2Key";
static NSString *const RR_KEY = @"RRKey";
static NSString *const TEMP_KEY = @"TempKey";
static NSString *const NPOTime_KEY = @"NPOTimeKey";
static NSString *const NAMEMD_KEY = @"NameMDKey";
static NSString *const REVIEW_DATE_KEY = @"ReviewDateKey";
static NSString *const REVIEW_TIME_KEY = @"ReviewTimeKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:NONE_CHANGES_NOTED_KEY]){
				 [self.noneChangesNotedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CHANGES_NOTED_KEY]){
				 [self.changesNotedUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:BP_KEY]){
				 [self.bPUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:HR_KEY]){
				 [self.hRUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:SPO2_KEY]){
				 [self.spO2UITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:RR_KEY]){
				 [self.rRUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:TEMP_KEY]){
				 [self.tempUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:NPOTime_KEY]){
				 [self.nPOTimeUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:NAMEMD_KEY]){
				 [self.nameMDUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:REVIEW_DATE_KEY]){
				 [self.reviewDateUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:REVIEW_TIME_KEY]){
				 [self.reviewTimeUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:NONE_CHANGES_NOTED_KEY]!= nil, @"NoneChangesNoted is nil");
	 NSAssert([section getElementForKey:CHANGES_NOTED_KEY]!= nil, @"ChangesNoted is nil");
	 NSAssert([section getElementForKey:BP_KEY]!= nil, @"BP is nil");
	 NSAssert([section getElementForKey:HR_KEY]!= nil, @"HR is nil");
	 NSAssert([section getElementForKey:SPO2_KEY]!= nil, @"SpO2 is nil");
	 NSAssert([section getElementForKey:RR_KEY]!= nil, @"RR is nil");
	 NSAssert([section getElementForKey:TEMP_KEY]!= nil, @"Temp is nil");
	 NSAssert([section getElementForKey:NPOTime_KEY]!= nil, @"NPOTime is nil");
	 NSAssert([section getElementForKey:NAMEMD_KEY]!= nil, @"NameMD is nil");
	 NSAssert([section getElementForKey:REVIEW_DATE_KEY]!= nil, @"ReviewDate is nil");
	 NSAssert([section getElementForKey:REVIEW_TIME_KEY]!= nil, @"ReviewTime is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PRE_OP_REVIEW_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *noneChangesNoted = (BooleanFormElement*)[_section getElementForKey:NONE_CHANGES_NOTED_KEY];
	 if (!noneChangesNoted) {
		 noneChangesNoted = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 noneChangesNoted.key = NONE_CHANGES_NOTED_KEY;
		 [_section addElementsObject:noneChangesNoted];
	 }

	 noneChangesNoted.value = [NSNumber numberWithBool:self.noneChangesNotedBBCheckBox.isSelected];
	 
	 TextElement *changesNoted = (TextElement*)[_section getElementForKey:CHANGES_NOTED_KEY];
	 if (!changesNoted) {
		 changesNoted = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 changesNoted.key = CHANGES_NOTED_KEY;
		 [_section addElementsObject:changesNoted];
	 }

	 changesNoted.value = self.changesNotedUITextField.text;
	 
	 TextElement *bP = (TextElement*)[_section getElementForKey:BP_KEY];
	 if (!bP) {
		 bP = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 bP.key = BP_KEY;
		 [_section addElementsObject:bP];
	 }

	 bP.value = self.bPUITextField.text;
	 
	 TextElement *hR = (TextElement*)[_section getElementForKey:HR_KEY];
	 if (!hR) {
		 hR = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 hR.key = HR_KEY;
		 [_section addElementsObject:hR];
	 }

	 hR.value = self.hRUITextField.text;
	 
	 TextElement *spO2 = (TextElement*)[_section getElementForKey:SPO2_KEY];
	 if (!spO2) {
		 spO2 = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 spO2.key = SPO2_KEY;
		 [_section addElementsObject:spO2];
	 }

	 spO2.value = self.spO2UITextField.text;
	 
	 TextElement *rR = (TextElement*)[_section getElementForKey:RR_KEY];
	 if (!rR) {
		 rR = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 rR.key = RR_KEY;
		 [_section addElementsObject:rR];
	 }

	 rR.value = self.rRUITextField.text;
	 
	 TextElement *temp = (TextElement*)[_section getElementForKey:TEMP_KEY];
	 if (!temp) {
		 temp = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 temp.key = TEMP_KEY;
		 [_section addElementsObject:temp];
	 }

	 temp.value = self.tempUITextField.text;
	 
	 TextElement *nPOTime = (TextElement*)[_section getElementForKey:NPOTime_KEY];
	 if (!nPOTime) {
		 nPOTime = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 nPOTime.key = NPOTime_KEY;
		 [_section addElementsObject:nPOTime];
	 }

	 nPOTime.value = self.nPOTimeUITextField.text;
	 
	 TextElement *nameMD = (TextElement*)[_section getElementForKey:NAMEMD_KEY];
	 if (!nameMD) {
		 nameMD = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 nameMD.key = NAMEMD_KEY;
		 [_section addElementsObject:nameMD];
	 }

	 nameMD.value = self.nameMDUITextField.text;
	 
	 TextElement *reviewDate = (TextElement*)[_section getElementForKey:REVIEW_DATE_KEY];
	 if (!reviewDate) {
		 reviewDate = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 reviewDate.key = REVIEW_DATE_KEY;
		 [_section addElementsObject:reviewDate];
	 }

	 reviewDate.value = self.reviewDateUITextField.text;
	 
	 TextElement *reviewTime = (TextElement*)[_section getElementForKey:REVIEW_TIME_KEY];
	 if (!reviewTime) {
		 reviewTime = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 reviewTime.key = REVIEW_TIME_KEY;
		 [_section addElementsObject:reviewTime];
	 }

	 reviewTime.value = self.reviewTimeUITextField.text;
	 
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
	 return PRE_OP_REVIEW_SECTION_TITLE;
}
@end