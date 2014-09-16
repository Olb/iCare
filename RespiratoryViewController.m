#import "RespiratoryViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


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
NSString *const RESPIRATORY_KEY = @"RespiratoryKey";
NSString *const RESPIRATORY_NONE_KEY = @"RespiratoryNoneKey";
NSString *const HOMEO2_KEY = @"HomeO2Key";
NSString *const COPD_KEY = @"COPDKey";
NSString *const CPAP_KEY = @"CPAPKey";
NSString *const RECENTURI_KEY = @"RecentURIKey";
NSString *const ASTHMA_KEY = @"AsthmaKey";
NSString *const SLEEP_APNEA_KEY = @"SleepApneaKey";
NSString *const SMOKING_KEY = @"SmokingKey";
NSString *const PPD_KEY = @"PPDKey";
NSString *const YRS_KEY = @"YRSKey";
NSString *const QUIT_AMOUNT_AGO_KEY = @"QuitAmountAgoKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

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
	 int count;
	 NSString *errMsg;
	 
	 count = [_section.groups count];
	 errMsg =[NSString stringWithFormat:@"Invalid number of groups '%d'. Expected '1'.", count];
	 NSAssert(count, errMsg);
	 
	 FormGroup *group;
	 
	 group = [_section.groups objectAtIndex:0];
	 NSAssert([group getElementForKey:RESPIRATORY_KEY]!= nil, @"Respiratory is nil");
	 NSAssert([group getElementForKey:RESPIRATORY_NONE_KEY]!= nil, @"RespiratoryNone is nil");
	 NSAssert([group getElementForKey:HOMEO2_KEY]!= nil, @"HomeO2 is nil");
	 NSAssert([group getElementForKey:COPD_KEY]!= nil, @"COPD is nil");
	 NSAssert([group getElementForKey:CPAP_KEY]!= nil, @"CPAP is nil");
	 NSAssert([group getElementForKey:RECENTURI_KEY]!= nil, @"RecentURI is nil");
	 NSAssert([group getElementForKey:ASTHMA_KEY]!= nil, @"Asthma is nil");
	 NSAssert([group getElementForKey:SLEEP_APNEA_KEY]!= nil, @"SleepApnea is nil");
	 NSAssert([group getElementForKey:SMOKING_KEY]!= nil, @"Smoking is nil");
	 NSAssert([group getElementForKey:PPD_KEY]!= nil, @"PPD is nil");
	 NSAssert([group getElementForKey:YRS_KEY]!= nil, @"YRS is nil");
	 NSAssert([group getElementForKey:QUIT_AMOUNT_AGO_KEY]!= nil, @"QuitAmountAgo is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = RESPIRATORY_SECTION_TITLE;
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
	 BooleanFormElement *respiratory = (BooleanFormElement*)[group getElementForKey:RESPIRATORY_KEY];
	 if (!respiratory) {
		 respiratory = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 respiratory.key = RESPIRATORY_KEY;
		 [group addElementsObject:respiratory];
	 }

	 respiratory.value = [NSNumber numberWithBool:self.respiratoryBBCheckBox.isSelected];
	 
	 BooleanFormElement *respiratoryNone = (BooleanFormElement*)[group getElementForKey:RESPIRATORY_NONE_KEY];
	 if (!respiratoryNone) {
		 respiratoryNone = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 respiratoryNone.key = RESPIRATORY_NONE_KEY;
		 [group addElementsObject:respiratoryNone];
	 }

	 respiratoryNone.value = [NSNumber numberWithBool:self.respiratoryNoneBBCheckBox.isSelected];
	 
	 BooleanFormElement *homeO2 = (BooleanFormElement*)[group getElementForKey:HOMEO2_KEY];
	 if (!homeO2) {
		 homeO2 = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 homeO2.key = HOMEO2_KEY;
		 [group addElementsObject:homeO2];
	 }

	 homeO2.value = [NSNumber numberWithBool:self.homeO2BBCheckBox.isSelected];
	 
	 BooleanFormElement *cOPD = (BooleanFormElement*)[group getElementForKey:COPD_KEY];
	 if (!cOPD) {
		 cOPD = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cOPD.key = COPD_KEY;
		 [group addElementsObject:cOPD];
	 }

	 cOPD.value = [NSNumber numberWithBool:self.cOPDBBCheckBox.isSelected];
	 
	 BooleanFormElement *cPAP = (BooleanFormElement*)[group getElementForKey:CPAP_KEY];
	 if (!cPAP) {
		 cPAP = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cPAP.key = CPAP_KEY;
		 [group addElementsObject:cPAP];
	 }

	 cPAP.value = [NSNumber numberWithBool:self.cPAPBBCheckBox.isSelected];
	 
	 BooleanFormElement *recentURI = (BooleanFormElement*)[group getElementForKey:RECENTURI_KEY];
	 if (!recentURI) {
		 recentURI = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 recentURI.key = RECENTURI_KEY;
		 [group addElementsObject:recentURI];
	 }

	 recentURI.value = [NSNumber numberWithBool:self.recentURIBBCheckBox.isSelected];
	 
	 BooleanFormElement *asthma = (BooleanFormElement*)[group getElementForKey:ASTHMA_KEY];
	 if (!asthma) {
		 asthma = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 asthma.key = ASTHMA_KEY;
		 [group addElementsObject:asthma];
	 }

	 asthma.value = [NSNumber numberWithBool:self.asthmaBBCheckBox.isSelected];
	 
	 BooleanFormElement *sleepApnea = (BooleanFormElement*)[group getElementForKey:SLEEP_APNEA_KEY];
	 if (!sleepApnea) {
		 sleepApnea = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 sleepApnea.key = SLEEP_APNEA_KEY;
		 [group addElementsObject:sleepApnea];
	 }

	 sleepApnea.value = [NSNumber numberWithBool:self.sleepApneaBBCheckBox.isSelected];
	 
	 BooleanFormElement *smoking = (BooleanFormElement*)[group getElementForKey:SMOKING_KEY];
	 if (!smoking) {
		 smoking = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 smoking.key = SMOKING_KEY;
		 [group addElementsObject:smoking];
	 }

	 smoking.value = [NSNumber numberWithBool:self.smokingBBCheckBox.isSelected];
	 
	 TextElement *pPD = (TextElement*)[group getElementForKey:PPD_KEY];
	 if (!pPD) {
		 pPD = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 pPD.key = PPD_KEY;
		 [group addElementsObject:pPD];
	 }

	 pPD.value = self.pPDUITextField.text;
	 
	 TextElement *yRS = (TextElement*)[group getElementForKey:YRS_KEY];
	 if (!yRS) {
		 yRS = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 yRS.key = YRS_KEY;
		 [group addElementsObject:yRS];
	 }

	 yRS.value = self.yRSUITextField.text;
	 
	 TextElement *quitAmountAgo = (TextElement*)[group getElementForKey:QUIT_AMOUNT_AGO_KEY];
	 if (!quitAmountAgo) {
		 quitAmountAgo = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 quitAmountAgo.key = QUIT_AMOUNT_AGO_KEY;
		 [group addElementsObject:quitAmountAgo];
	 }

	 quitAmountAgo.value = self.quitAmountAgoUITextField.text;
	 
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
	 return RESPIRATORY_SECTION_TITLE;
}
@end