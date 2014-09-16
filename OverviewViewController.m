#import "OverviewViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface OverviewViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *hxAnesthesiaProblemsBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *betaBlockerBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *medsSupplementsTextField;
@property (weak, nonatomic) IBOutlet UITableView *medsSupplementsTable;
@property (strong, nonatomic) StringArrayTableAdapter *medsSupplementsTableAdapter;
@property (weak, nonatomic) IBOutlet UITextField *pastSurgicalProceduresTextField;
@property (weak, nonatomic) IBOutlet UITableView *pastSurgicalProceduresTable;
@property (strong, nonatomic) StringArrayTableAdapter *pastSurgicalProceduresTableAdapter;
@property (weak, nonatomic) IBOutlet UITextField *allergiesAndReactionsTextField;
@property (weak, nonatomic) IBOutlet UITableView *allergiesAndReactionsTable;
@property (strong, nonatomic) StringArrayTableAdapter *allergiesAndReactionsTableAdapter;
@property (weak, nonatomic) IBOutlet BBCheckBox *hxAnesthesiaProblemsYesPatientBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hxAnesthesiaProblemsYesFamilyBBCheckBox;
@end

@implementation OverviewViewController
NSString *const OVERVIEW_SECTION_TITLE = @"OverviewSectionKey";
NSString *const BETA_BLOCKER_KEY = @"BetaBlockerKey";
NSString *const MEDS_SUPPLEMENTS_KEY = @"MedsSupplementsKey";
NSString *const PAST_SURGICAL_PROCEDURES_KEY = @"PastSurgicalProceduresKey";
NSString *const ALLERGIES_AND_REACTIONS_KEY = @"AllergiesAndReactionsKey";
NSString *const HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY = @"HxAnesthesiaProblemsYesPatientKey";
NSString *const HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY = @"HxAnesthesiaProblemsYesFamilyKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.medsSupplementsTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.medsSupplementsTable.dataSource = self.medsSupplementsTableAdapter;
	 self.medsSupplementsTable.delegate = self.medsSupplementsTableAdapter;

	 self.pastSurgicalProceduresTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.pastSurgicalProceduresTable.dataSource = self.pastSurgicalProceduresTableAdapter;
	 self.pastSurgicalProceduresTable.delegate = self.pastSurgicalProceduresTableAdapter;

	 self.allergiesAndReactionsTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.allergiesAndReactionsTable.dataSource = self.allergiesAndReactionsTableAdapter;
	 self.allergiesAndReactionsTable.delegate = self.allergiesAndReactionsTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:BETA_BLOCKER_KEY]){
				 [self.betaBlockerBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MEDS_SUPPLEMENTS_KEY]){
				 self.medsSupplementsTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.medsSupplementsTable reloadData];
			 }
			 if ([element.key isEqualToString:PAST_SURGICAL_PROCEDURES_KEY]){
				 self.pastSurgicalProceduresTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.pastSurgicalProceduresTable reloadData];
			 }
			 if ([element.key isEqualToString:ALLERGIES_AND_REACTIONS_KEY]){
				 self.allergiesAndReactionsTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.allergiesAndReactionsTable reloadData];
			 }
			 if ([element.key isEqualToString:HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY]){
				 [self.hxAnesthesiaProblemsYesPatientBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY]){
				 [self.hxAnesthesiaProblemsYesFamilyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
				 [self.hxAnesthesiaProblemsBBCheckBox setSelected:[((FormGroup *)[_section.groups objectAtIndex:1]).selected boolValue]];
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
	 NSAssert([group getElementForKey:BETA_BLOCKER_KEY]!= nil, @"BetaBlocker is nil");
	 NSAssert([group getElementForKey:MEDS_SUPPLEMENTS_KEY]!= nil, @"MedsSupplements is nil");
	 NSAssert([group getElementForKey:PAST_SURGICAL_PROCEDURES_KEY]!= nil, @"PastSurgicalProcedures is nil");
	 NSAssert([group getElementForKey:ALLERGIES_AND_REACTIONS_KEY]!= nil, @"AllergiesAndReactions is nil");
	 
	 group = [_section.groups objectAtIndex:1];
	 NSAssert(group.optional, @"Expected group to be optional");
	 NSAssert([group getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY]!= nil, @"HxAnesthesiaProblemsYesPatient is nil");
	 NSAssert([group getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY]!= nil, @"HxAnesthesiaProblemsYesFamily is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = OVERVIEW_SECTION_TITLE;
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
	 BooleanFormElement *betaBlocker = (BooleanFormElement*)[group getElementForKey:BETA_BLOCKER_KEY];
	 if (!betaBlocker) {
		 betaBlocker = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 betaBlocker.key = BETA_BLOCKER_KEY;
		 [group addElementsObject:betaBlocker];
	 }

	 betaBlocker.value = [NSNumber numberWithBool:self.betaBlockerBBCheckBox.isSelected];
	 
	 StringListElement *medsSupplements = (StringListElement*)[group getElementForKey:MEDS_SUPPLEMENTS_KEY];
	 if (!medsSupplements) {
		 medsSupplements = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 medsSupplements.key = MEDS_SUPPLEMENTS_KEY;
		 [group addElementsObject:medsSupplements];
	 }

	 NSMutableArray *medsSupplementsStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.medsSupplementsTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.medsSupplementsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [medsSupplementsStringArray addObject:cell.textLabel.text];
	 }
	 medsSupplements.value = medsSupplementsStringArray;
	 
	 StringListElement *pastSurgicalProcedures = (StringListElement*)[group getElementForKey:PAST_SURGICAL_PROCEDURES_KEY];
	 if (!pastSurgicalProcedures) {
		 pastSurgicalProcedures = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 pastSurgicalProcedures.key = PAST_SURGICAL_PROCEDURES_KEY;
		 [group addElementsObject:pastSurgicalProcedures];
	 }

	 NSMutableArray *pastSurgicalProceduresStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.pastSurgicalProceduresTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.pastSurgicalProceduresTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [pastSurgicalProceduresStringArray addObject:cell.textLabel.text];
	 }
	 pastSurgicalProcedures.value = pastSurgicalProceduresStringArray;
	 
	 StringListElement *allergiesAndReactions = (StringListElement*)[group getElementForKey:ALLERGIES_AND_REACTIONS_KEY];
	 if (!allergiesAndReactions) {
		 allergiesAndReactions = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 allergiesAndReactions.key = ALLERGIES_AND_REACTIONS_KEY;
		 [group addElementsObject:allergiesAndReactions];
	 }

	 NSMutableArray *allergiesAndReactionsStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.allergiesAndReactionsTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.allergiesAndReactionsTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [allergiesAndReactionsStringArray addObject:cell.textLabel.text];
	 }
	 allergiesAndReactions.value = allergiesAndReactionsStringArray;
	 
	 group = nil;
	 if ([self.section.groups count] > 1) {
		 group = [self.section.groups objectAtIndex:1];
	 }
	 if ( !group ){
		 group =(FormGroup*)[BBUtil newCoreDataObjectForEntityName:@"FormGroup"];
		 group.optional = [NSNumber numberWithBool:true];
		 [self.section addGroupsObject:group];
	 }
	 group.selected = [NSNumber numberWithBool:self.hxAnesthesiaProblemsBBCheckBox.isSelected];
	 BooleanFormElement *hxAnesthesiaProblemsYesPatient = (BooleanFormElement*)[group getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY];
	 if (!hxAnesthesiaProblemsYesPatient) {
		 hxAnesthesiaProblemsYesPatient = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hxAnesthesiaProblemsYesPatient.key = HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY;
		 [group addElementsObject:hxAnesthesiaProblemsYesPatient];
	 }

	 hxAnesthesiaProblemsYesPatient.value = [NSNumber numberWithBool:self.hxAnesthesiaProblemsYesPatientBBCheckBox.isSelected];
	 
	 BooleanFormElement *hxAnesthesiaProblemsYesFamily = (BooleanFormElement*)[group getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY];
	 if (!hxAnesthesiaProblemsYesFamily) {
		 hxAnesthesiaProblemsYesFamily = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hxAnesthesiaProblemsYesFamily.key = HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY;
		 [group addElementsObject:hxAnesthesiaProblemsYesFamily];
	 }

	 hxAnesthesiaProblemsYesFamily.value = [NSNumber numberWithBool:self.hxAnesthesiaProblemsYesFamilyBBCheckBox.isSelected];
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addMedsSupplements:(id)sender {
	 [self.medsSupplementsTableAdapter.items addObject:self.medsSupplementsTextField.text];
	 [self.medsSupplementsTable reloadData];
	 self.medsSupplementsTextField.text = @"";
	 [self.medsSupplementsTextField resignFirstResponder];
}

- (IBAction)addPastSurgicalProcedures:(id)sender {
	 [self.pastSurgicalProceduresTableAdapter.items addObject:self.pastSurgicalProceduresTextField.text];
	 [self.pastSurgicalProceduresTable reloadData];
	 self.pastSurgicalProceduresTextField.text = @"";
	 [self.pastSurgicalProceduresTextField resignFirstResponder];
}

- (IBAction)addAllergiesAndReactions:(id)sender {
	 [self.allergiesAndReactionsTableAdapter.items addObject:self.allergiesAndReactionsTextField.text];
	 [self.allergiesAndReactionsTable reloadData];
	 self.allergiesAndReactionsTextField.text = @"";
	 [self.allergiesAndReactionsTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return OVERVIEW_SECTION_TITLE;
}
@end