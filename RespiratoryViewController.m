
#import "RespiratoryViewController.h"
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


@interface RespiratoryViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *respiratoryBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *respiratoryNoneBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *homeO2BBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cOPDBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *cPAPBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *recentURIBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *asthmaBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *sleepApneaBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *smokingBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *pPDUITextField;
@property (weak, nonatomic) IBOutlet UITextField *yRSUITextField;
@property (weak, nonatomic) IBOutlet UITextField *quitAmountAgoUITextField;
@end

@implementation RespiratoryViewController
NSString *const RESPIRATORY_SECTION_TITLE = @"RespiratorySectionKey";
static NSString *const RESPIRATORY_KEY = @"RespiratoryKey";
static NSString *const RESPIRATORY_NONE_KEY = @"RespiratoryNoneKey";
static NSString *const HOMEO2_KEY = @"HomeO2Key";
static NSString *const COPD_KEY = @"COPDKey";
static NSString *const CPAP_KEY = @"CPAPKey";
static NSString *const RECENTURI_KEY = @"RecentURIKey";
static NSString *const ASTHMA_KEY = @"AsthmaKey";
static NSString *const SLEEP_APNEA_KEY = @"SleepApneaKey";
static NSString *const SMOKING_KEY = @"SmokingKey";
static NSString *const PPD_KEY = @"PPDKey";
static NSString *const YRS_KEY = @"YRSKey";
static NSString *const QUIT_AMOUNT_AGO_KEY = @"QuitAmountAgoKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:RESPIRATORY_KEY]){
				 [self.respiratoryBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RESPIRATORY_NONE_KEY]){
				 [self.respiratoryNoneBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HOMEO2_KEY]){
				 [self.homeO2BBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:COPD_KEY]){
				 [self.cOPDBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CPAP_KEY]){
				 [self.cPAPBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:RECENTURI_KEY]){
				 [self.recentURIBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ASTHMA_KEY]){
				 [self.asthmaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SLEEP_APNEA_KEY]){
				 [self.sleepApneaBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SMOKING_KEY]){
				 [self.smokingBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PPD_KEY]){
				 [self.pPDUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:YRS_KEY]){
				 [self.yRSUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:QUIT_AMOUNT_AGO_KEY]){
				 [self.quitAmountAgoUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:RESPIRATORY_KEY]!= nil, @"Respiratory is nil");
	 NSAssert([section getElementForKey:RESPIRATORY_NONE_KEY]!= nil, @"RespiratoryNone is nil");
	 NSAssert([section getElementForKey:HOMEO2_KEY]!= nil, @"HomeO2 is nil");
	 NSAssert([section getElementForKey:COPD_KEY]!= nil, @"COPD is nil");
	 NSAssert([section getElementForKey:CPAP_KEY]!= nil, @"CPAP is nil");
	 NSAssert([section getElementForKey:RECENTURI_KEY]!= nil, @"RecentURI is nil");
	 NSAssert([section getElementForKey:ASTHMA_KEY]!= nil, @"Asthma is nil");
	 NSAssert([section getElementForKey:SLEEP_APNEA_KEY]!= nil, @"SleepApnea is nil");
	 NSAssert([section getElementForKey:SMOKING_KEY]!= nil, @"Smoking is nil");
	 NSAssert([section getElementForKey:PPD_KEY]!= nil, @"PPD is nil");
	 NSAssert([section getElementForKey:YRS_KEY]!= nil, @"YRS is nil");
	 NSAssert([section getElementForKey:QUIT_AMOUNT_AGO_KEY]!= nil, @"QuitAmountAgo is nil");
	 
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
		 self.section.title = RESPIRATORY_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *respiratory = (BooleanFormElement*)[_section getElementForKey:RESPIRATORY_KEY];
	 if (!respiratory) {
		 respiratory = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 respiratory.key = RESPIRATORY_KEY;
		 [_section addElementsObject:respiratory];
	 }

	 respiratory.value = [NSNumber numberWithBool:self.respiratoryBBCheckBox.isSelected];
	 
	 BooleanFormElement *respiratoryNone = (BooleanFormElement*)[_section getElementForKey:RESPIRATORY_NONE_KEY];
	 if (!respiratoryNone) {
		 respiratoryNone = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 respiratoryNone.key = RESPIRATORY_NONE_KEY;
		 [_section addElementsObject:respiratoryNone];
	 }

	 respiratoryNone.value = [NSNumber numberWithBool:self.respiratoryNoneBBCheckBox.isSelected];
	 
	 BooleanFormElement *homeO2 = (BooleanFormElement*)[_section getElementForKey:HOMEO2_KEY];
	 if (!homeO2) {
		 homeO2 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 homeO2.key = HOMEO2_KEY;
		 [_section addElementsObject:homeO2];
	 }

	 homeO2.value = [NSNumber numberWithBool:self.homeO2BBCheckBox.isSelected];
	 
	 BooleanFormElement *cOPD = (BooleanFormElement*)[_section getElementForKey:COPD_KEY];
	 if (!cOPD) {
		 cOPD = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cOPD.key = COPD_KEY;
		 [_section addElementsObject:cOPD];
	 }

	 cOPD.value = [NSNumber numberWithBool:self.cOPDBBCheckBox.isSelected];
	 
	 BooleanFormElement *cPAP = (BooleanFormElement*)[_section getElementForKey:CPAP_KEY];
	 if (!cPAP) {
		 cPAP = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cPAP.key = CPAP_KEY;
		 [_section addElementsObject:cPAP];
	 }

	 cPAP.value = [NSNumber numberWithBool:self.cPAPBBCheckBox.isSelected];
	 
	 BooleanFormElement *recentURI = (BooleanFormElement*)[_section getElementForKey:RECENTURI_KEY];
	 if (!recentURI) {
		 recentURI = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 recentURI.key = RECENTURI_KEY;
		 [_section addElementsObject:recentURI];
	 }

	 recentURI.value = [NSNumber numberWithBool:self.recentURIBBCheckBox.isSelected];
	 
	 BooleanFormElement *asthma = (BooleanFormElement*)[_section getElementForKey:ASTHMA_KEY];
	 if (!asthma) {
		 asthma = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 asthma.key = ASTHMA_KEY;
		 [_section addElementsObject:asthma];
	 }

	 asthma.value = [NSNumber numberWithBool:self.asthmaBBCheckBox.isSelected];
	 
	 BooleanFormElement *sleepApnea = (BooleanFormElement*)[_section getElementForKey:SLEEP_APNEA_KEY];
	 if (!sleepApnea) {
		 sleepApnea = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 sleepApnea.key = SLEEP_APNEA_KEY;
		 [_section addElementsObject:sleepApnea];
	 }

	 sleepApnea.value = [NSNumber numberWithBool:self.sleepApneaBBCheckBox.isSelected];
	 
	 BooleanFormElement *smoking = (BooleanFormElement*)[_section getElementForKey:SMOKING_KEY];
	 if (!smoking) {
		 smoking = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 smoking.key = SMOKING_KEY;
		 [_section addElementsObject:smoking];
	 }

	 smoking.value = [NSNumber numberWithBool:self.smokingBBCheckBox.isSelected];
	 
	 TextElement *pPD = (TextElement*)[_section getElementForKey:PPD_KEY];
	 if (!pPD) {
		 pPD = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 pPD.key = PPD_KEY;
		 [_section addElementsObject:pPD];
	 }

	 pPD.value = self.pPDUITextField.text;
	 
	 TextElement *yRS = (TextElement*)[_section getElementForKey:YRS_KEY];
	 if (!yRS) {
		 yRS = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 yRS.key = YRS_KEY;
		 [_section addElementsObject:yRS];
	 }

	 yRS.value = self.yRSUITextField.text;
	 
	 TextElement *quitAmountAgo = (TextElement*)[_section getElementForKey:QUIT_AMOUNT_AGO_KEY];
	 if (!quitAmountAgo) {
		 quitAmountAgo = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 quitAmountAgo.key = QUIT_AMOUNT_AGO_KEY;
		 [_section addElementsObject:quitAmountAgo];
	 }

	 quitAmountAgo.value = self.quitAmountAgoUITextField.text;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
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
	 return RESPIRATORY_SECTION_TITLE;
}
@end