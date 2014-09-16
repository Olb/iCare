#import "PremedsGivenViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface PremedsGivenViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *midazolamBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *midazolamDoseUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *ondansetronBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *ondansetronDoseUITextField;
@property (weak, nonatomic) IBOutlet UITextField *otherPremedsGivenTextField;
@property (weak, nonatomic) IBOutlet UITableView *otherPremedsGivenTable;
@property (strong, nonatomic) StringArrayTableAdapter *otherPremedsGivenTableAdapter;
@end

@implementation PremedsGivenViewController
NSString *const PREMEDS_GIVEN_SECTION_TITLE = @"PremedsGivenSectionKey";
NSString *const MIDAZOLAM_KEY = @"MidazolamKey";
NSString *const MIDAZOLAM_DOSE_KEY = @"MidazolamDoseKey";
NSString *const ONDANSETRON_KEY = @"OndansetronKey";
NSString *const ONDANSETRON_DOSE_KEY = @"OndansetronDoseKey";
NSString *const OTHER_PREMEDS_GIVEN_KEY = @"OtherPremedsGivenKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.otherPremedsGivenTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.otherPremedsGivenTable.dataSource = self.otherPremedsGivenTableAdapter;
	 self.otherPremedsGivenTable.delegate = self.otherPremedsGivenTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:MIDAZOLAM_KEY]){
				 [self.midazolamBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MIDAZOLAM_DOSE_KEY]){
				 [self.midazolamDoseUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:ONDANSETRON_KEY]){
				 [self.ondansetronBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ONDANSETRON_DOSE_KEY]){
				 [self.ondansetronDoseUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:OTHER_PREMEDS_GIVEN_KEY]){
				 self.otherPremedsGivenTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.otherPremedsGivenTable reloadData];
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
	 NSAssert([group getElementForKey:MIDAZOLAM_KEY]!= nil, @"Midazolam is nil");
	 NSAssert([group getElementForKey:MIDAZOLAM_DOSE_KEY]!= nil, @"MidazolamDose is nil");
	 NSAssert([group getElementForKey:ONDANSETRON_KEY]!= nil, @"Ondansetron is nil");
	 NSAssert([group getElementForKey:ONDANSETRON_DOSE_KEY]!= nil, @"OndansetronDose is nil");
	 NSAssert([group getElementForKey:OTHER_PREMEDS_GIVEN_KEY]!= nil, @"OtherPremedsGiven is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PREMEDS_GIVEN_SECTION_TITLE;
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
	 BooleanFormElement *midazolam = (BooleanFormElement*)[group getElementForKey:MIDAZOLAM_KEY];
	 if (!midazolam) {
		 midazolam = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 midazolam.key = MIDAZOLAM_KEY;
		 [group addElementsObject:midazolam];
	 }

	 midazolam.value = [NSNumber numberWithBool:self.midazolamBBCheckBox.isSelected];
	 
	 TextElement *midazolamDose = (TextElement*)[group getElementForKey:MIDAZOLAM_DOSE_KEY];
	 if (!midazolamDose) {
		 midazolamDose = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 midazolamDose.key = MIDAZOLAM_DOSE_KEY;
		 [group addElementsObject:midazolamDose];
	 }

	 midazolamDose.value = self.midazolamDoseUITextField.text;
	 
	 BooleanFormElement *ondansetron = (BooleanFormElement*)[group getElementForKey:ONDANSETRON_KEY];
	 if (!ondansetron) {
		 ondansetron = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 ondansetron.key = ONDANSETRON_KEY;
		 [group addElementsObject:ondansetron];
	 }

	 ondansetron.value = [NSNumber numberWithBool:self.ondansetronBBCheckBox.isSelected];
	 
	 TextElement *ondansetronDose = (TextElement*)[group getElementForKey:ONDANSETRON_DOSE_KEY];
	 if (!ondansetronDose) {
		 ondansetronDose = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 ondansetronDose.key = ONDANSETRON_DOSE_KEY;
		 [group addElementsObject:ondansetronDose];
	 }

	 ondansetronDose.value = self.ondansetronDoseUITextField.text;
	 
	 StringListElement *otherPremedsGiven = (StringListElement*)[group getElementForKey:OTHER_PREMEDS_GIVEN_KEY];
	 if (!otherPremedsGiven) {
		 otherPremedsGiven = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 otherPremedsGiven.key = OTHER_PREMEDS_GIVEN_KEY;
		 [group addElementsObject:otherPremedsGiven];
	 }

	 NSMutableArray *otherPremedsGivenStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.otherPremedsGivenTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.otherPremedsGivenTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [otherPremedsGivenStringArray addObject:cell.textLabel.text];
	 }
	 otherPremedsGiven.value = otherPremedsGivenStringArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOtherPremedsGiven:(id)sender {
	 [self.otherPremedsGivenTableAdapter.items addObject:self.otherPremedsGivenTextField.text];
	 [self.otherPremedsGivenTable reloadData];
	 self.otherPremedsGivenTextField.text = @"";
	 [self.otherPremedsGivenTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return PREMEDS_GIVEN_SECTION_TITLE;
}
@end