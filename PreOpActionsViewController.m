
#import "PreOpActionsViewController.h"
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


@interface PreOpActionsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *checkConsentsBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *startIvBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *otherActionsTextField;
@property (weak, nonatomic) IBOutlet UITableView *otherActionsTable;
@property (strong, nonatomic) StringArrayTableAdapter *otherActionsTableAdapter;
@end

@implementation PreOpActionsViewController
NSString *const PRE_OP_ACTIONS_SECTION_TITLE = @"PreOpActionsSectionKey";
static NSString *const CHECK_CONSENTS_KEY = @"CheckConsentsKey";
static NSString *const START_IV_KEY = @"StartIvKey";
static NSString *const OTHER_ACTIONS_KEY = @"OtherActionsKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.otherActionsTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.otherActionsTable.dataSource = self.otherActionsTableAdapter;
	 self.otherActionsTable.delegate = self.otherActionsTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:CHECK_CONSENTS_KEY]){
				 [self.checkConsentsBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:START_IV_KEY]){
				 [self.startIvBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OTHER_ACTIONS_KEY]){
				 self.otherActionsTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.otherActionsTable reloadData];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:CHECK_CONSENTS_KEY]!= nil, @"CheckConsents is nil");
	 NSAssert([section getElementForKey:START_IV_KEY]!= nil, @"StartIv is nil");
	 NSAssert([section getElementForKey:OTHER_ACTIONS_KEY]!= nil, @"OtherActions is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PRE_OP_ACTIONS_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *checkConsents = (BooleanFormElement*)[_section getElementForKey:CHECK_CONSENTS_KEY];
	 if (!checkConsents) {
		 checkConsents = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 checkConsents.key = CHECK_CONSENTS_KEY;
		 [_section addElementsObject:checkConsents];
	 }

	 checkConsents.value = [NSNumber numberWithBool:self.checkConsentsBBCheckBox.isSelected];
	 
	 BooleanFormElement *startIv = (BooleanFormElement*)[_section getElementForKey:START_IV_KEY];
	 if (!startIv) {
		 startIv = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 startIv.key = START_IV_KEY;
		 [_section addElementsObject:startIv];
	 }

	 startIv.value = [NSNumber numberWithBool:self.startIvBBCheckBox.isSelected];
	 
	 StringListElement *otherActions = (StringListElement*)[_section getElementForKey:OTHER_ACTIONS_KEY];
	 if (!otherActions) {
		 otherActions = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 otherActions.key = OTHER_ACTIONS_KEY;
		 [_section addElementsObject:otherActions];
	 }

	 NSMutableArray *otherActionsStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.otherActionsTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.otherActionsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [otherActionsStringArray addObject:cell.textLabel.text];
	 }
	 otherActions.value = otherActionsStringArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOtherActions:(id)sender {
	 [self.otherActionsTableAdapter.items addObject:self.otherActionsTextField.text];
	 [self.otherActionsTable reloadData];
	 self.otherActionsTextField.text = @"";
	 [self.otherActionsTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return PRE_OP_ACTIONS_SECTION_TITLE;
}
@end