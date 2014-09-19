
#import "MedicationsSupplementsViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface MedicationsSupplementsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *betaBlockerBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *medsSupplementsTextField;
@property (weak, nonatomic) IBOutlet UITableView *medsSupplementsTable;
@property (strong, nonatomic) StringArrayTableAdapter *medsSupplementsTableAdapter;
@end

@implementation MedicationsSupplementsViewController
NSString *const MEDICATIONS_SUPPLEMENTS_SECTION_TITLE = @"MedicationsSupplementsSectionKey";
static NSString *const BETA_BLOCKER_KEY = @"BetaBlockerKey";
static NSString *const MEDS_SUPPLEMENTS_KEY = @"MedsSupplementsKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.medsSupplementsTableAdapter = [[StringArrayTableAdapter alloc] init];
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
				 self.medsSupplementsTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
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
	 
	 StringListElement *medsSupplements = (StringListElement*)[_section getElementForKey:MEDS_SUPPLEMENTS_KEY];
	 if (!medsSupplements) {
		 medsSupplements = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 medsSupplements.key = MEDS_SUPPLEMENTS_KEY;
		 [_section addElementsObject:medsSupplements];
	 }

	 NSMutableArray *medsSupplementsStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.medsSupplementsTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.medsSupplementsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [medsSupplementsStringArray addObject:cell.textLabel.text];
	 }
	 medsSupplements.value = medsSupplementsStringArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addMedsSupplements:(id)sender {
	 [self.medsSupplementsTableAdapter.items addObject:self.medsSupplementsTextField.text];
	 [self.medsSupplementsTable reloadData];
	 self.medsSupplementsTextField.text = @"";
	 [self.medsSupplementsTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return MEDICATIONS_SUPPLEMENTS_SECTION_TITLE;
}
@end