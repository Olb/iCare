
#import "BetaBlockerViewController.h"
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


@interface BetaBlockerViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *betaBlockTakenPastDayBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *givenInOrBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *contraIndicationBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *heartRateLessThanFiftyBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hypotensionBBCheckBox;
@end

@implementation BetaBlockerViewController
NSString *const BETA_BLOCKER_SECTION_TITLE = @"BetaBlockerSectionKey";
static NSString *const BETA_BLOCK_TAKEN_PAST_DAY_KEY = @"BetaBlockTakenPastDayKey";
static NSString *const GIVEN_IN_OR_KEY = @"GivenInOrKey";
static NSString *const CONTRA_INDICATION_KEY = @"ContraIndicationKey";
static NSString *const HEART_RATE_LESS_THAN_FIFTY_KEY = @"HeartRateLessThanFiftyKey";
static NSString *const HYPOTENSION_KEY = @"HypotensionKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:BETA_BLOCK_TAKEN_PAST_DAY_KEY]){
				 [self.betaBlockTakenPastDayBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:GIVEN_IN_OR_KEY]){
				 [self.givenInOrBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CONTRA_INDICATION_KEY]){
				 [self.contraIndicationBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HEART_RATE_LESS_THAN_FIFTY_KEY]){
				 [self.heartRateLessThanFiftyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HYPOTENSION_KEY]){
				 [self.hypotensionBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:BETA_BLOCK_TAKEN_PAST_DAY_KEY]!= nil, @"BetaBlockTakenPastDay is nil");
	 NSAssert([section getElementForKey:GIVEN_IN_OR_KEY]!= nil, @"GivenInOr is nil");
	 NSAssert([section getElementForKey:CONTRA_INDICATION_KEY]!= nil, @"ContraIndication is nil");
	 NSAssert([section getElementForKey:HEART_RATE_LESS_THAN_FIFTY_KEY]!= nil, @"HeartRateLessThanFifty is nil");
	 NSAssert([section getElementForKey:HYPOTENSION_KEY]!= nil, @"Hypotension is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = BETA_BLOCKER_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *betaBlockTakenPastDay = (BooleanFormElement*)[_section getElementForKey:BETA_BLOCK_TAKEN_PAST_DAY_KEY];
	 if (!betaBlockTakenPastDay) {
		 betaBlockTakenPastDay = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 betaBlockTakenPastDay.key = BETA_BLOCK_TAKEN_PAST_DAY_KEY;
		 [_section addElementsObject:betaBlockTakenPastDay];
	 }

	 betaBlockTakenPastDay.value = [NSNumber numberWithBool:self.betaBlockTakenPastDayBBCheckBox.isSelected];
	 
	 BooleanFormElement *givenInOr = (BooleanFormElement*)[_section getElementForKey:GIVEN_IN_OR_KEY];
	 if (!givenInOr) {
		 givenInOr = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 givenInOr.key = GIVEN_IN_OR_KEY;
		 [_section addElementsObject:givenInOr];
	 }

	 givenInOr.value = [NSNumber numberWithBool:self.givenInOrBBCheckBox.isSelected];
	 
	 BooleanFormElement *contraIndication = (BooleanFormElement*)[_section getElementForKey:CONTRA_INDICATION_KEY];
	 if (!contraIndication) {
		 contraIndication = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 contraIndication.key = CONTRA_INDICATION_KEY;
		 [_section addElementsObject:contraIndication];
	 }

	 contraIndication.value = [NSNumber numberWithBool:self.contraIndicationBBCheckBox.isSelected];
	 
	 BooleanFormElement *heartRateLessThanFifty = (BooleanFormElement*)[_section getElementForKey:HEART_RATE_LESS_THAN_FIFTY_KEY];
	 if (!heartRateLessThanFifty) {
		 heartRateLessThanFifty = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 heartRateLessThanFifty.key = HEART_RATE_LESS_THAN_FIFTY_KEY;
		 [_section addElementsObject:heartRateLessThanFifty];
	 }

	 heartRateLessThanFifty.value = [NSNumber numberWithBool:self.heartRateLessThanFiftyBBCheckBox.isSelected];
	 
	 BooleanFormElement *hypotension = (BooleanFormElement*)[_section getElementForKey:HYPOTENSION_KEY];
	 if (!hypotension) {
		 hypotension = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hypotension.key = HYPOTENSION_KEY;
		 [_section addElementsObject:hypotension];
	 }

	 hypotension.value = [NSNumber numberWithBool:self.hypotensionBBCheckBox.isSelected];
	 
	 [self.delegate sectionCreated:self.section];
	 [self dismissViewControllerAnimated:YES completion:nil];
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
	 return BETA_BLOCKER_SECTION_TITLE;
}
@end