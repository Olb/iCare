#import "HepatoViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface HepatoViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *gIHepaticBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *gIHepaticNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *gERDBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cirrhosisBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hepatitisBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *obstructionBBCheckBox;
@end

@implementation HepatoViewController
NSString *const HEPATO_SECTION_TITLE = @"HepatoSectionKey";
NSString *const GIHepatic_KEY = @"GIHepaticKey";
NSString *const GIHepatic_NEGATIVE_KEY = @"GIHepaticNegativeKey";
NSString *const GERD_KEY = @"GERDKey";
NSString *const CIRRHOSIS_KEY = @"CirrhosisKey";
NSString *const HEPATITIS_KEY = @"HepatitisKey";
NSString *const OBSTRUCTION_KEY = @"ObstructionKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

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
	 NSAssert([group getElementForKey:GIHepatic_KEY]!= nil, @"GIHepatic is nil");
	 NSAssert([group getElementForKey:GIHepatic_NEGATIVE_KEY]!= nil, @"GIHepaticNegative is nil");
	 NSAssert([group getElementForKey:GERD_KEY]!= nil, @"GERD is nil");
	 NSAssert([group getElementForKey:CIRRHOSIS_KEY]!= nil, @"Cirrhosis is nil");
	 NSAssert([group getElementForKey:HEPATITIS_KEY]!= nil, @"Hepatitis is nil");
	 NSAssert([group getElementForKey:OBSTRUCTION_KEY]!= nil, @"Obstruction is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = HEPATO_SECTION_TITLE;
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
	 BooleanFormElement *gIHepatic = (BooleanFormElement*)[group getElementForKey:GIHepatic_KEY];
	 if (!gIHepatic) {
		 gIHepatic = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 gIHepatic.key = GIHepatic_KEY;
		 [group addElementsObject:gIHepatic];
	 }

	 gIHepatic.value = [NSNumber numberWithBool:self.gIHepaticBBCheckBox.isSelected];
	 
	 BooleanFormElement *gIHepaticNegative = (BooleanFormElement*)[group getElementForKey:GIHepatic_NEGATIVE_KEY];
	 if (!gIHepaticNegative) {
		 gIHepaticNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 gIHepaticNegative.key = GIHepatic_NEGATIVE_KEY;
		 [group addElementsObject:gIHepaticNegative];
	 }

	 gIHepaticNegative.value = [NSNumber numberWithBool:self.gIHepaticNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *gERD = (BooleanFormElement*)[group getElementForKey:GERD_KEY];
	 if (!gERD) {
		 gERD = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 gERD.key = GERD_KEY;
		 [group addElementsObject:gERD];
	 }

	 gERD.value = [NSNumber numberWithBool:self.gERDBBCheckBox.isSelected];
	 
	 BooleanFormElement *cirrhosis = (BooleanFormElement*)[group getElementForKey:CIRRHOSIS_KEY];
	 if (!cirrhosis) {
		 cirrhosis = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cirrhosis.key = CIRRHOSIS_KEY;
		 [group addElementsObject:cirrhosis];
	 }

	 cirrhosis.value = [NSNumber numberWithBool:self.cirrhosisBBCheckBox.isSelected];
	 
	 BooleanFormElement *hepatitis = (BooleanFormElement*)[group getElementForKey:HEPATITIS_KEY];
	 if (!hepatitis) {
		 hepatitis = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hepatitis.key = HEPATITIS_KEY;
		 [group addElementsObject:hepatitis];
	 }

	 hepatitis.value = [NSNumber numberWithBool:self.hepatitisBBCheckBox.isSelected];
	 
	 BooleanFormElement *obstruction = (BooleanFormElement*)[group getElementForKey:OBSTRUCTION_KEY];
	 if (!obstruction) {
		 obstruction = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 obstruction.key = OBSTRUCTION_KEY;
		 [group addElementsObject:obstruction];
	 }

	 obstruction.value = [NSNumber numberWithBool:self.obstructionBBCheckBox.isSelected];
	 
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
	 return HEPATO_SECTION_TITLE;
}
@end