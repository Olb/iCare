
#import "AnesthesiaTypeViewController.h"
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


@interface AnesthesiaTypeViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *generalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *iVRegionalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *spinalBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *epiduralBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *nerveBlockForPostopPainBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *mACBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *axillaryBlockBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *interscaleneBlockBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *otherAnesthesiaTypeTextField;
@property (weak, nonatomic) IBOutlet UITableView *otherAnesthesiaTypeTable;
@property (strong, nonatomic) StringArrayTableAdapter *otherAnesthesiaTypeTableAdapter;
@end

@implementation AnesthesiaTypeViewController
NSString *const ANESTHESIA_TYPE_SECTION_TITLE = @"AnesthesiaTypeSectionKey";
static NSString *const GENERAL_KEY = @"GeneralKey";
static NSString *const IVRegional_KEY = @"IVRegionalKey";
static NSString *const SPINAL_KEY = @"SpinalKey";
static NSString *const EPIDURAL_KEY = @"EpiduralKey";
static NSString *const NERVE_BLOCK_FOR_POSTOP_PAIN_KEY = @"NerveBlockForPostopPainKey";
static NSString *const MAC_KEY = @"MACKey";
static NSString *const AXILLARY_BLOCK_KEY = @"AxillaryBlockKey";
static NSString *const INTERSCALENE_BLOCK_KEY = @"InterscaleneBlockKey";
static NSString *const OTHER_ANESTHESIA_TYPE_KEY = @"OtherAnesthesiaTypeKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 self.otherAnesthesiaTypeTableAdapter = [[StringArrayTableAdapter alloc] init];
	 self.otherAnesthesiaTypeTable.dataSource = self.otherAnesthesiaTypeTableAdapter;
	 self.otherAnesthesiaTypeTable.delegate = self.otherAnesthesiaTypeTableAdapter;

	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:GENERAL_KEY]){
				 [self.generalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:IVRegional_KEY]){
				 [self.iVRegionalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SPINAL_KEY]){
				 [self.spinalBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:EPIDURAL_KEY]){
				 [self.epiduralBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NERVE_BLOCK_FOR_POSTOP_PAIN_KEY]){
				 [self.nerveBlockForPostopPainBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:MAC_KEY]){
				 [self.mACBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:AXILLARY_BLOCK_KEY]){
				 [self.axillaryBlockBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INTERSCALENE_BLOCK_KEY]){
				 [self.interscaleneBlockBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:OTHER_ANESTHESIA_TYPE_KEY]){
				 self.otherAnesthesiaTypeTableAdapter.items = [[NSMutableArray alloc] initWithArray:((StringListElement*)element).value];
				 [self.otherAnesthesiaTypeTable reloadData];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:GENERAL_KEY]!= nil, @"General is nil");
	 NSAssert([section getElementForKey:IVRegional_KEY]!= nil, @"IVRegional is nil");
	 NSAssert([section getElementForKey:SPINAL_KEY]!= nil, @"Spinal is nil");
	 NSAssert([section getElementForKey:EPIDURAL_KEY]!= nil, @"Epidural is nil");
	 NSAssert([section getElementForKey:NERVE_BLOCK_FOR_POSTOP_PAIN_KEY]!= nil, @"NerveBlockForPostopPain is nil");
	 NSAssert([section getElementForKey:MAC_KEY]!= nil, @"MAC is nil");
	 NSAssert([section getElementForKey:AXILLARY_BLOCK_KEY]!= nil, @"AxillaryBlock is nil");
	 NSAssert([section getElementForKey:INTERSCALENE_BLOCK_KEY]!= nil, @"InterscaleneBlock is nil");
	 NSAssert([section getElementForKey:OTHER_ANESTHESIA_TYPE_KEY]!= nil, @"OtherAnesthesiaType is nil");
	 
}

-(BOOL)validateData:(NSString**)errMsg
{
	 return true; 
}

