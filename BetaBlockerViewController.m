#import "BetaBlockerViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface BetaBlockerViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *contraIndicationBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *takenPastDayBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *givenInORBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *heartRateLessFiftyBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *hypotensionBBCheckBox;
@end

@implementation BetaBlockerViewController
NSString *const BETA_BLOCKER_SECTION_TITLE = @"BetaBlockerSectionKey";
NSString *const TAKEN_PAST_DAY_KEY = @"TakenPastDayKey";
NSString *const GIVEN_INOR_KEY = @"GivenInORKey";
NSString *const HEART_RATE_LESS_FIFTY_KEY = @"HeartRateLessFiftyKey";
NSString *const HYPOTENSION_KEY = @"HypotensionKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section allElements];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:TAKEN_PAST_DAY_KEY]){
				 [self.takenPastDayBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:GIVEN_INOR_KEY]){
				 [self.givenInORBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HEART_RATE_LESS_FIFTY_KEY]){
				 [self.heartRateLessFiftyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:HYPOTENSION_KEY]){
				 [self.hypotensionBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
				 [self.contraIndicationBBCheckBox setSelected:[((FormGroup *)[_section.groups objectAtIndex:1]).selected boolValue]];
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
	 NSAssert([group getElementForKey:TAKEN_PAST_DAY_KEY]!= nil, @"TakenPastDay is nil");
	 NSAssert([group getElementForKey:GIVEN_INOR_KEY]!= nil, @"GivenInOR is nil");
	 
	 group = [_section.groups objectAtIndex:1];
	 NSAssert(group.optional, @"Expected group to be optional");
	 NSAssert([group getElementForKey:HEART_RATE_LESS_FIFTY_KEY]!= nil, @"HeartRateLessFifty is nil");
	 NSAssert([group getElementForKey:HYPOTENSION_KEY]!= nil, @"Hypotension is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = BETA_BLOCKER_SECTION_TITLE;
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
	 BooleanFormElement *takenPastDay = (BooleanFormElement*)[group getElementForKey:TAKEN_PAST_DAY_KEY];
	 if (!takenPastDay) {
		 takenPastDay = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 takenPastDay.key = TAKEN_PAST_DAY_KEY;
		 [group addElementsObject:takenPastDay];
	 }

	 takenPastDay.value = [NSNumber numberWithBool:self.takenPastDayBBCheckBox.isSelected];
	 
	 BooleanFormElement *givenInOR = (BooleanFormElement*)[group getElementForKey:GIVEN_INOR_KEY];
	 if (!givenInOR) {
		 givenInOR = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 givenInOR.key = GIVEN_INOR_KEY;
		 [group addElementsObject:givenInOR];
	 }

	 givenInOR.value = [NSNumber numberWithBool:self.givenInORBBCheckBox.isSelected];
	 
	 group = nil;
	 if ([self.section.groups count] > 1) {
		 group = [self.section.groups objectAtIndex:1];
	 }
	 if ( !group ){
		 group =(FormGroup*)[BBUtil newCoreDataObjectForEntityName:@"FormGroup"];
		 group.optional = [NSNumber numberWithBool:true];
		 [self.section addGroupsObject:group];
	 }
	 group.selected = [NSNumber numberWithBool:self.contraIndicationBBCheckBox.isSelected];
	 BooleanFormElement *heartRateLessFifty = (BooleanFormElement*)[group getElementForKey:HEART_RATE_LESS_FIFTY_KEY];
	 if (!heartRateLessFifty) {
		 heartRateLessFifty = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 heartRateLessFifty.key = HEART_RATE_LESS_FIFTY_KEY;
		 [group addElementsObject:heartRateLessFifty];
	 }

	 heartRateLessFifty.value = [NSNumber numberWithBool:self.heartRateLessFiftyBBCheckBox.isSelected];
	 
	 BooleanFormElement *hypotension = (BooleanFormElement*)[group getElementForKey:HYPOTENSION_KEY];
	 if (!hypotension) {
		 hypotension = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 hypotension.key = HYPOTENSION_KEY;
		 [group addElementsObject:hypotension];
	 }

	 hypotension.value = [NSNumber numberWithBool:self.hypotensionBBCheckBox.isSelected];
	 
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
	 return BETA_BLOCKER_SECTION_TITLE;
}
@end