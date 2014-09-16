#import "EvalOtherViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface EvalOtherViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *evalOtherBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *evalOtherNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *obesityBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *depressionBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *glaucomaBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *pregnantBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *eTOHAbuseBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *drugAbuseBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *difficultIVAccessBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *eGABBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *eGAWeeksUITextField;
@end

@implementation EvalOtherViewController
NSString *const EVAL_OTHER_SECTION_TITLE = @"EvalOtherSectionKey";
NSString *const EVAL_OTHER_KEY = @"EvalOtherKey";
NSString *const EVAL_OTHER_NEGATIVE_KEY = @"EvalOtherNegativeKey";
NSString *const OBESITY_KEY = @"ObesityKey";
NSString *const DEPRESSION_KEY = @"DepressionKey";
NSString *const GLAUCOMA_KEY = @"GlaucomaKey";
NSString *const PREGNANT_KEY = @"PregnantKey";
NSString *const ETOHAbuse_KEY = @"ETOHAbuseKey";
NSString *const DRUG_ABUSE_KEY = @"DrugAbuseKey";
NSString *const DIFFICULTIVAccess_KEY = @"DifficultIVAccessKey";
NSString *const EGA_KEY = @"EGAKey";
NSString *const EGAWeeks_KEY = @"EGAWeeksKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:EVAL_OTHER_KEY]){
				 [self.evalOtherBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:EVAL_OTHER_NEGATIVE_KEY]){
				 [self.evalOtherNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OBESITY_KEY]){
				 [self.obesityBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DEPRESSION_KEY]){
				 [self.depressionBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:GLAUCOMA_KEY]){
				 [self.glaucomaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PREGNANT_KEY]){
				 [self.pregnantBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ETOHAbuse_KEY]){
				 [self.eTOHAbuseBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DRUG_ABUSE_KEY]){
				 [self.drugAbuseBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DIFFICULTIVAccess_KEY]){
				 [self.difficultIVAccessBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:EGA_KEY]){
				 [self.eGABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:EGAWeeks_KEY]){
				 [self.eGAWeeksUITextField setText:((TextElement*)element).value];
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
	 NSAssert([group getElementForKey:EVAL_OTHER_KEY]!= nil, @"EvalOther is nil");
	 NSAssert([group getElementForKey:EVAL_OTHER_NEGATIVE_KEY]!= nil, @"EvalOtherNegative is nil");
	 NSAssert([group getElementForKey:OBESITY_KEY]!= nil, @"Obesity is nil");
	 NSAssert([group getElementForKey:DEPRESSION_KEY]!= nil, @"Depression is nil");
	 NSAssert([group getElementForKey:GLAUCOMA_KEY]!= nil, @"Glaucoma is nil");
	 NSAssert([group getElementForKey:PREGNANT_KEY]!= nil, @"Pregnant is nil");
	 NSAssert([group getElementForKey:ETOHAbuse_KEY]!= nil, @"ETOHAbuse is nil");
	 NSAssert([group getElementForKey:DRUG_ABUSE_KEY]!= nil, @"DrugAbuse is nil");
	 NSAssert([group getElementForKey:DIFFICULTIVAccess_KEY]!= nil, @"DifficultIVAccess is nil");
	 NSAssert([group getElementForKey:EGA_KEY]!= nil, @"EGA is nil");
	 NSAssert([group getElementForKey:EGAWeeks_KEY]!= nil, @"EGAWeeks is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = EVAL_OTHER_SECTION_TITLE;
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
	 BooleanFormElement *evalOther = (BooleanFormElement*)[group getElementForKey:EVAL_OTHER_KEY];
	 if (!evalOther) {
		 evalOther = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 evalOther.key = EVAL_OTHER_KEY;
		 [group addElementsObject:evalOther];
	 }

	 evalOther.value = [NSNumber numberWithBool:self.evalOtherBBCheckBox.isSelected];
	 
	 BooleanFormElement *evalOtherNegative = (BooleanFormElement*)[group getElementForKey:EVAL_OTHER_NEGATIVE_KEY];
	 if (!evalOtherNegative) {
		 evalOtherNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 evalOtherNegative.key = EVAL_OTHER_NEGATIVE_KEY;
		 [group addElementsObject:evalOtherNegative];
	 }

	 evalOtherNegative.value = [NSNumber numberWithBool:self.evalOtherNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *obesity = (BooleanFormElement*)[group getElementForKey:OBESITY_KEY];
	 if (!obesity) {
		 obesity = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 obesity.key = OBESITY_KEY;
		 [group addElementsObject:obesity];
	 }

	 obesity.value = [NSNumber numberWithBool:self.obesityBBCheckBox.isSelected];
	 
	 BooleanFormElement *depression = (BooleanFormElement*)[group getElementForKey:DEPRESSION_KEY];
	 if (!depression) {
		 depression = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 depression.key = DEPRESSION_KEY;
		 [group addElementsObject:depression];
	 }

	 depression.value = [NSNumber numberWithBool:self.depressionBBCheckBox.isSelected];
	 
	 BooleanFormElement *glaucoma = (BooleanFormElement*)[group getElementForKey:GLAUCOMA_KEY];
	 if (!glaucoma) {
		 glaucoma = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 glaucoma.key = GLAUCOMA_KEY;
		 [group addElementsObject:glaucoma];
	 }

	 glaucoma.value = [NSNumber numberWithBool:self.glaucomaBBCheckBox.isSelected];
	 
	 BooleanFormElement *pregnant = (BooleanFormElement*)[group getElementForKey:PREGNANT_KEY];
	 if (!pregnant) {
		 pregnant = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pregnant.key = PREGNANT_KEY;
		 [group addElementsObject:pregnant];
	 }

	 pregnant.value = [NSNumber numberWithBool:self.pregnantBBCheckBox.isSelected];
	 
	 BooleanFormElement *eTOHAbuse = (BooleanFormElement*)[group getElementForKey:ETOHAbuse_KEY];
	 if (!eTOHAbuse) {
		 eTOHAbuse = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 eTOHAbuse.key = ETOHAbuse_KEY;
		 [group addElementsObject:eTOHAbuse];
	 }

	 eTOHAbuse.value = [NSNumber numberWithBool:self.eTOHAbuseBBCheckBox.isSelected];
	 
	 BooleanFormElement *drugAbuse = (BooleanFormElement*)[group getElementForKey:DRUG_ABUSE_KEY];
	 if (!drugAbuse) {
		 drugAbuse = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 drugAbuse.key = DRUG_ABUSE_KEY;
		 [group addElementsObject:drugAbuse];
	 }

	 drugAbuse.value = [NSNumber numberWithBool:self.drugAbuseBBCheckBox.isSelected];
	 
	 BooleanFormElement *difficultIVAccess = (BooleanFormElement*)[group getElementForKey:DIFFICULTIVAccess_KEY];
	 if (!difficultIVAccess) {
		 difficultIVAccess = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 difficultIVAccess.key = DIFFICULTIVAccess_KEY;
		 [group addElementsObject:difficultIVAccess];
	 }

	 difficultIVAccess.value = [NSNumber numberWithBool:self.difficultIVAccessBBCheckBox.isSelected];
	 
	 BooleanFormElement *eGA = (BooleanFormElement*)[group getElementForKey:EGA_KEY];
	 if (!eGA) {
		 eGA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 eGA.key = EGA_KEY;
		 [group addElementsObject:eGA];
	 }

	 eGA.value = [NSNumber numberWithBool:self.eGABBCheckBox.isSelected];
	 
	 TextElement *eGAWeeks = (TextElement*)[group getElementForKey:EGAWeeks_KEY];
	 if (!eGAWeeks) {
		 eGAWeeks = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 eGAWeeks.key = EGAWeeks_KEY;
		 [group addElementsObject:eGAWeeks];
	 }

	 eGAWeeks.value = self.eGAWeeksUITextField.text;
	 
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
	 return EVAL_OTHER_SECTION_TITLE;
}
@end