- (IBAction)accept:(id)sender {
	 NSString* errMsg;
	 if ( ! [self validateData: &errMsg] ){
		 [BBUtil showAlertWithMessage:errMsg];
		 return;
	 }
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = ANESTHESIA_TYPE_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *general = (BooleanFormElement*)[_section getElementForKey:GENERAL_KEY];
	 if (!general) {
		 general = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 general.key = GENERAL_KEY;
		 [_section addElementsObject:general];
	 }

	 general.value = [NSNumber numberWithBool:self.generalBBCheckBox.isSelected];
	 
	 BooleanFormElement *iVRegional = (BooleanFormElement*)[_section getElementForKey:IVRegional_KEY];
	 if (!iVRegional) {
		 iVRegional = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 iVRegional.key = IVRegional_KEY;
		 [_section addElementsObject:iVRegional];
	 }

	 iVRegional.value = [NSNumber numberWithBool:self.iVRegionalBBCheckBox.isSelected];
	 
	 BooleanFormElement *spinal = (BooleanFormElement*)[_section getElementForKey:SPINAL_KEY];
	 if (!spinal) {
		 spinal = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 spinal.key = SPINAL_KEY;
		 [_section addElementsObject:spinal];
	 }

	 spinal.value = [NSNumber numberWithBool:self.spinalBBCheckBox.isSelected];
	 
	 BooleanFormElement *epidural = (BooleanFormElement*)[_section getElementForKey:EPIDURAL_KEY];
	 if (!epidural) {
		 epidural = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 epidural.key = EPIDURAL_KEY;
		 [_section addElementsObject:epidural];
	 }

	 epidural.value = [NSNumber numberWithBool:self.epiduralBBCheckBox.isSelected];
	 
	 BooleanFormElement *nerveBlockForPostopPain = (BooleanFormElement*)[_section getElementForKey:NERVE_BLOCK_FOR_POSTOP_PAIN_KEY];
	 if (!nerveBlockForPostopPain) {
		 nerveBlockForPostopPain = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 nerveBlockForPostopPain.key = NERVE_BLOCK_FOR_POSTOP_PAIN_KEY;
		 [_section addElementsObject:nerveBlockForPostopPain];
	 }

	 nerveBlockForPostopPain.value = [NSNumber numberWithBool:self.nerveBlockForPostopPainBBCheckBox.isSelected];
	 
	 BooleanFormElement *mAC = (BooleanFormElement*)[_section getElementForKey:MAC_KEY];
	 if (!mAC) {
		 mAC = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 mAC.key = MAC_KEY;
		 [_section addElementsObject:mAC];
	 }

	 mAC.value = [NSNumber numberWithBool:self.mACBBCheckBox.isSelected];
	 
	 BooleanFormElement *axillaryBlock = (BooleanFormElement*)[_section getElementForKey:AXILLARY_BLOCK_KEY];
	 if (!axillaryBlock) {
		 axillaryBlock = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 axillaryBlock.key = AXILLARY_BLOCK_KEY;
		 [_section addElementsObject:axillaryBlock];
	 }

	 axillaryBlock.value = [NSNumber numberWithBool:self.axillaryBlockBBCheckBox.isSelected];
	 
	 BooleanFormElement *interscaleneBlock = (BooleanFormElement*)[_section getElementForKey:INTERSCALENE_BLOCK_KEY];
	 if (!interscaleneBlock) {
		 interscaleneBlock = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 interscaleneBlock.key = INTERSCALENE_BLOCK_KEY;
		 [_section addElementsObject:interscaleneBlock];
	 }

	 interscaleneBlock.value = [NSNumber numberWithBool:self.interscaleneBlockBBCheckBox.isSelected];
	 
	 StringListElement *otherAnesthesiaType = (StringListElement*)[_section getElementForKey:OTHER_ANESTHESIA_TYPE_KEY];
	 if (!otherAnesthesiaType) {
		 otherAnesthesiaType = (StringListElement*)[BBUtil newCoreDataObjectForEntityName:@"StringListElement"];
		 otherAnesthesiaType.key = OTHER_ANESTHESIA_TYPE_KEY;
		 [_section addElementsObject:otherAnesthesiaType];
	 }

	 NSMutableArray *otherAnesthesiaTypeStringArray = [[NSMutableArray alloc] init];
	 for (int i = 0; i < [self.otherAnesthesiaTypeTable numberOfRowsInSection:0]; i++){
		 UITableViewCell *cell = [self.otherAnesthesiaTypeTable cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
		 [otherAnesthesiaTypeStringArray addObject:cell.textLabel.text];
	 }
	 otherAnesthesiaType.value = otherAnesthesiaTypeStringArray;
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)addOtherAnesthesiaType:(id)sender {
	 [self.otherAnesthesiaTypeTableAdapter.items addObject:self.otherAnesthesiaTypeTextField.text];
	 [self.otherAnesthesiaTypeTable reloadData];
	 self.otherAnesthesiaTypeTextField.text = @"";
	 [self.otherAnesthesiaTypeTextField resignFirstResponder];
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
	 return ANESTHESIA_TYPE_SECTION_TITLE;
}
-(void)radioGroup1:(BBCheckBox*)sender {
	 BOOL selected = sender.selected;
	 sender.selected = selected;
}
@end