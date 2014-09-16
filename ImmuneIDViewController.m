#import "ImmuneIDViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface ImmuneIDViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *immuneIDBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *immuneIDNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *rheumArtBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hIVBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *autoImmuneDiseaseBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *ongoingInfectionBBCheckBox;
@end

@implementation ImmuneIDViewController
NSString *const IMMUNEID_SECTION_TITLE = @"ImmuneIDSectionKey";
NSString *const IMMUNEID_KEY = @"ImmuneIDKey";
NSString *const IMMUNEIDNegative_KEY = @"ImmuneIDNegativeKey";
NSString *const RHEUM_ART_KEY = @"RheumArtKey";
NSString *const HIV_KEY = @"HIVKey";
NSString *const AUTO_IMMUNE_DISEASE_KEY = @"AutoImmuneDiseaseKey";
NSString *const ONGOING_INFECTION_KEY = @"OngoingInfectionKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:IMMUNEID_KEY]){
				 [self.immuneIDBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:IMMUNEIDNegative_KEY]){
				 [self.immuneIDNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RHEUM_ART_KEY]){
				 [self.rheumArtBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HIV_KEY]){
				 [self.hIVBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:AUTO_IMMUNE_DISEASE_KEY]){
				 [self.autoImmuneDiseaseBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ONGOING_INFECTION_KEY]){
				 [self.ongoingInfectionBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
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
	 NSAssert([group getElementForKey:IMMUNEID_KEY]!= nil, @"ImmuneID is nil");
	 NSAssert([group getElementForKey:IMMUNEIDNegative_KEY]!= nil, @"ImmuneIDNegative is nil");
	 NSAssert([group getElementForKey:RHEUM_ART_KEY]!= nil, @"RheumArt is nil");
	 NSAssert([group getElementForKey:HIV_KEY]!= nil, @"HIV is nil");
	 NSAssert([group getElementForKey:AUTO_IMMUNE_DISEASE_KEY]!= nil, @"AutoImmuneDisease is nil");
	 NSAssert([group getElementForKey:ONGOING_INFECTION_KEY]!= nil, @"OngoingInfection is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = IMMUNEID_SECTION_TITLE;
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
	 BooleanFormElement *immuneID = (BooleanFormElement*)[group getElementForKey:IMMUNEID_KEY];
	 if (!immuneID) {
		 immuneID = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 immuneID.key = IMMUNEID_KEY;
		 [group addElementsObject:immuneID];
	 }

	 immuneID.value = [NSNumber numberWithBool:self.immuneIDBBCheckBox.isSelected];
	 
	 BooleanFormElement *immuneIDNegative = (BooleanFormElement*)[group getElementForKey:IMMUNEIDNegative_KEY];
	 if (!immuneIDNegative) {
		 immuneIDNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 immuneIDNegative.key = IMMUNEIDNegative_KEY;
		 [group addElementsObject:immuneIDNegative];
	 }

	 immuneIDNegative.value = [NSNumber numberWithBool:self.immuneIDNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *rheumArt = (BooleanFormElement*)[group getElementForKey:RHEUM_ART_KEY];
	 if (!rheumArt) {
		 rheumArt = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 rheumArt.key = RHEUM_ART_KEY;
		 [group addElementsObject:rheumArt];
	 }

	 rheumArt.value = [NSNumber numberWithBool:self.rheumArtBBCheckBox.isSelected];
	 
	 BooleanFormElement *hIV = (BooleanFormElement*)[group getElementForKey:HIV_KEY];
	 if (!hIV) {
		 hIV = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hIV.key = HIV_KEY;
		 [group addElementsObject:hIV];
	 }

	 hIV.value = [NSNumber numberWithBool:self.hIVBBCheckBox.isSelected];
	 
	 BooleanFormElement *autoImmuneDisease = (BooleanFormElement*)[group getElementForKey:AUTO_IMMUNE_DISEASE_KEY];
	 if (!autoImmuneDisease) {
		 autoImmuneDisease = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 autoImmuneDisease.key = AUTO_IMMUNE_DISEASE_KEY;
		 [group addElementsObject:autoImmuneDisease];
	 }

	 autoImmuneDisease.value = [NSNumber numberWithBool:self.autoImmuneDiseaseBBCheckBox.isSelected];
	 
	 BooleanFormElement *ongoingInfection = (BooleanFormElement*)[group getElementForKey:ONGOING_INFECTION_KEY];
	 if (!ongoingInfection) {
		 ongoingInfection = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 ongoingInfection.key = ONGOING_INFECTION_KEY;
		 [group addElementsObject:ongoingInfection];
	 }

	 ongoingInfection.value = [NSNumber numberWithBool:self.ongoingInfectionBBCheckBox.isSelected];
	 
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
	 return IMMUNEID_SECTION_TITLE;
}
@end