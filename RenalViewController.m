#import "RenalViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface RenalViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *renalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *renalNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cRIBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *renalFailureBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *lastDialysisUITextField;
@end

@implementation RenalViewController
NSString *const RENAL_SECTION_TITLE = @"RenalSectionKey";
NSString *const RENAL_KEY = @"RenalKey";
NSString *const RENAL_NEGATIVE_KEY = @"RenalNegativeKey";
NSString *const CRI_KEY = @"CRIKey";
NSString *const RENAL_FAILURE_KEY = @"RenalFailureKey";
NSString *const LAST_DIALYSIS_KEY = @"LastDialysisKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:RENAL_KEY]){
				 [self.renalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RENAL_NEGATIVE_KEY]){
				 [self.renalNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CRI_KEY]){
				 [self.cRIBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RENAL_FAILURE_KEY]){
				 [self.renalFailureBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:LAST_DIALYSIS_KEY]){
				 [self.lastDialysisUITextField setText:((TextElement*)element).value];
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
	 NSAssert([group getElementForKey:RENAL_KEY]!= nil, @"Renal is nil");
	 NSAssert([group getElementForKey:RENAL_NEGATIVE_KEY]!= nil, @"RenalNegative is nil");
	 NSAssert([group getElementForKey:CRI_KEY]!= nil, @"CRI is nil");
	 NSAssert([group getElementForKey:RENAL_FAILURE_KEY]!= nil, @"RenalFailure is nil");
	 NSAssert([group getElementForKey:LAST_DIALYSIS_KEY]!= nil, @"LastDialysis is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = RENAL_SECTION_TITLE;
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
	 BooleanFormElement *renal = (BooleanFormElement*)[group getElementForKey:RENAL_KEY];
	 if (!renal) {
		 renal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 renal.key = RENAL_KEY;
		 [group addElementsObject:renal];
	 }

	 renal.value = [NSNumber numberWithBool:self.renalBBCheckBox.isSelected];
	 
	 BooleanFormElement *renalNegative = (BooleanFormElement*)[group getElementForKey:RENAL_NEGATIVE_KEY];
	 if (!renalNegative) {
		 renalNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 renalNegative.key = RENAL_NEGATIVE_KEY;
		 [group addElementsObject:renalNegative];
	 }

	 renalNegative.value = [NSNumber numberWithBool:self.renalNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *cRI = (BooleanFormElement*)[group getElementForKey:CRI_KEY];
	 if (!cRI) {
		 cRI = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cRI.key = CRI_KEY;
		 [group addElementsObject:cRI];
	 }

	 cRI.value = [NSNumber numberWithBool:self.cRIBBCheckBox.isSelected];
	 
	 BooleanFormElement *renalFailure = (BooleanFormElement*)[group getElementForKey:RENAL_FAILURE_KEY];
	 if (!renalFailure) {
		 renalFailure = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 renalFailure.key = RENAL_FAILURE_KEY;
		 [group addElementsObject:renalFailure];
	 }

	 renalFailure.value = [NSNumber numberWithBool:self.renalFailureBBCheckBox.isSelected];
	 
	 TextElement *lastDialysis = (TextElement*)[group getElementForKey:LAST_DIALYSIS_KEY];
	 if (!lastDialysis) {
		 lastDialysis = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 lastDialysis.key = LAST_DIALYSIS_KEY;
		 [group addElementsObject:lastDialysis];
	 }

	 lastDialysis.value = self.lastDialysisUITextField.text;
	 
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
	 return RENAL_SECTION_TITLE;
}
@end