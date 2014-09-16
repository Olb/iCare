#import "CardioViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface CardioViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *cardioVascularBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cardioNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *functionalCapacityLessThanFourMetsBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hTNBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *dyslipidemiaBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cHFBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *pVDBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *aICDBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cADBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *mIBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *pTCABBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *coronaryStentsBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *dysrhythmiaBBCheckBox;
@end

@implementation CardioViewController
NSString *const CARDIO_SECTION_TITLE = @"CardioSectionKey";
NSString *const CARDIO_VASCULAR_KEY = @"CardioVascularKey";
NSString *const CARDIO_NEGATIVE_KEY = @"CardioNegativeKey";
NSString *const FUNCTIONAL_CAPACITY_LESS_THAN_FOUR_METS_KEY = @"FunctionalCapacityLessThanFourMetsKey";
NSString *const HTN_KEY = @"HTNKey";
NSString *const DYSLIPIDEMIA_KEY = @"DyslipidemiaKey";
NSString *const CHF_KEY = @"CHFKey";
NSString *const PVD_KEY = @"PVDKey";
NSString *const AICD_KEY = @"AICDKey";
NSString *const CAD_KEY = @"CADKey";
NSString *const MI_KEY = @"MIKey";
NSString *const PTCA_KEY = @"PTCAKey";
NSString *const CORONARY_STENTS_KEY = @"CoronaryStentsKey";
NSString *const DYSRHYTHMIA_KEY = @"DysrhythmiaKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:CARDIO_VASCULAR_KEY]){
				 [self.cardioVascularBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CARDIO_NEGATIVE_KEY]){
				 [self.cardioNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:FUNCTIONAL_CAPACITY_LESS_THAN_FOUR_METS_KEY]){
				 [self.functionalCapacityLessThanFourMetsBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HTN_KEY]){
				 [self.hTNBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DYSLIPIDEMIA_KEY]){
				 [self.dyslipidemiaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CHF_KEY]){
				 [self.cHFBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PVD_KEY]){
				 [self.pVDBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:AICD_KEY]){
				 [self.aICDBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CAD_KEY]){
				 [self.cADBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MI_KEY]){
				 [self.mIBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PTCA_KEY]){
				 [self.pTCABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CORONARY_STENTS_KEY]){
				 [self.coronaryStentsBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DYSRHYTHMIA_KEY]){
				 [self.dysrhythmiaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
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
	 NSAssert([group getElementForKey:CARDIO_VASCULAR_KEY]!= nil, @"CardioVascular is nil");
	 NSAssert([group getElementForKey:CARDIO_NEGATIVE_KEY]!= nil, @"CardioNegative is nil");
	 NSAssert([group getElementForKey:FUNCTIONAL_CAPACITY_LESS_THAN_FOUR_METS_KEY]!= nil, @"FunctionalCapacityLessThanFourMets is nil");
	 NSAssert([group getElementForKey:HTN_KEY]!= nil, @"HTN is nil");
	 NSAssert([group getElementForKey:DYSLIPIDEMIA_KEY]!= nil, @"Dyslipidemia is nil");
	 NSAssert([group getElementForKey:CHF_KEY]!= nil, @"CHF is nil");
	 NSAssert([group getElementForKey:PVD_KEY]!= nil, @"PVD is nil");
	 NSAssert([group getElementForKey:AICD_KEY]!= nil, @"AICD is nil");
	 NSAssert([group getElementForKey:CAD_KEY]!= nil, @"CAD is nil");
	 NSAssert([group getElementForKey:MI_KEY]!= nil, @"MI is nil");
	 NSAssert([group getElementForKey:PTCA_KEY]!= nil, @"PTCA is nil");
	 NSAssert([group getElementForKey:CORONARY_STENTS_KEY]!= nil, @"CoronaryStents is nil");
	 NSAssert([group getElementForKey:DYSRHYTHMIA_KEY]!= nil, @"Dysrhythmia is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = CARDIO_SECTION_TITLE;
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
	 BooleanFormElement *cardioVascular = (BooleanFormElement*)[group getElementForKey:CARDIO_VASCULAR_KEY];
	 if (!cardioVascular) {
		 cardioVascular = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cardioVascular.key = CARDIO_VASCULAR_KEY;
		 [group addElementsObject:cardioVascular];
	 }

	 cardioVascular.value = [NSNumber numberWithBool:self.cardioVascularBBCheckBox.isSelected];
	 
	 BooleanFormElement *cardioNegative = (BooleanFormElement*)[group getElementForKey:CARDIO_NEGATIVE_KEY];
	 if (!cardioNegative) {
		 cardioNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cardioNegative.key = CARDIO_NEGATIVE_KEY;
		 [group addElementsObject:cardioNegative];
	 }

	 cardioNegative.value = [NSNumber numberWithBool:self.cardioNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *functionalCapacityLessThanFourMets = (BooleanFormElement*)[group getElementForKey:FUNCTIONAL_CAPACITY_LESS_THAN_FOUR_METS_KEY];
	 if (!functionalCapacityLessThanFourMets) {
		 functionalCapacityLessThanFourMets = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 functionalCapacityLessThanFourMets.key = FUNCTIONAL_CAPACITY_LESS_THAN_FOUR_METS_KEY;
		 [group addElementsObject:functionalCapacityLessThanFourMets];
	 }

	 functionalCapacityLessThanFourMets.value = [NSNumber numberWithBool:self.functionalCapacityLessThanFourMetsBBCheckBox.isSelected];
	 
	 BooleanFormElement *hTN = (BooleanFormElement*)[group getElementForKey:HTN_KEY];
	 if (!hTN) {
		 hTN = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hTN.key = HTN_KEY;
		 [group addElementsObject:hTN];
	 }

	 hTN.value = [NSNumber numberWithBool:self.hTNBBCheckBox.isSelected];
	 
	 BooleanFormElement *dyslipidemia = (BooleanFormElement*)[group getElementForKey:DYSLIPIDEMIA_KEY];
	 if (!dyslipidemia) {
		 dyslipidemia = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 dyslipidemia.key = DYSLIPIDEMIA_KEY;
		 [group addElementsObject:dyslipidemia];
	 }

	 dyslipidemia.value = [NSNumber numberWithBool:self.dyslipidemiaBBCheckBox.isSelected];
	 
	 BooleanFormElement *cHF = (BooleanFormElement*)[group getElementForKey:CHF_KEY];
	 if (!cHF) {
		 cHF = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cHF.key = CHF_KEY;
		 [group addElementsObject:cHF];
	 }

	 cHF.value = [NSNumber numberWithBool:self.cHFBBCheckBox.isSelected];
	 
	 BooleanFormElement *pVD = (BooleanFormElement*)[group getElementForKey:PVD_KEY];
	 if (!pVD) {
		 pVD = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pVD.key = PVD_KEY;
		 [group addElementsObject:pVD];
	 }

	 pVD.value = [NSNumber numberWithBool:self.pVDBBCheckBox.isSelected];
	 
	 BooleanFormElement *aICD = (BooleanFormElement*)[group getElementForKey:AICD_KEY];
	 if (!aICD) {
		 aICD = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aICD.key = AICD_KEY;
		 [group addElementsObject:aICD];
	 }

	 aICD.value = [NSNumber numberWithBool:self.aICDBBCheckBox.isSelected];
	 
	 BooleanFormElement *cAD = (BooleanFormElement*)[group getElementForKey:CAD_KEY];
	 if (!cAD) {
		 cAD = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cAD.key = CAD_KEY;
		 [group addElementsObject:cAD];
	 }

	 cAD.value = [NSNumber numberWithBool:self.cADBBCheckBox.isSelected];
	 
	 BooleanFormElement *mI = (BooleanFormElement*)[group getElementForKey:MI_KEY];
	 if (!mI) {
		 mI = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 mI.key = MI_KEY;
		 [group addElementsObject:mI];
	 }

	 mI.value = [NSNumber numberWithBool:self.mIBBCheckBox.isSelected];
	 
	 BooleanFormElement *pTCA = (BooleanFormElement*)[group getElementForKey:PTCA_KEY];
	 if (!pTCA) {
		 pTCA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pTCA.key = PTCA_KEY;
		 [group addElementsObject:pTCA];
	 }

	 pTCA.value = [NSNumber numberWithBool:self.pTCABBCheckBox.isSelected];
	 
	 BooleanFormElement *coronaryStents = (BooleanFormElement*)[group getElementForKey:CORONARY_STENTS_KEY];
	 if (!coronaryStents) {
		 coronaryStents = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 coronaryStents.key = CORONARY_STENTS_KEY;
		 [group addElementsObject:coronaryStents];
	 }

	 coronaryStents.value = [NSNumber numberWithBool:self.coronaryStentsBBCheckBox.isSelected];
	 
	 BooleanFormElement *dysrhythmia = (BooleanFormElement*)[group getElementForKey:DYSRHYTHMIA_KEY];
	 if (!dysrhythmia) {
		 dysrhythmia = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 dysrhythmia.key = DYSRHYTHMIA_KEY;
		 [group addElementsObject:dysrhythmia];
	 }

	 dysrhythmia.value = [NSNumber numberWithBool:self.dysrhythmiaBBCheckBox.isSelected];
	 
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
	 return CARDIO_SECTION_TITLE;
}
@end