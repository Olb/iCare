
#import "ImmuneIDViewController.h"
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
static NSString *const IMMUNEID_KEY = @"ImmuneIDKey";
static NSString *const IMMUNEIDNegative_KEY = @"ImmuneIDNegativeKey";
static NSString *const RHEUM_ART_KEY = @"RheumArtKey";
static NSString *const HIV_KEY = @"HIVKey";
static NSString *const AUTO_IMMUNE_DISEASE_KEY = @"AutoImmuneDiseaseKey";
static NSString *const ONGOING_INFECTION_KEY = @"OngoingInfectionKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

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
	 NSAssert([section getElementForKey:IMMUNEID_KEY]!= nil, @"ImmuneID is nil");
	 NSAssert([section getElementForKey:IMMUNEIDNegative_KEY]!= nil, @"ImmuneIDNegative is nil");
	 NSAssert([section getElementForKey:RHEUM_ART_KEY]!= nil, @"RheumArt is nil");
	 NSAssert([section getElementForKey:HIV_KEY]!= nil, @"HIV is nil");
	 NSAssert([section getElementForKey:AUTO_IMMUNE_DISEASE_KEY]!= nil, @"AutoImmuneDisease is nil");
	 NSAssert([section getElementForKey:ONGOING_INFECTION_KEY]!= nil, @"OngoingInfection is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = IMMUNEID_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *immuneID = (BooleanFormElement*)[_section getElementForKey:IMMUNEID_KEY];
	 if (!immuneID) {
		 immuneID = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 immuneID.key = IMMUNEID_KEY;
		 [_section addElementsObject:immuneID];
	 }

	 immuneID.value = [NSNumber numberWithBool:self.immuneIDBBCheckBox.isSelected];
	 
	 BooleanFormElement *immuneIDNegative = (BooleanFormElement*)[_section getElementForKey:IMMUNEIDNegative_KEY];
	 if (!immuneIDNegative) {
		 immuneIDNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 immuneIDNegative.key = IMMUNEIDNegative_KEY;
		 [_section addElementsObject:immuneIDNegative];
	 }

	 immuneIDNegative.value = [NSNumber numberWithBool:self.immuneIDNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *rheumArt = (BooleanFormElement*)[_section getElementForKey:RHEUM_ART_KEY];
	 if (!rheumArt) {
		 rheumArt = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 rheumArt.key = RHEUM_ART_KEY;
		 [_section addElementsObject:rheumArt];
	 }

	 rheumArt.value = [NSNumber numberWithBool:self.rheumArtBBCheckBox.isSelected];
	 
	 BooleanFormElement *hIV = (BooleanFormElement*)[_section getElementForKey:HIV_KEY];
	 if (!hIV) {
		 hIV = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hIV.key = HIV_KEY;
		 [_section addElementsObject:hIV];
	 }

	 hIV.value = [NSNumber numberWithBool:self.hIVBBCheckBox.isSelected];
	 
	 BooleanFormElement *autoImmuneDisease = (BooleanFormElement*)[_section getElementForKey:AUTO_IMMUNE_DISEASE_KEY];
	 if (!autoImmuneDisease) {
		 autoImmuneDisease = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 autoImmuneDisease.key = AUTO_IMMUNE_DISEASE_KEY;
		 [_section addElementsObject:autoImmuneDisease];
	 }

	 autoImmuneDisease.value = [NSNumber numberWithBool:self.autoImmuneDiseaseBBCheckBox.isSelected];
	 
	 BooleanFormElement *ongoingInfection = (BooleanFormElement*)[_section getElementForKey:ONGOING_INFECTION_KEY];
	 if (!ongoingInfection) {
		 ongoingInfection = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 ongoingInfection.key = ONGOING_INFECTION_KEY;
		 [_section addElementsObject:ongoingInfection];
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