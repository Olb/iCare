
#import "EmergenceViewController.h"
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


@interface EmergenceViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *adequateBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *intubatedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *directToIcuBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *suctionedExtubatedBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *o2ForTransportBBCheckBox;
@end

@implementation EmergenceViewController
NSString *const EMERGENCE_SECTION_TITLE = @"EmergenceSectionKey";
static NSString *const ADEQUATE_KEY = @"AdequateKey";
static NSString *const INTUBATED_KEY = @"IntubatedKey";
static NSString *const DIRECT_TO_ICU_KEY = @"DirectToIcuKey";
static NSString *const SUCTIONED_EXTUBATED_KEY = @"SuctionedExtubatedKey";
static NSString *const O2For_TRANSPORT_KEY = @"O2ForTransportKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:ADEQUATE_KEY]){
				 [self.adequateBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:INTUBATED_KEY]){
				 [self.intubatedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DIRECT_TO_ICU_KEY]){
				 [self.directToIcuBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:SUCTIONED_EXTUBATED_KEY]){
				 [self.suctionedExtubatedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:O2For_TRANSPORT_KEY]){
				 [self.o2ForTransportBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:ADEQUATE_KEY]!= nil, @"Adequate is nil");
	 NSAssert([section getElementForKey:INTUBATED_KEY]!= nil, @"Intubated is nil");
	 NSAssert([section getElementForKey:DIRECT_TO_ICU_KEY]!= nil, @"DirectToIcu is nil");
	 NSAssert([section getElementForKey:SUCTIONED_EXTUBATED_KEY]!= nil, @"SuctionedExtubated is nil");
	 NSAssert([section getElementForKey:O2For_TRANSPORT_KEY]!= nil, @"O2ForTransport is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = EMERGENCE_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *adequate = (BooleanFormElement*)[_section getElementForKey:ADEQUATE_KEY];
	 if (!adequate) {
		 adequate = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 adequate.key = ADEQUATE_KEY;
		 [_section addElementsObject:adequate];
	 }

	 adequate.value = [NSNumber numberWithBool:self.adequateBBCheckBox.isSelected];
	 
	 BooleanFormElement *intubated = (BooleanFormElement*)[_section getElementForKey:INTUBATED_KEY];
	 if (!intubated) {
		 intubated = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 intubated.key = INTUBATED_KEY;
		 [_section addElementsObject:intubated];
	 }

	 intubated.value = [NSNumber numberWithBool:self.intubatedBBCheckBox.isSelected];
	 
	 BooleanFormElement *directToIcu = (BooleanFormElement*)[_section getElementForKey:DIRECT_TO_ICU_KEY];
	 if (!directToIcu) {
		 directToIcu = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 directToIcu.key = DIRECT_TO_ICU_KEY;
		 [_section addElementsObject:directToIcu];
	 }

	 directToIcu.value = [NSNumber numberWithBool:self.directToIcuBBCheckBox.isSelected];
	 
	 BooleanFormElement *suctionedExtubated = (BooleanFormElement*)[_section getElementForKey:SUCTIONED_EXTUBATED_KEY];
	 if (!suctionedExtubated) {
		 suctionedExtubated = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 suctionedExtubated.key = SUCTIONED_EXTUBATED_KEY;
		 [_section addElementsObject:suctionedExtubated];
	 }

	 suctionedExtubated.value = [NSNumber numberWithBool:self.suctionedExtubatedBBCheckBox.isSelected];
	 
	 BooleanFormElement *o2ForTransport = (BooleanFormElement*)[_section getElementForKey:O2For_TRANSPORT_KEY];
	 if (!o2ForTransport) {
		 o2ForTransport = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 o2ForTransport.key = O2For_TRANSPORT_KEY;
		 [_section addElementsObject:o2ForTransport];
	 }

	 o2ForTransport.value = [NSNumber numberWithBool:self.o2ForTransportBBCheckBox.isSelected];
	 
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
	 return EMERGENCE_SECTION_TITLE;
}
@end