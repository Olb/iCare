
#import "PastSurgicalProceduresViewController.h"
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


@interface PastSurgicalProceduresViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *pastSurgicalProceduresTextField;
@property (weak, nonatomic) IBOutlet UITableView *pastSurgicalProceduresTable;
@property (strong, nonatomic) StringArrayTableAdapter *pastSurgicalProceduresTableAdapter;
@property (weak, nonatomic) IBOutlet BBCheckBox *hxAnesthesiaProblemsYesPatientBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hxAnesthesiaProblemsYesFamilyBBCheckBox;
@end

@implementation PastSurgicalProceduresViewController
NSString *const PAST_SURGICAL_PROCEDURES_SECTION_TITLE = @"PastSurgicalProceduresSectionKey";
static NSString *const PAST_SURGICAL_PROCEDURES_KEY = @"PastSurgicalProceduresKey";
static NSString *const HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY = @"HxAnesthesiaProblemsYesPatientKey";
static NSString *const HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY = @"HxAnesthesiaProblemsYesFamilyKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.pastSurgicalProceduresTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.pastSurgicalProceduresTable.dataSource = self.pastSurgicalProceduresTableAdapter;
	 self.pastSurgicalProceduresTable.delegate = self.pastSurgicalProceduresTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

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
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:PAST_SURGICAL_PROCEDURES_KEY]!= nil, @"PastSurgicalProcedures is nil");
	 NSAssert([section getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY]!= nil, @"HxAnesthesiaProblemsYesPatient is nil");
	 NSAssert([section getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY]!= nil, @"HxAnesthesiaProblemsYesFamily is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = PAST_SURGICAL_PROCEDURES_SECTION_TITLE;
	 }
	 
	 StringListElement *pastSurgicalProcedures = (StringListElement*)[_section getElementForKey:PAST_SURGICAL_PROCEDURES_KEY];
	 if (!pastSurgicalProcedures) {
		 pastSurgicalProcedures = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 pastSurgicalProcedures.key = PAST_SURGICAL_PROCEDURES_KEY;
		 [_section addElementsObject:pastSurgicalProcedures];
	 }

	 NSMutableArray *pastSurgicalProceduresStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.pastSurgicalProceduresTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.pastSurgicalProceduresTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [pastSurgicalProceduresStringArray addObject:cell.textLabel.text];
	 }
	 pastSurgicalProcedures.value = pastSurgicalProceduresStringArray;
	 
	 BooleanFormElement *hxAnesthesiaProblemsYesPatient = (BooleanFormElement*)[_section getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY];
	 if (!hxAnesthesiaProblemsYesPatient) {
		 hxAnesthesiaProblemsYesPatient = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hxAnesthesiaProblemsYesPatient.key = HX_ANESTHESIA_PROBLEMS_YES_PATIENT_KEY;
		 [_section addElementsObject:hxAnesthesiaProblemsYesPatient];
	 }

	 hxAnesthesiaProblemsYesPatient.value = [NSNumber numberWithBool:self.hxAnesthesiaProblemsYesPatientBBCheckBox.isSelected];
	 
	 BooleanFormElement *hxAnesthesiaProblemsYesFamily = (BooleanFormElement*)[_section getElementForKey:HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY];
	 if (!hxAnesthesiaProblemsYesFamily) {
		 hxAnesthesiaProblemsYesFamily = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hxAnesthesiaProblemsYesFamily.key = HX_ANESTHESIA_PROBLEMS_YES_FAMILY_KEY;
		 [_section addElementsObject:hxAnesthesiaProblemsYesFamily];
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
	 [BBUtil refreshManagedObject:_section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

+(NSString*)sectionTitle
{
	 return PAST_SURGICAL_PROCEDURES_SECTION_TITLE;
}
@end