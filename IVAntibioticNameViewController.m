
#import "IVAntibioticNameViewController.h"
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


@interface IVAntibioticNameViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ivAntibioticTable;
@property (strong, nonatomic) FormElementTableAdapter *ivAntibioticTableAdapter;
@property (weak, nonatomic) IBOutlet UITextField *ivAntibioticNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ivAntibioticDoseTextField;
@property (weak, nonatomic) IBOutlet UIButton *ivAntibioticDoseUnitButton;
@property (weak, nonatomic) IBOutlet UITextField *ivAntibioticStartTimeTextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *intentionallyGivenBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *notIndicatedBBCheckBox;
@end

@implementation IVAntibioticNameViewController
NSString *const IVAntibiotic_NAME_SECTION_TITLE = @"IVAntibioticNameSectionKey";
static NSString *const IV_ANTIBIOTIC_KEY = @"IvAntibioticKey";
static NSString *const INTENTIONALLY_GIVEN_KEY = @"IntentionallyGivenKey";
static NSString *const NOT_INDICATED_KEY = @"NotIndicatedKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.ivAntibioticTableAdapter = [[FormElementTableAdapter alloc] init];
	 self.ivAntibioticTable.dataSource = self.ivAntibioticTableAdapter;
	 self.ivAntibioticTable.delegate = self.ivAntibioticTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:IV_ANTIBIOTIC_KEY]){
				 self.ivAntibioticTableAdapter.items = [[((ElementListFormElement*)element).elements allObjects] mutableCopy];
				 [self.ivAntibioticTable reloadData];
			 }
			 if ([element.key isEqualToString:INTENTIONALLY_GIVEN_KEY]){
				 [self.intentionallyGivenBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NOT_INDICATED_KEY]){
				 [self.notIndicatedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:IV_ANTIBIOTIC_KEY]!= nil, @"IvAntibiotic is nil");
	 NSAssert([section getElementForKey:INTENTIONALLY_GIVEN_KEY]!= nil, @"IntentionallyGiven is nil");
	 NSAssert([section getElementForKey:NOT_INDICATED_KEY]!= nil, @"NotIndicated is nil");
	 
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
		 self.section.title = IVAntibiotic_NAME_SECTION_TITLE;
	 }
	 
	 ElementListFormElement *ivAntibiotic = (ElementListFormElement*)[_section getElementForKey:IV_ANTIBIOTIC_KEY];
	 if (!ivAntibiotic) {
		 ivAntibiotic = (ElementListFormElement*)[BBUtil newCoreDataObjectForEntityName:@"ElementListFormElement"];
		 ivAntibiotic.key = IV_ANTIBIOTIC_KEY;
		 [_section addElementsObject:ivAntibiotic];
	 }

	 NSMutableSet *ivAntibioticElementListArray = [[NSMutableSet alloc] init];
	 for (int i = 0; i < [self.ivAntibioticTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.ivAntibioticTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 AntibioticFormElement *elementListFormElement = [FormElementTableCellFactory getElementForAntibioticCell:cell withElement:nil];		 [ivAntibioticElementListArray addObject:elementListFormElement];
	 }
	 for (FormElement *element in ivAntibiotic.elements) {
		 [BBUtil deleteManagedObject:element];
	 }
	 [[ivAntibiotic mutableSetValueForKey:@"elements"] removeAllObjects];
	 [ivAntibiotic addElements:ivAntibioticElementListArray];
	 
	 BooleanFormElement *intentionallyGiven = (BooleanFormElement*)[_section getElementForKey:INTENTIONALLY_GIVEN_KEY];
	 if (!intentionallyGiven) {
		 intentionallyGiven = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 intentionallyGiven.key = INTENTIONALLY_GIVEN_KEY;
		 [_section addElementsObject:intentionallyGiven];
	 }

	 intentionallyGiven.value = [NSNumber numberWithBool:self.intentionallyGivenBBCheckBox.isSelected];
	 
	 BooleanFormElement *notIndicated = (BooleanFormElement*)[_section getElementForKey:NOT_INDICATED_KEY];
	 if (!notIndicated) {
		 notIndicated = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 notIndicated.key = NOT_INDICATED_KEY;
		 [_section addElementsObject:notIndicated];
	 }

	 notIndicated.value = [NSNumber numberWithBool:self.notIndicatedBBCheckBox.isSelected];
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addIvAntibiotic:(id)sender {
	 AntibioticFormElement *formElement = (AntibioticFormElement*)[BBUtil newCoreDataObjectForEntityName:@"AntibioticFormElement"];
	 formElement.name = self.ivAntibioticNameTextField.text;
	 formElement.dose = self.ivAntibioticDoseTextField.text;
	 formElement.doseUnit = self.ivAntibioticDoseUnitButton.titleLabel.text;
	 NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	 [formatter setDateFormat:@"HH:mm"];
	 NSDate *date = [formatter dateFromString:self.ivAntibioticStartTimeTextField.text];
	 formElement.startTime = date;
	 [self.ivAntibioticTableAdapter.items addObject:formElement];
	 [self.ivAntibioticTable reloadData];
	 self.ivAntibioticNameTextField.text = @"";
	 self.ivAntibioticDoseTextField.text = @"";
	 self.ivAntibioticStartTimeTextField.text = @"";
	 [self.ivAntibioticNameTextField resignFirstResponder];
	 [self.ivAntibioticDoseTextField resignFirstResponder];
	 [self.ivAntibioticStartTimeTextField resignFirstResponder];
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
	 return IVAntibiotic_NAME_SECTION_TITLE;
}
@end