
#import "AllergiesReactionsViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface AllergiesReactionsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *noKnownAllergiesBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *allergiesReactionsTextField;
@property (weak, nonatomic) IBOutlet UITableView *allergiesReactionsTable;
@property (strong, nonatomic) StringArrayTableAdapter *allergiesReactionsTableAdapter;
@end

@implementation AllergiesReactionsViewController
NSString *const ALLERGIES_REACTIONS_SECTION_TITLE = @"AllergiesReactionsSectionKey";
static NSString *const NO_KNOWN_ALLERGIES_KEY = @"NoKnownAllergiesKey";
static NSString *const ALLERGIES_REACTIONS_KEY = @"AllergiesReactionsKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.allergiesReactionsTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.allergiesReactionsTable.dataSource = self.allergiesReactionsTableAdapter;
	 self.allergiesReactionsTable.delegate = self.allergiesReactionsTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:NO_KNOWN_ALLERGIES_KEY]){
				 [self.noKnownAllergiesBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ALLERGIES_REACTIONS_KEY]){
				 self.allergiesReactionsTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.allergiesReactionsTable reloadData];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:NO_KNOWN_ALLERGIES_KEY]!= nil, @"NoKnownAllergies is nil");
	 NSAssert([section getElementForKey:ALLERGIES_REACTIONS_KEY]!= nil, @"AllergiesReactions is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = ALLERGIES_REACTIONS_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *noKnownAllergies = (BooleanFormElement*)[_section getElementForKey:NO_KNOWN_ALLERGIES_KEY];
	 if (!noKnownAllergies) {
		 noKnownAllergies = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 noKnownAllergies.key = NO_KNOWN_ALLERGIES_KEY;
		 [_section addElementsObject:noKnownAllergies];
	 }

	 noKnownAllergies.value = [NSNumber numberWithBool:self.noKnownAllergiesBBCheckBox.isSelected];
	 
	 StringListElement *allergiesReactions = (StringListElement*)[_section getElementForKey:ALLERGIES_REACTIONS_KEY];
	 if (!allergiesReactions) {
		 allergiesReactions = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 allergiesReactions.key = ALLERGIES_REACTIONS_KEY;
		 [_section addElementsObject:allergiesReactions];
	 }

	 NSMutableArray *allergiesReactionsStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.allergiesReactionsTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.allergiesReactionsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [allergiesReactionsStringArray addObject:cell.textLabel.text];
	 }
	 allergiesReactions.value = allergiesReactionsStringArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addAllergiesReactions:(id)sender {
	 [self.allergiesReactionsTableAdapter.items addObject:self.allergiesReactionsTextField.text];
	 [self.allergiesReactionsTable reloadData];
	 self.allergiesReactionsTextField.text = @"";
	 [self.allergiesReactionsTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return ALLERGIES_REACTIONS_SECTION_TITLE;
}
@end