#import "AllergiesReactionsViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface AllergiesReactionsViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *allergiesReactionsTextField;
@property (weak, nonatomic) IBOutlet UITableView *allergiesReactionsTable;
@property (strong, nonatomic) StringArrayTableAdapter *allergiesReactionsTableAdapter;
@end

@implementation AllergiesReactionsViewController
NSString *const ALLERGIES_REACTIONS_SECTION_TITLE = @"AllergiesReactionsSectionKey";
NSString *const ALLERGIES_REACTIONS_KEY = @"AllergiesReactionsKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.allergiesReactionsTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.allergiesReactionsTable.dataSource = self.allergiesReactionsTableAdapter;
	 self.allergiesReactionsTable.delegate = self.allergiesReactionsTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:ALLERGIES_REACTIONS_KEY]){
				 self.allergiesReactionsTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.allergiesReactionsTable reloadData];
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
	 NSAssert([group getElementForKey:ALLERGIES_REACTIONS_KEY]!= nil, @"AllergiesReactions is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = ALLERGIES_REACTIONS_SECTION_TITLE;
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
	 StringListElement *allergiesReactions = (StringListElement*)[group getElementForKey:ALLERGIES_REACTIONS_KEY];
	 if (!allergiesReactions) {
		 allergiesReactions = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 allergiesReactions.key = ALLERGIES_REACTIONS_KEY;
		 [group addElementsObject:allergiesReactions];
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