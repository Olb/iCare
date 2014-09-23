
#import "PersonnelViewController.h"
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


@interface PersonnelViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *responsibleMdUITextField;
@property (weak, nonatomic) IBOutlet UITextField *surgeonTextField;
@property (weak, nonatomic) IBOutlet UITableView *surgeonTable;
@property (strong, nonatomic) StringArrayTableAdapter *surgeonTableAdapter;
@property (weak, nonatomic) IBOutlet UITextField *anesthesiologistTextField;
@property (weak, nonatomic) IBOutlet UITableView *anesthesiologistTable;
@property (strong, nonatomic) StringArrayTableAdapter *anesthesiologistTableAdapter;
@property (weak, nonatomic) IBOutlet UITextField *crnaAaaTextField;
@property (weak, nonatomic) IBOutlet UITableView *crnaAaaTable;
@property (strong, nonatomic) StringArrayTableAdapter *crnaAaaTableAdapter;
@end

@implementation PersonnelViewController
NSString *const PERSONNEL_SECTION_TITLE = @"PersonnelSectionKey";
static NSString *const RESPONSIBLE_MD_KEY = @"ResponsibleMdKey";
static NSString *const SURGEON_KEY = @"SurgeonKey";
static NSString *const ANESTHESIOLOGIST_KEY = @"AnesthesiologistKey";
static NSString *const CRNA_AAA_KEY = @"CrnaAaaKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.surgeonTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.surgeonTable.dataSource = self.surgeonTableAdapter;
	 self.surgeonTable.delegate = self.surgeonTableAdapter;

	 self.anesthesiologistTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.anesthesiologistTable.dataSource = self.anesthesiologistTableAdapter;
	 self.anesthesiologistTable.delegate = self.anesthesiologistTableAdapter;

	 self.crnaAaaTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.crnaAaaTable.dataSource = self.crnaAaaTableAdapter;
	 self.crnaAaaTable.delegate = self.crnaAaaTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:RESPONSIBLE_MD_KEY]){
				 [self.responsibleMdUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:SURGEON_KEY]){
				 self.surgeonTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.surgeonTable reloadData];
			 }
			 if ([element.key isEqualToString:ANESTHESIOLOGIST_KEY]){
				 self.anesthesiologistTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.anesthesiologistTable reloadData];
			 }
			 if ([element.key isEqualToString:CRNA_AAA_KEY]){
				 self.crnaAaaTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.crnaAaaTable reloadData];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:RESPONSIBLE_MD_KEY]!= nil, @"ResponsibleMd is nil");
	 NSAssert([section getElementForKey:SURGEON_KEY]!= nil, @"Surgeon is nil");
	 NSAssert([section getElementForKey:ANESTHESIOLOGIST_KEY]!= nil, @"Anesthesiologist is nil");
	 NSAssert([section getElementForKey:CRNA_AAA_KEY]!= nil, @"CrnaAaa is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PERSONNEL_SECTION_TITLE;
	 }
	 
	 TextElement *responsibleMd = (TextElement*)[_section getElementForKey:RESPONSIBLE_MD_KEY];
	 if (!responsibleMd) {
		 responsibleMd = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 responsibleMd.key = RESPONSIBLE_MD_KEY;
		 [_section addElementsObject:responsibleMd];
	 }

	 responsibleMd.value = self.responsibleMdUITextField.text;
	 
	 StringListElement *surgeon = (StringListElement*)[_section getElementForKey:SURGEON_KEY];
	 if (!surgeon) {
		 surgeon = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 surgeon.key = SURGEON_KEY;
		 [_section addElementsObject:surgeon];
	 }

	 NSMutableArray *surgeonStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.surgeonTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.surgeonTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [surgeonStringArray addObject:cell.textLabel.text];
	 }
	 surgeon.value = surgeonStringArray;
	 
	 StringListElement *anesthesiologist = (StringListElement*)[_section getElementForKey:ANESTHESIOLOGIST_KEY];
	 if (!anesthesiologist) {
		 anesthesiologist = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 anesthesiologist.key = ANESTHESIOLOGIST_KEY;
		 [_section addElementsObject:anesthesiologist];
	 }

	 NSMutableArray *anesthesiologistStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.anesthesiologistTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.anesthesiologistTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [anesthesiologistStringArray addObject:cell.textLabel.text];
	 }
	 anesthesiologist.value = anesthesiologistStringArray;
	 
	 StringListElement *crnaAaa = (StringListElement*)[_section getElementForKey:CRNA_AAA_KEY];
	 if (!crnaAaa) {
		 crnaAaa = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 crnaAaa.key = CRNA_AAA_KEY;
		 [_section addElementsObject:crnaAaa];
	 }

	 NSMutableArray *crnaAaaStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.crnaAaaTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.crnaAaaTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [crnaAaaStringArray addObject:cell.textLabel.text];
	 }
	 crnaAaa.value = crnaAaaStringArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addSurgeon:(id)sender {
	 [self.surgeonTableAdapter.items addObject:self.surgeonTextField.text];
	 [self.surgeonTable reloadData];
	 self.surgeonTextField.text = @"";
	 [self.surgeonTextField resignFirstResponder];
}

- (IBAction)addAnesthesiologist:(id)sender {
	 [self.anesthesiologistTableAdapter.items addObject:self.anesthesiologistTextField.text];
	 [self.anesthesiologistTable reloadData];
	 self.anesthesiologistTextField.text = @"";
	 [self.anesthesiologistTextField resignFirstResponder];
}

- (IBAction)addCrnaAaa:(id)sender {
	 [self.crnaAaaTableAdapter.items addObject:self.crnaAaaTextField.text];
	 [self.crnaAaaTable reloadData];
	 self.crnaAaaTextField.text = @"";
	 [self.crnaAaaTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return PERSONNEL_SECTION_TITLE;
}
@end