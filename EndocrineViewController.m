#import "EndocrineViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface EndocrineViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *endocrineBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *endocrineNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *diabetesBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hyperThyroidBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hypoThyroidBBCheckBox;
@end

@implementation EndocrineViewController
NSString *const ENDOCRINE_SECTION_TITLE = @"EndocrineSectionKey";
NSString *const ENDOCRINE_KEY = @"EndocrineKey";
NSString *const ENDOCRINE_NEGATIVE_KEY = @"EndocrineNegativeKey";
NSString *const DIABETES_KEY = @"DiabetesKey";
NSString *const HYPER_THYROID_KEY = @"HyperThyroidKey";
NSString *const HYPO_THYROID_KEY = @"HypoThyroidKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:ENDOCRINE_KEY]){
				 [self.endocrineBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ENDOCRINE_NEGATIVE_KEY]){
				 [self.endocrineNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DIABETES_KEY]){
				 [self.diabetesBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HYPER_THYROID_KEY]){
				 [self.hyperThyroidBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HYPO_THYROID_KEY]){
				 [self.hypoThyroidBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
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
	 NSAssert([group getElementForKey:ENDOCRINE_KEY]!= nil, @"Endocrine is nil");
	 NSAssert([group getElementForKey:ENDOCRINE_NEGATIVE_KEY]!= nil, @"EndocrineNegative is nil");
	 NSAssert([group getElementForKey:DIABETES_KEY]!= nil, @"Diabetes is nil");
	 NSAssert([group getElementForKey:HYPER_THYROID_KEY]!= nil, @"HyperThyroid is nil");
	 NSAssert([group getElementForKey:HYPO_THYROID_KEY]!= nil, @"HypoThyroid is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = ENDOCRINE_SECTION_TITLE;
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
	 BooleanFormElement *endocrine = (BooleanFormElement*)[group getElementForKey:ENDOCRINE_KEY];
	 if (!endocrine) {
		 endocrine = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 endocrine.key = ENDOCRINE_KEY;
		 [group addElementsObject:endocrine];
	 }

	 endocrine.value = [NSNumber numberWithBool:self.endocrineBBCheckBox.isSelected];
	 
	 BooleanFormElement *endocrineNegative = (BooleanFormElement*)[group getElementForKey:ENDOCRINE_NEGATIVE_KEY];
	 if (!endocrineNegative) {
		 endocrineNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 endocrineNegative.key = ENDOCRINE_NEGATIVE_KEY;
		 [group addElementsObject:endocrineNegative];
	 }

	 endocrineNegative.value = [NSNumber numberWithBool:self.endocrineNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *diabetes = (BooleanFormElement*)[group getElementForKey:DIABETES_KEY];
	 if (!diabetes) {
		 diabetes = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 diabetes.key = DIABETES_KEY;
		 [group addElementsObject:diabetes];
	 }

	 diabetes.value = [NSNumber numberWithBool:self.diabetesBBCheckBox.isSelected];
	 
	 BooleanFormElement *hyperThyroid = (BooleanFormElement*)[group getElementForKey:HYPER_THYROID_KEY];
	 if (!hyperThyroid) {
		 hyperThyroid = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hyperThyroid.key = HYPER_THYROID_KEY;
		 [group addElementsObject:hyperThyroid];
	 }

	 hyperThyroid.value = [NSNumber numberWithBool:self.hyperThyroidBBCheckBox.isSelected];
	 
	 BooleanFormElement *hypoThyroid = (BooleanFormElement*)[group getElementForKey:HYPO_THYROID_KEY];
	 if (!hypoThyroid) {
		 hypoThyroid = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hypoThyroid.key = HYPO_THYROID_KEY;
		 [group addElementsObject:hypoThyroid];
	 }

	 hypoThyroid.value = [NSNumber numberWithBool:self.hypoThyroidBBCheckBox.isSelected];
	 
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
	 return ENDOCRINE_SECTION_TITLE;
}
@end