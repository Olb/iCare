
#import "PostOpDiagnosisViewController.h"
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


@interface PostOpDiagnosisViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *crystalloidUITextField;
@property (weak, nonatomic) IBOutlet UITextField *ffpUITextField;
@property (weak, nonatomic) IBOutlet UITextField *albuminUITextField;
@property (weak, nonatomic) IBOutlet UITextField *prbcsUITextField;
@property (weak, nonatomic) IBOutlet UITextField *pltsUITextField;
@property (weak, nonatomic) IBOutlet UITextField *hetastarchUITextField;
@property (weak, nonatomic) IBOutlet UITextField *cellSaverUITextField;
@property (weak, nonatomic) IBOutlet UITextField *cryoUITextField;
@property (weak, nonatomic) IBOutlet UITextField *eblUITextField;
@property (weak, nonatomic) IBOutlet UITextField *urineUITextField;
@end

@implementation PostOpDiagnosisViewController
NSString *const POST_OP_DIAGNOSIS_SECTION_TITLE = @"PostOpDiagnosisSectionKey";
static NSString *const CRYSTALLOID_KEY = @"CrystalloidKey";
static NSString *const FFP_KEY = @"FfpKey";
static NSString *const ALBUMIN_KEY = @"AlbuminKey";
static NSString *const PRBCS_KEY = @"PrbcsKey";
static NSString *const PLTS_KEY = @"PltsKey";
static NSString *const HETASTARCH_KEY = @"HetastarchKey";
static NSString *const CELL_SAVER_KEY = @"CellSaverKey";
static NSString *const CRYO_KEY = @"CryoKey";
static NSString *const EBL_KEY = @"EblKey";
static NSString *const URINE_KEY = @"UrineKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:CRYSTALLOID_KEY]){
				 [self.crystalloidUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:FFP_KEY]){
				 [self.ffpUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:ALBUMIN_KEY]){
				 [self.albuminUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:PRBCS_KEY]){
				 [self.prbcsUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:PLTS_KEY]){
				 [self.pltsUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:HETASTARCH_KEY]){
				 [self.hetastarchUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:CELL_SAVER_KEY]){
				 [self.cellSaverUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:CRYO_KEY]){
				 [self.cryoUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:EBL_KEY]){
				 [self.eblUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:URINE_KEY]){
				 [self.urineUITextField setText:((TextElement*)element).value];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:CRYSTALLOID_KEY]!= nil, @"Crystalloid is nil");
	 NSAssert([section getElementForKey:FFP_KEY]!= nil, @"Ffp is nil");
	 NSAssert([section getElementForKey:ALBUMIN_KEY]!= nil, @"Albumin is nil");
	 NSAssert([section getElementForKey:PRBCS_KEY]!= nil, @"Prbcs is nil");
	 NSAssert([section getElementForKey:PLTS_KEY]!= nil, @"Plts is nil");
	 NSAssert([section getElementForKey:HETASTARCH_KEY]!= nil, @"Hetastarch is nil");
	 NSAssert([section getElementForKey:CELL_SAVER_KEY]!= nil, @"CellSaver is nil");
	 NSAssert([section getElementForKey:CRYO_KEY]!= nil, @"Cryo is nil");
	 NSAssert([section getElementForKey:EBL_KEY]!= nil, @"Ebl is nil");
	 NSAssert([section getElementForKey:URINE_KEY]!= nil, @"Urine is nil");
	 
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
		 self.section.title = POST_OP_DIAGNOSIS_SECTION_TITLE;
	 }
	 
	 TextElement *crystalloid = (TextElement*)[_section getElementForKey:CRYSTALLOID_KEY];
	 if (!crystalloid) {
		 crystalloid = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 crystalloid.key = CRYSTALLOID_KEY;
		 [_section addElementsObject:crystalloid];
	 }

	 crystalloid.value = self.crystalloidUITextField.text;
	 
	 TextElement *ffp = (TextElement*)[_section getElementForKey:FFP_KEY];
	 if (!ffp) {
		 ffp = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 ffp.key = FFP_KEY;
		 [_section addElementsObject:ffp];
	 }

	 ffp.value = self.ffpUITextField.text;
	 
	 TextElement *albumin = (TextElement*)[_section getElementForKey:ALBUMIN_KEY];
	 if (!albumin) {
		 albumin = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 albumin.key = ALBUMIN_KEY;
		 [_section addElementsObject:albumin];
	 }

	 albumin.value = self.albuminUITextField.text;
	 
	 TextElement *prbcs = (TextElement*)[_section getElementForKey:PRBCS_KEY];
	 if (!prbcs) {
		 prbcs = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 prbcs.key = PRBCS_KEY;
		 [_section addElementsObject:prbcs];
	 }

	 prbcs.value = self.prbcsUITextField.text;
	 
	 TextElement *plts = (TextElement*)[_section getElementForKey:PLTS_KEY];
	 if (!plts) {
		 plts = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 plts.key = PLTS_KEY;
		 [_section addElementsObject:plts];
	 }

	 plts.value = self.pltsUITextField.text;
	 
	 TextElement *hetastarch = (TextElement*)[_section getElementForKey:HETASTARCH_KEY];
	 if (!hetastarch) {
		 hetastarch = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 hetastarch.key = HETASTARCH_KEY;
		 [_section addElementsObject:hetastarch];
	 }

	 hetastarch.value = self.hetastarchUITextField.text;
	 
	 TextElement *cellSaver = (TextElement*)[_section getElementForKey:CELL_SAVER_KEY];
	 if (!cellSaver) {
		 cellSaver = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 cellSaver.key = CELL_SAVER_KEY;
		 [_section addElementsObject:cellSaver];
	 }

	 cellSaver.value = self.cellSaverUITextField.text;
	 
	 TextElement *cryo = (TextElement*)[_section getElementForKey:CRYO_KEY];
	 if (!cryo) {
		 cryo = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 cryo.key = CRYO_KEY;
		 [_section addElementsObject:cryo];
	 }

	 cryo.value = self.cryoUITextField.text;
	 
	 TextElement *ebl = (TextElement*)[_section getElementForKey:EBL_KEY];
	 if (!ebl) {
		 ebl = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 ebl.key = EBL_KEY;
		 [_section addElementsObject:ebl];
	 }

	 ebl.value = self.eblUITextField.text;
	 
	 TextElement *urine = (TextElement*)[_section getElementForKey:URINE_KEY];
	 if (!urine) {
		 urine = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 urine.key = URINE_KEY;
		 [_section addElementsObject:urine];
	 }

	 urine.value = self.urineUITextField.text;
	 
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
	 return POST_OP_DIAGNOSIS_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 sender.selected = selected;
}
@end