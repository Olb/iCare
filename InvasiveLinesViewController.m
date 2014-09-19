
#import "InvasiveLinesViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface InvasiveLinesViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *aLineBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *centralVenousCatheterBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *paCatheterBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nasoGastricTubeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *oroGastricTubeBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *ivsTextField;
@property (weak, nonatomic) IBOutlet UITableView *ivsTable;
@property (strong, nonatomic) StringArrayTableAdapter *ivsTableAdapter;
@end

@implementation InvasiveLinesViewController
NSString *const INVASIVE_LINES_SECTION_TITLE = @"InvasiveLinesSectionKey";
static NSString *const ALine_KEY = @"ALineKey";
static NSString *const CENTRAL_VENOUS_CATHETER_KEY = @"CentralVenousCatheterKey";
static NSString *const PA_CATHETER_KEY = @"PaCatheterKey";
static NSString *const NASO_GASTRIC_TUBE_KEY = @"NasoGastricTubeKey";
static NSString *const ORO_GASTRIC_TUBE_KEY = @"OroGastricTubeKey";
static NSString *const ivs_KEY = @"ivsKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.ivsTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.ivsTable.dataSource = self.ivsTableAdapter;
	 self.ivsTable.delegate = self.ivsTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:ALine_KEY]){
				 [self.aLineBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CENTRAL_VENOUS_CATHETER_KEY]){
				 [self.centralVenousCatheterBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:PA_CATHETER_KEY]){
				 [self.paCatheterBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NASO_GASTRIC_TUBE_KEY]){
				 [self.nasoGastricTubeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ORO_GASTRIC_TUBE_KEY]){
				 [self.oroGastricTubeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ivs_KEY]){
				 self.ivsTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.ivsTable reloadData];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:ALine_KEY]!= nil, @"ALine is nil");
	 NSAssert([section getElementForKey:CENTRAL_VENOUS_CATHETER_KEY]!= nil, @"CentralVenousCatheter is nil");
	 NSAssert([section getElementForKey:PA_CATHETER_KEY]!= nil, @"PaCatheter is nil");
	 NSAssert([section getElementForKey:NASO_GASTRIC_TUBE_KEY]!= nil, @"NasoGastricTube is nil");
	 NSAssert([section getElementForKey:ORO_GASTRIC_TUBE_KEY]!= nil, @"OroGastricTube is nil");
	 NSAssert([section getElementForKey:ivs_KEY]!= nil, @"ivs is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = INVASIVE_LINES_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *aLine = (BooleanFormElement*)[_section getElementForKey:ALine_KEY];
	 if (!aLine) {
		 aLine = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 aLine.key = ALine_KEY;
		 [_section addElementsObject:aLine];
	 }

	 aLine.value = [NSNumber numberWithBool:self.aLineBBCheckBox.isSelected];
	 
	 BooleanFormElement *centralVenousCatheter = (BooleanFormElement*)[_section getElementForKey:CENTRAL_VENOUS_CATHETER_KEY];
	 if (!centralVenousCatheter) {
		 centralVenousCatheter = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 centralVenousCatheter.key = CENTRAL_VENOUS_CATHETER_KEY;
		 [_section addElementsObject:centralVenousCatheter];
	 }

	 centralVenousCatheter.value = [NSNumber numberWithBool:self.centralVenousCatheterBBCheckBox.isSelected];
	 
	 BooleanFormElement *paCatheter = (BooleanFormElement*)[_section getElementForKey:PA_CATHETER_KEY];
	 if (!paCatheter) {
		 paCatheter = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 paCatheter.key = PA_CATHETER_KEY;
		 [_section addElementsObject:paCatheter];
	 }

	 paCatheter.value = [NSNumber numberWithBool:self.paCatheterBBCheckBox.isSelected];
	 
	 BooleanFormElement *nasoGastricTube = (BooleanFormElement*)[_section getElementForKey:NASO_GASTRIC_TUBE_KEY];
	 if (!nasoGastricTube) {
		 nasoGastricTube = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nasoGastricTube.key = NASO_GASTRIC_TUBE_KEY;
		 [_section addElementsObject:nasoGastricTube];
	 }

	 nasoGastricTube.value = [NSNumber numberWithBool:self.nasoGastricTubeBBCheckBox.isSelected];
	 
	 BooleanFormElement *oroGastricTube = (BooleanFormElement*)[_section getElementForKey:ORO_GASTRIC_TUBE_KEY];
	 if (!oroGastricTube) {
		 oroGastricTube = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 oroGastricTube.key = ORO_GASTRIC_TUBE_KEY;
		 [_section addElementsObject:oroGastricTube];
	 }

	 oroGastricTube.value = [NSNumber numberWithBool:self.oroGastricTubeBBCheckBox.isSelected];
	 
	 StringListElement *ivs = (StringListElement*)[_section getElementForKey:ivs_KEY];
	 if (!ivs) {
		 ivs = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 ivs.key = ivs_KEY;
		 [_section addElementsObject:ivs];
	 }

	 NSMutableArray *ivsStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.ivsTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.ivsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [ivsStringArray addObject:cell.textLabel.text];
	 }
	 ivs.value = ivsStringArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addivs:(id)sender {
	 [self.ivsTableAdapter.items addObject:self.ivsTextField.text];
	 [self.ivsTable reloadData];
	 self.ivsTextField.text = @"";
	 [self.ivsTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return INVASIVE_LINES_SECTION_TITLE;
}
@end