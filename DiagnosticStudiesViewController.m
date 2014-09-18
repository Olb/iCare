
#import "DiagnosticStudiesViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
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
@property (weak, nonatomic) IBOutlet BBCheckBox *ekgNormalBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *ekgOtherUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *cxrNormalBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *cxrOtherUITextField;
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
NSString *const EKG_NORMAL_KEY = @"EkgNormalKey";
NSString *const EKG_OTHER_KEY = @"EkgOtherKey";
NSString *const CXR_NORMAL_KEY = @"CxrNormalKey";
NSString *const CXR_OTHER_KEY = @"CxrOtherKey";
NSString *const OTHER_DATA_KEY = @"OtherDataKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.otherDataTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.otherDataTable.dataSource = self.otherDataTableAdapter;
	 self.otherDataTable.delegate = self.otherDataTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

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
			 if ([element.key isEqualToString:EKG_NORMAL_KEY]){
				 [self.ekgNormalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:EKG_OTHER_KEY]){
				 [self.ekgOtherUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:CXR_NORMAL_KEY]){
				 [self.cxrNormalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CXR_OTHER_KEY]){
				 [self.cxrOtherUITextField setText:((TextElement*)element).value];
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
	 NSAssert([section getElementForKey:LABSNA_KEY]!= nil, @"LabsNA is nil");
	 NSAssert([section getElementForKey:MEDICAL_EVAL_REVIEWED_KEY]!= nil, @"MedicalEvalReviewed is nil");
	 NSAssert([section getElementForKey:HH_KEY]!= nil, @"HH is nil");
	 NSAssert([section getElementForKey:PLT_KEY]!= nil, @"PLT is nil");
	 NSAssert([section getElementForKey:KPotassium_KEY]!= nil, @"KPotassium is nil");
	 NSAssert([section getElementForKey:PTINRPTT_KEY]!= nil, @"PTINRPTT is nil");
	 NSAssert([section getElementForKey:PREG_TEST_NEGATIVE_KEY]!= nil, @"PregTestNegative is nil");
	 NSAssert([section getElementForKey:PREG_TEST_POSITIVE_KEY]!= nil, @"PregTestPositive is nil");
	 NSAssert([section getElementForKey:GLUCOSE_KEY]!= nil, @"Glucose is nil");
	 NSAssert([section getElementForKey:GLUCOSE_TIME_KEY]!= nil, @"GlucoseTime is nil");
	 NSAssert([section getElementForKey:EKG_NORMAL_KEY]!= nil, @"EkgNormal is nil");
	 NSAssert([section getElementForKey:EKG_OTHER_KEY]!= nil, @"EkgOther is nil");
	 NSAssert([section getElementForKey:CXR_NORMAL_KEY]!= nil, @"CxrNormal is nil");
	 NSAssert([section getElementForKey:CXR_OTHER_KEY]!= nil, @"CxrOther is nil");
	 NSAssert([section getElementForKey:OTHER_DATA_KEY]!= nil, @"OtherData is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = DIAGNOSTIC_STUDIES_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *labsNA = (BooleanFormElement*)[_section getElementForKey:LABSNA_KEY];
	 if (!labsNA) {
		 labsNA = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 labsNA.key = LABSNA_KEY;
		 [_section addElementsObject:labsNA];
	 }

	 labsNA.value = [NSNumber numberWithBool:self.labsNABBCheckBox.isSelected];
	 
	 BooleanFormElement *medicalEvalReviewed = (BooleanFormElement*)[_section getElementForKey:MEDICAL_EVAL_REVIEWED_KEY];
	 if (!medicalEvalReviewed) {
		 medicalEvalReviewed = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 medicalEvalReviewed.key = MEDICAL_EVAL_REVIEWED_KEY;
		 [_section addElementsObject:medicalEvalReviewed];
	 }

	 medicalEvalReviewed.value = [NSNumber numberWithBool:self.medicalEvalReviewedBBCheckBox.isSelected];
	 
	 TextElement *hH = (TextElement*)[_section getElementForKey:HH_KEY];
	 if (!hH) {
		 hH = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 hH.key = HH_KEY;
		 [_section addElementsObject:hH];
	 }

	 hH.value = self.hHUITextField.text;
	 
	 TextElement *pLT = (TextElement*)[_section getElementForKey:PLT_KEY];
	 if (!pLT) {
		 pLT = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 pLT.key = PLT_KEY;
		 [_section addElementsObject:pLT];
	 }

	 pLT.value = self.pLTUITextField.text;
	 
	 TextElement *kPotassium = (TextElement*)[_section getElementForKey:KPotassium_KEY];
	 if (!kPotassium) {
		 kPotassium = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 kPotassium.key = KPotassium_KEY;
		 [_section addElementsObject:kPotassium];
	 }

	 kPotassium.value = self.kPotassiumUITextField.text;
	 
	 TextElement *pTINRPTT = (TextElement*)[_section getElementForKey:PTINRPTT_KEY];
	 if (!pTINRPTT) {
		 pTINRPTT = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 pTINRPTT.key = PTINRPTT_KEY;
		 [_section addElementsObject:pTINRPTT];
	 }

	 pTINRPTT.value = self.pTINRPTTUITextField.text;
	 
	 BooleanFormElement *pregTestNegative = (BooleanFormElement*)[_section getElementForKey:PREG_TEST_NEGATIVE_KEY];
	 if (!pregTestNegative) {
		 pregTestNegative = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pregTestNegative.key = PREG_TEST_NEGATIVE_KEY;
		 [_section addElementsObject:pregTestNegative];
	 }

	 pregTestNegative.value = [NSNumber numberWithBool:self.pregTestNegativeBBCheckBox.isSelected];
	 
	 BooleanFormElement *pregTestPositive = (BooleanFormElement*)[_section getElementForKey:PREG_TEST_POSITIVE_KEY];
	 if (!pregTestPositive) {
		 pregTestPositive = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 pregTestPositive.key = PREG_TEST_POSITIVE_KEY;
		 [_section addElementsObject:pregTestPositive];
	 }

	 pregTestPositive.value = [NSNumber numberWithBool:self.pregTestPositiveBBCheckBox.isSelected];
	 
	 TextElement *glucose = (TextElement*)[_section getElementForKey:GLUCOSE_KEY];
	 if (!glucose) {
		 glucose = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 glucose.key = GLUCOSE_KEY;
		 [_section addElementsObject:glucose];
	 }

	 glucose.value = self.glucoseUITextField.text;
	 
	 TextElement *glucoseTime = (TextElement*)[_section getElementForKey:GLUCOSE_TIME_KEY];
	 if (!glucoseTime) {
		 glucoseTime = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 glucoseTime.key = GLUCOSE_TIME_KEY;
		 [_section addElementsObject:glucoseTime];
	 }

	 glucoseTime.value = self.glucoseTimeUITextField.text;
	 
	 BooleanFormElement *ekgNormal = (BooleanFormElement*)[_section getElementForKey:EKG_NORMAL_KEY];
	 if (!ekgNormal) {
		 ekgNormal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 ekgNormal.key = EKG_NORMAL_KEY;
		 [_section addElementsObject:ekgNormal];
	 }

	 ekgNormal.value = [NSNumber numberWithBool:self.ekgNormalBBCheckBox.isSelected];
	 
	 TextElement *ekgOther = (TextElement*)[_section getElementForKey:EKG_OTHER_KEY];
	 if (!ekgOther) {
		 ekgOther = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 ekgOther.key = EKG_OTHER_KEY;
		 [_section addElementsObject:ekgOther];
	 }

	 ekgOther.value = self.ekgOtherUITextField.text;
	 
	 BooleanFormElement *cxrNormal = (BooleanFormElement*)[_section getElementForKey:CXR_NORMAL_KEY];
	 if (!cxrNormal) {
		 cxrNormal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 cxrNormal.key = CXR_NORMAL_KEY;
		 [_section addElementsObject:cxrNormal];
	 }

	 cxrNormal.value = [NSNumber numberWithBool:self.cxrNormalBBCheckBox.isSelected];
	 
	 TextElement *cxrOther = (TextElement*)[_section getElementForKey:CXR_OTHER_KEY];
	 if (!cxrOther) {
		 cxrOther = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 cxrOther.key = CXR_OTHER_KEY;
		 [_section addElementsObject:cxrOther];
	 }

	 cxrOther.value = self.cxrOtherUITextField.text;
	 
	 StringListElement *otherData = (StringListElement*)[_section getElementForKey:OTHER_DATA_KEY];
	 if (!otherData) {
		 otherData = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 otherData.key = OTHER_DATA_KEY;
		 [_section addElementsObject:otherData];
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