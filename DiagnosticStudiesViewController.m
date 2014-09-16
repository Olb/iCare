#import "DiagnosticStudiesViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface DiagnosticStudiesViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *labsNABBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *medicalEvalReviewedBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *hHUITextField;
@property (weak, nonatomic) IBOutlet UITextField *pLTUITextField;
@property (weak, nonatomic) IBOutlet UITextField *kPotassiumUITextField;
@property (weak, nonatomic) IBOutlet UITextField *pTINRPTTUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *pregTestNegativeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *pregTestPositiveBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *glucoseUITextField;
@property (weak, nonatomic) IBOutlet UITextField *glucoseTimeUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *eKGBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *eKGOtherUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *cXRBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *cXROtherUITextField;
@property (weak, nonatomic) IBOutlet UITextField *otherDataTextField;
@property (weak, nonatomic) IBOutlet UITableView *otherDataTable;
@property (strong, nonatomic) StringArrayTableAdapter *otherDataTableAdapter;
@end

@implementation DiagnosticStudiesViewController
NSString *const DIAGNOSTIC_STUDIES_SECTION_TITLE = @"DiagnosticStudiesSectionKey";
NSString *const LABSNA_KEY = @"LabsNAKey";
NSString *const MEDICAL_EVAL_REVIEWED_KEY = @"MedicalEvalReviewedKey";
NSString *const HH_KEY = @"HHKey";
NSString *const PLT_KEY = @"PLTKey";
NSString *const KPotassium_KEY = @"KPotassiumKey";
NSString *const PTINRPTT_KEY = @"PTINRPTTKey";
NSString *const PREG_TEST_NEGATIVE_KEY = @"PregTestNegativeKey";
NSString *const PREG_TEST_POSITIVE_KEY = @"PregTestPositiveKey";
NSString *const GLUCOSE_KEY = @"GlucoseKey";
NSString *const GLUCOSE_TIME_KEY = @"GlucoseTimeKey";
NSString *const EKG_KEY = @"EKGKey";
NSString *const EKGOther_KEY = @"EKGOtherKey";
NSString *const CXR_KEY = @"CXRKey";
NSString *const CXROther_KEY = @"CXROtherKey";
NSString *const OTHER_DATA_KEY = @"OtherDataKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.otherDataTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.otherDataTable.dataSource = self.otherDataTableAdapter;
	 self.otherDataTable.delegate = self.otherDataTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:LABSNA_KEY]){
				 [self.labsNABBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MEDICAL_EVAL_REVIEWED_KEY]){
				 [self.medicalEvalReviewedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HH_KEY]){
				 [self.hHUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:PLT_KEY]){
				 [self.pLTUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:KPotassium_KEY]){
				 [self.kPotassiumUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:PTINRPTT_KEY]){
				 [self.pTINRPTTUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:PREG_TEST_NEGATIVE_KEY]){
				 [self.pregTestNegativeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PREG_TEST_POSITIVE_KEY]){
				 [self.pregTestPositiveBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:GLUCOSE_KEY]){
				 [self.glucoseUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:GLUCOSE_TIME_KEY]){
				 [self.glucoseTimeUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:EKG_KEY]){
				 [self.eKGBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:EKGOther_KEY]){
				 [self.eKGOtherUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:CXR_KEY]){
				 [self.cXRBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CXROther_KEY]){
				 [self.cXROtherUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:OTHER_DATA_KEY]){
				 self.otherDataTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.otherDataTable reloadData];
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
	 NSAssert([group getElementForKey:LABSNA_KEY]!= nil, @"LabsNA is nil");
	 NSAssert([group getElementForKey:MEDICAL_EVAL_REVIEWED_KEY]!= nil, @"MedicalEvalReviewed is nil");
	 NSAssert([group getElementForKey:HH_KEY]!= nil, @"HH is nil");
	 NSAssert([group getElementForKey:PLT_KEY]!= nil, @"PLT is nil");
	 NSAssert([group getElementForKey:KPotassium_KEY]!= nil, @"KPotassium is nil");
	 NSAssert([group getElementForKey:PTINRPTT_KEY]!= nil, @"PTINRPTT is nil");
	 NSAssert([group getElementForKey:PREG_TEST_NEGATIVE_KEY]!= nil, @"PregTestNegative is nil");
	 NSAssert([group getElementForKey:PREG_TEST_POSITIVE_KEY]!= nil, @"PregTestPositive is nil");
	 NSAssert([group getElementForKey:GLUCOSE_KEY]!= nil, @"Glucose is nil");
	 NSAssert([group getElementForKey:GLUCOSE_TIME_KEY]!= nil, @"GlucoseTime is nil");
	 NSAssert([group getElementForKey:EKG_KEY]!= nil, @"EKG is nil");
	 NSAssert([group getElementForKey:EKGOther_KEY]!= nil, @"EKGOther is nil");
	 NSAssert([group getElementForKey:CXR_KEY]!= nil, @"CXR is nil");
	 NSAssert([group getElementForKey:CXROther_KEY]!= nil, @"CXROther is nil");
	 NSAssert([group getElementForKey:OTHER_DATA_KEY]!= nil, @"OtherData is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = DIAGNOSTIC_STUDIES_SECTION_TITLE;
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
	 BooleanFormElement *labsNA = (BooleanFormElement*)[group getElementForKey:LABSNA_KEY];
	 if (!labsNA) {
		 labsNA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 labsNA.key = LABSNA_KEY;
		 [group addElementsObject:labsNA];
	 }

	 labsNA.value = [NSNumber numberWithBool:self.labsNABBCheckBox.isSelected];
	 
	 BooleanFormElement *medicalEvalReviewed = (BooleanFormElement*)[group getElementForKey:MEDICAL_EVAL_REVIEWED_KEY];
	 if (!medicalEvalReviewed) {
		 medicalEvalReviewed = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 medicalEvalReviewed.key = MEDICAL_EVAL_REVIEWED_KEY;
		 [group addElementsObject:medicalEvalReviewed];
	 }

	 medicalEvalReviewed.value = [NSNumber numberWithBool:self.medicalEvalReviewedBBCheckBox.isSelected];
	 
	 TextElement *hH = (TextElement*)[group getElementForKey:HH_KEY];
	 if (!hH) {
		 hH = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 hH.key = HH_KEY;
		 [group addElementsObject:hH];
	 }

	 hH.value = self.hHUITextField.text;
	 
	 TextElement *pLT = (TextElement*)[group getElementForKey:PLT_KEY];
	 if (!pLT) {
		 pLT = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 pLT.key = PLT_KEY;
		 [group addElementsObject:pLT];
	 }

	 pLT.value = self.pLTUITextField.text;
	 
	 TextElement *kPotassium = (TextElement*)[group getElementForKey:KPotassium_KEY];
	 if (!kPotassium) {
		 kPotassium = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 kPotassium.key = KPotassium_KEY;
		 [group addElementsObject:kPotassium];
	 }

	 kPotassium.value = self.kPotassiumUITextField.text;
	 
	 TextElement *pTINRPTT = (TextElement*)[group getElementForKey:PTINRPTT_KEY];
	 if (!pTINRPTT) {
		 pTINRPTT = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 pTINRPTT.key = PTINRPTT_KEY;
		 [group addElementsObject:pTINRPTT];
	 }

	 pTINRPTT.value = self.pTINRPTTUITextField.text;
	 
	 BooleanFormElement *pregTestNegative = (BooleanFormElement*)[group getElementForKey:PREG_TEST_NEGATIVE_KEY];
	 if (!pregTestNegative) {
		 pregTestNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pregTestNegative.key = PREG_TEST_NEGATIVE_KEY;
		 [group addElementsObject:pregTestNegative];
	 }

	 pregTestNegative.value = [NSNumber numberWithBool:self.pregTestNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *pregTestPositive = (BooleanFormElement*)[group getElementForKey:PREG_TEST_POSITIVE_KEY];
	 if (!pregTestPositive) {
		 pregTestPositive = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pregTestPositive.key = PREG_TEST_POSITIVE_KEY;
		 [group addElementsObject:pregTestPositive];
	 }

	 pregTestPositive.value = [NSNumber numberWithBool:self.pregTestPositiveBBCheckBox.isSelected];
	 
	 TextElement *glucose = (TextElement*)[group getElementForKey:GLUCOSE_KEY];
	 if (!glucose) {
		 glucose = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 glucose.key = GLUCOSE_KEY;
		 [group addElementsObject:glucose];
	 }

	 glucose.value = self.glucoseUITextField.text;
	 
	 TextElement *glucoseTime = (TextElement*)[group getElementForKey:GLUCOSE_TIME_KEY];
	 if (!glucoseTime) {
		 glucoseTime = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 glucoseTime.key = GLUCOSE_TIME_KEY;
		 [group addElementsObject:glucoseTime];
	 }

	 glucoseTime.value = self.glucoseTimeUITextField.text;
	 
	 BooleanFormElement *eKG = (BooleanFormElement*)[group getElementForKey:EKG_KEY];
	 if (!eKG) {
		 eKG = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 eKG.key = EKG_KEY;
		 [group addElementsObject:eKG];
	 }

	 eKG.value = [NSNumber numberWithBool:self.eKGBBCheckBox.isSelected];
	 
	 TextElement *eKGOther = (TextElement*)[group getElementForKey:EKGOther_KEY];
	 if (!eKGOther) {
		 eKGOther = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 eKGOther.key = EKGOther_KEY;
		 [group addElementsObject:eKGOther];
	 }

	 eKGOther.value = self.eKGOtherUITextField.text;
	 
	 BooleanFormElement *cXR = (BooleanFormElement*)[group getElementForKey:CXR_KEY];
	 if (!cXR) {
		 cXR = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cXR.key = CXR_KEY;
		 [group addElementsObject:cXR];
	 }

	 cXR.value = [NSNumber numberWithBool:self.cXRBBCheckBox.isSelected];
	 
	 TextElement *cXROther = (TextElement*)[group getElementForKey:CXROther_KEY];
	 if (!cXROther) {
		 cXROther = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 cXROther.key = CXROther_KEY;
		 [group addElementsObject:cXROther];
	 }

	 cXROther.value = self.cXROtherUITextField.text;
	 
	 StringListElement *otherData = (StringListElement*)[group getElementForKey:OTHER_DATA_KEY];
	 if (!otherData) {
		 otherData = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 otherData.key = OTHER_DATA_KEY;
		 [group addElementsObject:otherData];
	 }

	 NSMutableArray *otherDataStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.otherDataTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.otherDataTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [otherDataStringArray addObject:cell.textLabel.text];
	 }
	 otherData.value = otherDataStringArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOtherData:(id)sender {
	 [self.otherDataTableAdapter.items addObject:self.otherDataTextField.text];
	 [self.otherDataTable reloadData];
	 self.otherDataTextField.text = @"";
	 [self.otherDataTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return DIAGNOSTIC_STUDIES_SECTION_TITLE;
}
@end