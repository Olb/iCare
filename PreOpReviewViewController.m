#import "PreOpReviewViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface PreOpReviewViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *noneChangesNotedBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *preOpEvaluationByUITextField;
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
NSString *const NONE_CHANGES_NOTED_KEY = @"NoneChangesNotedKey";
NSString *const PRE_OP_EVALUATION_BY_KEY = @"PreOpEvaluationByKey";
NSString *const BP_KEY = @"BPKey";
NSString *const HR_KEY = @"HRKey";
NSString *const SPO2_KEY = @"SpO2Key";
NSString *const RR_KEY = @"RRKey";
NSString *const TEMP_KEY = @"TempKey";
NSString *const NPOTime_KEY = @"NPOTimeKey";
NSString *const NAMEMD_KEY = @"NameMDKey";
NSString *const REVIEW_DATE_KEY = @"ReviewDateKey";
NSString *const REVIEW_TIME_KEY = @"ReviewTimeKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:NONE_CHANGES_NOTED_KEY]){
				 [self.noneChangesNotedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PRE_OP_EVALUATION_BY_KEY]){
				 [self.preOpEvaluationByUITextField setText:((TextElement*)element).value];
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
	 int count;
	 NSString *errMsg;
	 
	 count = [_section.groups count];
	 errMsg =[NSString stringWithFormat:@"Invalid number of groups '%d'. Expected '1'.", count];
	 NSAssert(count, errMsg);
	 
	 FormGroup *group;
	 
	 group = [_section.groups objectAtIndex:0];
	 NSAssert([group getElementForKey:NONE_CHANGES_NOTED_KEY]!= nil, @"NoneChangesNoted is nil");
	 NSAssert([group getElementForKey:PRE_OP_EVALUATION_BY_KEY]!= nil, @"PreOpEvaluationBy is nil");
	 NSAssert([group getElementForKey:BP_KEY]!= nil, @"BP is nil");
	 NSAssert([group getElementForKey:HR_KEY]!= nil, @"HR is nil");
	 NSAssert([group getElementForKey:SPO2_KEY]!= nil, @"SpO2 is nil");
	 NSAssert([group getElementForKey:RR_KEY]!= nil, @"RR is nil");
	 NSAssert([group getElementForKey:TEMP_KEY]!= nil, @"Temp is nil");
	 NSAssert([group getElementForKey:NPOTime_KEY]!= nil, @"NPOTime is nil");
	 NSAssert([group getElementForKey:NAMEMD_KEY]!= nil, @"NameMD is nil");
	 NSAssert([group getElementForKey:REVIEW_DATE_KEY]!= nil, @"ReviewDate is nil");
	 NSAssert([group getElementForKey:REVIEW_TIME_KEY]!= nil, @"ReviewTime is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PRE_OP_REVIEW_SECTION_TITLE;
	 }
	 
	 FormGroup *group;
	 
	 group = nil;
	 if ([self.section.groups count] > 0) {
		 group = [self.section.groups objectAtIndex:0];
	 }
	 if ( !group ){
		 group =(FormGroup*)[BBUtil newCoreDataObjectForEntityName:@"FormGroup"];
		 group.optional = [NSNumber numberWithBool:false];
		 [self.section addGroupsObject:group];
	 }
	 BooleanFormElement *noneChangesNoted = (BooleanFormElement*)[group getElementForKey:NONE_CHANGES_NOTED_KEY];
	 if (!noneChangesNoted) {
		 noneChangesNoted = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 noneChangesNoted.key = NONE_CHANGES_NOTED_KEY;
		 [group addElementsObject:noneChangesNoted];
	 }

	 noneChangesNoted.value = [NSNumber numberWithBool:self.noneChangesNotedBBCheckBox.isSelected];
	 
	 TextElement *preOpEvaluationBy = (TextElement*)[group getElementForKey:PRE_OP_EVALUATION_BY_KEY];
	 if (!preOpEvaluationBy) {
		 preOpEvaluationBy = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 preOpEvaluationBy.key = PRE_OP_EVALUATION_BY_KEY;
		 [group addElementsObject:preOpEvaluationBy];
	 }

	 preOpEvaluationBy.value = self.preOpEvaluationByUITextField.text;
	 
	 TextElement *bP = (TextElement*)[group getElementForKey:BP_KEY];
	 if (!bP) {
		 bP = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 bP.key = BP_KEY;
		 [group addElementsObject:bP];
	 }

	 bP.value = self.bPUITextField.text;
	 
	 TextElement *hR = (TextElement*)[group getElementForKey:HR_KEY];
	 if (!hR) {
		 hR = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 hR.key = HR_KEY;
		 [group addElementsObject:hR];
	 }

	 hR.value = self.hRUITextField.text;
	 
	 TextElement *spO2 = (TextElement*)[group getElementForKey:SPO2_KEY];
	 if (!spO2) {
		 spO2 = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 spO2.key = SPO2_KEY;
		 [group addElementsObject:spO2];
	 }

	 spO2.value = self.spO2UITextField.text;
	 
	 TextElement *rR = (TextElement*)[group getElementForKey:RR_KEY];
	 if (!rR) {
		 rR = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 rR.key = RR_KEY;
		 [group addElementsObject:rR];
	 }

	 rR.value = self.rRUITextField.text;
	 
	 TextElement *temp = (TextElement*)[group getElementForKey:TEMP_KEY];
	 if (!temp) {
		 temp = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 temp.key = TEMP_KEY;
		 [group addElementsObject:temp];
	 }

	 temp.value = self.tempUITextField.text;
	 
	 TextElement *nPOTime = (TextElement*)[group getElementForKey:NPOTime_KEY];
	 if (!nPOTime) {
		 nPOTime = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 nPOTime.key = NPOTime_KEY;
		 [group addElementsObject:nPOTime];
	 }

	 nPOTime.value = self.nPOTimeUITextField.text;
	 
	 TextElement *nameMD = (TextElement*)[group getElementForKey:NAMEMD_KEY];
	 if (!nameMD) {
		 nameMD = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 nameMD.key = NAMEMD_KEY;
		 [group addElementsObject:nameMD];
	 }

	 nameMD.value = self.nameMDUITextField.text;
	 
	 TextElement *reviewDate = (TextElement*)[group getElementForKey:REVIEW_DATE_KEY];
	 if (!reviewDate) {
		 reviewDate = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 reviewDate.key = REVIEW_DATE_KEY;
		 [group addElementsObject:reviewDate];
	 }

	 reviewDate.value = self.reviewDateUITextField.text;
	 
	 TextElement *reviewTime = (TextElement*)[group getElementForKey:REVIEW_TIME_KEY];
	 if (!reviewTime) {
		 reviewTime = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 reviewTime.key = REVIEW_TIME_KEY;
		 [group addElementsObject:reviewTime];
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