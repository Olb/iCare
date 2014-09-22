
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


@interface IVAntibioticNameViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITableView *ivAntibioticTable;
@property (strong, nonatomic) FormElementTableAdapter *ivAntibioticTableAdapter;
@property (weak, nonatomic) IBOutlet UITextField *ivAntibioticNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *ivAntibioticDoseTextField;
@property (weak, nonatomic) IBOutlet UIButton *ivAntibioticDoseUnitButton;
@property (weak, nonatomic) IBOutlet UITextField *ivAntibioticStartTimeTextField;
@end

@implementation IVAntibioticNameViewController
NSString *const IVAntibiotic_NAME_SECTION_TITLE = @"IVAntibioticNameSectionKey";
static NSString *const IV_ANTIBIOTIC_KEY = @"IvAntibioticKey";

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
				 self.ivAntibioticTableAdapter.items = [[NSMutableArray alloc] initWithArray:((ElementListFormElement*)element).value];
				 [self.ivAntibioticTable reloadData];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:IV_ANTIBIOTIC_KEY]!= nil, @"IvAntibiotic is nil");
	 
}

- (IBAction)accept:(id)sender {
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

	 NSMutableArray *ivAntibioticElementListArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.ivAntibioticTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.ivAntibioticTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 AntibioticFormElement *elementListFormElement = [FormElementTableCellFactory getElementForAntibioticCell:cell withElement:nil];		 [ivAntibioticElementListArray addObject:elementListFormElement];
	 }
	 ivAntibiotic.value = ivAntibioticElementListArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return IVAntibiotic_NAME_SECTION_TITLE;
}
@end