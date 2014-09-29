
#import "MedicationsSupplementsViewController.h"
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


@interface MedicationsSupplementsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *betaBlockerBBCheckBox;
@property (weak, nonatomic) IBOutlet UITableView *medsSupplementsTable;
@property (strong, nonatomic) FormElementTableAdapter *medsSupplementsTableAdapter;
@property (weak, nonatomic) IBOutlet UITextField *medsSupplementsNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *medsSupplementsDoseTextField;
@property (weak, nonatomic) IBOutlet UIButton *medsSupplementsDoseUnitButton;
@end

@implementation MedicationsSupplementsViewController
NSString *const MEDICATIONS_SUPPLEMENTS_SECTION_TITLE = @"MedicationsSupplementsSectionKey";
static NSString *const BETA_BLOCKER_KEY = @"BetaBlockerKey";
static NSString *const MEDS_SUPPLEMENTS_KEY = @"MedsSupplementsKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.medsSupplementsTableAdapter = [[FormElementTableAdapter alloc] init];
	 self.medsSupplementsTable.dataSource = self.medsSupplementsTableAdapter;
	 self.medsSupplementsTable.delegate = self.medsSupplementsTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:BETA_BLOCKER_KEY]){
				 [self.betaBlockerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MEDS_SUPPLEMENTS_KEY]){
				 self.medsSupplementsTableAdapter.items = [[((ElementListFormElement*)element).elements allObjects] mutableCopy];
				 [self.medsSupplementsTable reloadData];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:BETA_BLOCKER_KEY]!= nil, @"BetaBlocker is nil");
	 NSAssert([section getElementForKey:MEDS_SUPPLEMENTS_KEY]!= nil, @"MedsSupplements is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = MEDICATIONS_SUPPLEMENTS_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *betaBlocker = (BooleanFormElement*)[_section getElementForKey:BETA_BLOCKER_KEY];
	 if (!betaBlocker) {
		 betaBlocker = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 betaBlocker.key = BETA_BLOCKER_KEY;
		 [_section addElementsObject:betaBlocker];
	 }

	 betaBlocker.value = [NSNumber numberWithBool:self.betaBlockerBBCheckBox.isSelected];
	 
	 ElementListFormElement *medsSupplements = (ElementListFormElement*)[_section getElementForKey:MEDS_SUPPLEMENTS_KEY];
	 if (!medsSupplements) {
		 medsSupplements = (ElementListFormElement*)[BBUtil newCoreDataObjectForEntityName:@"ElementListFormElement"];
		 medsSupplements.key = MEDS_SUPPLEMENTS_KEY;
		 [_section addElementsObject:medsSupplements];
	 }

	 NSMutableSet *medsSupplementsElementListArray = [[NSMutableSet alloc] init];
	 for (int i = 0; i < [self.medsSupplementsTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.medsSupplementsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 MedicationFormElement *elementListFormElement = [FormElementTableCellFactory getElementForMedicationCell:cell withElement:nil];		 [medsSupplementsElementListArray addObject:elementListFormElement];
	 }
	 for (FormElement *element in medsSupplements.elements) {
		 [BBUtil deleteManagedObject:element];
	 }
	 [[medsSupplements mutableSetValueForKey:@"elements"] removeAllObjects];
	 [medsSupplements addElements:medsSupplementsElementListArray];
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addMedsSupplements:(id)sender {
	 MedicationFormElement *formElement = (MedicationFormElement*)[BBUtil newCoreDataObjectForEntityName:@"MedicationFormElement"];
	 formElement.name = self.medsSupplementsNameTextField.text;
	 formElement.dose = self.medsSupplementsDoseTextField.text;
	 formElement.doseUnit = self.medsSupplementsDoseUnitButton.titleLabel.text;
	 [self.medsSupplementsTableAdapter.items addObject:formElement];
	 [self.medsSupplementsTable reloadData];
	 self.medsSupplementsNameTextField.text = @"";
	 self.medsSupplementsDoseTextField.text = @"";
	 [self.medsSupplementsNameTextField resignFirstResponder];
	 [self.medsSupplementsDoseTextField resignFirstResponder];
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
	 return MEDICATIONS_SUPPLEMENTS_SECTION_TITLE;
}
@end