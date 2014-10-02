
#import "PremedsGivenViewController.h"
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


@interface PremedsGivenViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *midazolamBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *midazolamUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *ondansetronBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *ondansetronUITextField;
@property (weak, nonatomic) IBOutlet UITableView *premedsGivenTable;
@property (strong, nonatomic) FormElementTableAdapter *premedsGivenTableAdapter;
@property (weak, nonatomic) IBOutlet UITextField *premedsGivenNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *premedsGivenDoseTextField;
@property (weak, nonatomic) IBOutlet UIButton *premedsGivenDoseUnitButton;
@end

@implementation PremedsGivenViewController
NSString *const PREMEDS_GIVEN_SECTION_TITLE = @"PremedsGivenSectionKey";
static NSString *const MIDAZOLAM_KEY = @"MidazolamKey";
static NSString *const ONDANSETRON_KEY = @"OndansetronKey";
static NSString *const PREMEDS_GIVEN_KEY = @"PremedsGivenKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.premedsGivenTableAdapter = [[FormElementTableAdapter alloc] init];
	 self.premedsGivenTable.dataSource = self.premedsGivenTableAdapter;
	 self.premedsGivenTable.delegate = self.premedsGivenTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:MIDAZOLAM_KEY]){
				 [self.midazolamBBCheckBox setSelected:[((MedicationFormElement*)element).selected boolValue]];
				 [self.midazolamUITextField setText:((MedicationFormElement*)element).dose];
			 }
			 if ([element.key isEqualToString:ONDANSETRON_KEY]){
				 [self.ondansetronBBCheckBox setSelected:[((MedicationFormElement*)element).selected boolValue]];
				 [self.ondansetronUITextField setText:((MedicationFormElement*)element).dose];
			 }
			 if ([element.key isEqualToString:PREMEDS_GIVEN_KEY]){
				 self.premedsGivenTableAdapter.items = [[((ElementListFormElement*)element).elements allObjects] mutableCopy];
				 [self.premedsGivenTable reloadData];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:MIDAZOLAM_KEY]!= nil, @"Midazolam is nil");
	 NSAssert([section getElementForKey:ONDANSETRON_KEY]!= nil, @"Ondansetron is nil");
	 NSAssert([section getElementForKey:PREMEDS_GIVEN_KEY]!= nil, @"PremedsGiven is nil");
	 
}

-(BOOL)validateData:(NSString**)errMsg
{
	 if (self.midazolamBBCheckBox.selected && [self.midazolamUITextField.text isEqualToString:@""]) {
		 *errMsg = @"Midazolam must have a dose value";
		 return false;
	 }
	 if (self.ondansetronBBCheckBox.selected && [self.ondansetronUITextField.text isEqualToString:@""]) {
		 *errMsg = @"Ondansetron must have a dose value";
		 return false;
	 }
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
		 self.section.title = PREMEDS_GIVEN_SECTION_TITLE;
	 }
	 
	 MedicationFormElement *midazolam = (MedicationFormElement*)[_section getElementForKey:MIDAZOLAM_KEY];
	 if (!midazolam) {
		 midazolam = (MedicationFormElement*)[BBUtil newCoreDataObjectForEntityName:@"MedicationFormElement"];
		 midazolam.key = MIDAZOLAM_KEY;
		 [_section addElementsObject:midazolam];
	 }

	 midazolam.selected = [NSNumber numberWithBool:self.midazolamBBCheckBox.isSelected];
	 midazolam.dose = self.midazolamUITextField.text;
	 midazolam.name = @"Midazolam";
	 midazolam.doseUnit = @"mg";
	 
	 MedicationFormElement *ondansetron = (MedicationFormElement*)[_section getElementForKey:ONDANSETRON_KEY];
	 if (!ondansetron) {
		 ondansetron = (MedicationFormElement*)[BBUtil newCoreDataObjectForEntityName:@"MedicationFormElement"];
		 ondansetron.key = ONDANSETRON_KEY;
		 [_section addElementsObject:ondansetron];
	 }

	 ondansetron.selected = [NSNumber numberWithBool:self.ondansetronBBCheckBox.isSelected];
	 ondansetron.dose = self.ondansetronUITextField.text;
	 ondansetron.name = @"Ondansetron";
	 ondansetron.doseUnit = @"mg";
	 
	 ElementListFormElement *premedsGiven = (ElementListFormElement*)[_section getElementForKey:PREMEDS_GIVEN_KEY];
	 if (!premedsGiven) {
		 premedsGiven = (ElementListFormElement*)[BBUtil newCoreDataObjectForEntityName:@"ElementListFormElement"];
		 premedsGiven.key = PREMEDS_GIVEN_KEY;
		 [_section addElementsObject:premedsGiven];
	 }

	 NSMutableSet *premedsGivenElementListArray = [[NSMutableSet alloc] init];
	 for (int i = 0; i < [self.premedsGivenTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.premedsGivenTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 MedicationFormElement *elementListFormElement = [FormElementTableCellFactory getElementForMedicationCell:cell withElement:nil];		 [premedsGivenElementListArray addObject:elementListFormElement];
	 }
	 for (FormElement *element in premedsGiven.elements) {
		 [BBUtil deleteManagedObject:element];
	 }
	 [[premedsGiven mutableSetValueForKey:@"elements"] removeAllObjects];
	 [premedsGiven addElements:premedsGivenElementListArray];
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addPremedsGiven:(id)sender {
	 MedicationFormElement *formElement = (MedicationFormElement*)[BBUtil newCoreDataObjectForEntityName:@"MedicationFormElement"];
	 formElement.name = self.premedsGivenNameTextField.text;
	 formElement.dose = self.premedsGivenDoseTextField.text;
	 formElement.doseUnit = self.premedsGivenDoseUnitButton.titleLabel.text;
	 [self.premedsGivenTableAdapter.items addObject:formElement];
	 [self.premedsGivenTable reloadData];
	 self.premedsGivenNameTextField.text = @"";
	 self.premedsGivenDoseTextField.text = @"";
	 [self.premedsGivenNameTextField resignFirstResponder];
	 [self.premedsGivenDoseTextField resignFirstResponder];
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
	 return PREMEDS_GIVEN_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 sender.selected = selected;
}
@end