#import "PastSurgicalProceduresViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface PastSurgicalProceduresViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *hxAnesthesiaProblemsBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *pastSurgicalProceduresTextField;
@property (weak, nonatomic) IBOutlet UITableView *pastSurgicalProceduresTable;
@property (strong, nonatomic) StringArrayTableAdapter *pastSurgicalProceduresTableAdapter;
@property (weak, nonatomic) IBOutlet BBCheckBox *hxAnesthesiaProblemsYesPatientBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hxAnesthesiaProblemsYesFamilyBBCheckBox;
@end

@implementation PastSurgicalProceduresViewController
NSString *const PAST_SURGICAL_PROCEDURES_SECTION_TITLE = @"PastSurgicalProceduresSectionKey";
NSString *const PAST_SURGICAL_PROCEDURES_KEY = @"PastSurgicalProceduresKey";
NSString *const HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY = @"HxAnesthesiaProblemsYesPatientKey";
NSString *const HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY = @"HxAnesthesiaProblemsYesFamilyKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.pastSurgicalProceduresTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.pastSurgicalProceduresTable.dataSource = self.pastSurgicalProceduresTableAdapter;
	 self.pastSurgicalProceduresTable.delegate = self.pastSurgicalProceduresTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:PAST_SURGICAL_PROCEDURES_KEY]){
				 self.pastSurgicalProceduresTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.pastSurgicalProceduresTable reloadData];
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
	 NSAssert([group getElementForKey:PAST_SURGICAL_PROCEDURES_KEY]!= nil, @"PastSurgicalProcedures is nil");
	 
	 group = [_section.groups objectAtIndex:1];
	 NSAssert(group.optional, @"Expected group to be optional");
	 NSAssert([group getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY]!= nil, @"HxAnesthesiaProblemsYesPatient is nil");
	 NSAssert([group getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY]!= nil, @"HxAnesthesiaProblemsYesFamily is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PAST_SURGICAL_PROCEDURES_SECTION_TITLE;
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

- (IBAction)addPastSurgicalProcedures:(id)sender {
	 [self.pastSurgicalProceduresTableAdapter.items addObject:self.pastSurgicalProceduresTextField.text];
	 [self.pastSurgicalProceduresTable reloadData];
	 self.pastSurgicalProceduresTextField.text = @"";
	 [self.pastSurgicalProceduresTextField resignFirstResponder];
}

- (BOOL)disablesAutomaticKeyboardDismissal {
	 return NO;
}

- (IBAction)dismiss:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return PAST_SURGICAL_PROCEDURES_SECTION_TITLE;
}
@end