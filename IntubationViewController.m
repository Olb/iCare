
#import "IntubationViewController.h"
#import "BBUtil.h"
#import "FormSection.h"
#import "FormElement.h"
#import "BBCheckBox.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "StringArrayTableAdapter.h"


@interface IntubationViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet BBCheckBox *curvedBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *curvedNumberUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *straightBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *straightNumberUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *videoLaryngoscopyBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *naEttInPlaceBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *styletBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *atraumaticBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *difficultBBCheckBox;
@property (weak, nonatomic) IBOutlet UITextField *difficultReasonUITextField;
@property (weak, nonatomic) IBOutlet BBCheckBox *blindBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *awakeBBCheckBox;
@property (weak, nonatomic) IBOutlet BBCheckBox *fiberopticBBCheckBox;
@end

@implementation IntubationViewController
NSString *const INTUBATION_SECTION_TITLE = @"IntubationSectionKey";
NSString *const CURVED_KEY = @"CurvedKey";
NSString *const CURVED_NUMBER_KEY = @"CurvedNumberKey";
NSString *const STRAIGHT_KEY = @"StraightKey";
NSString *const STRAIGHT_NUMBER_KEY = @"StraightNumberKey";
NSString *const VIDEO_LARYNGOSCOPY_KEY = @"VideoLaryngoscopyKey";
NSString *const NA_ETT_IN_PLACE_KEY = @"NaEttInPlaceKey";
NSString *const STYLET_KEY = @"StyletKey";
NSString *const ATRAUMATIC_KEY = @"AtraumaticKey";
NSString *const DIFFICULT_KEY = @"DifficultKey";
NSString *const DIFFICULT_REASON_KEY = @"DifficultReasonKey";
NSString *const BLIND_KEY = @"BlindKey";
NSString *const AWAKE_KEY = @"AwakeKey";
NSString *const FIBEROPTIC_KEY = @"FiberopticKey";

- (void)viewDidLoad
{
	 [super viewDidLoad];
	 if (_section) {
		 [self validateSection:_section];
		 NSArray *elements = [_section.elements array];

		 for (FormElement *element in elements) {
			 if ([element.key isEqualToString:CURVED_KEY]){
				 [self.curvedBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:CURVED_NUMBER_KEY]){
				 [self.curvedNumberUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:STRAIGHT_KEY]){
				 [self.straightBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:STRAIGHT_NUMBER_KEY]){
				 [self.straightNumberUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:VIDEO_LARYNGOSCOPY_KEY]){
				 [self.videoLaryngoscopyBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:NA_ETT_IN_PLACE_KEY]){
				 [self.naEttInPlaceBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:STYLET_KEY]){
				 [self.styletBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:ATRAUMATIC_KEY]){
				 [self.atraumaticBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DIFFICULT_KEY]){
				 [self.difficultBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:DIFFICULT_REASON_KEY]){
				 [self.difficultReasonUITextField setText:((TextElement*)element).value];
			 }
			 if ([element.key isEqualToString:BLIND_KEY]){
				 [self.blindBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:AWAKE_KEY]){
				 [self.awakeBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
			 if ([element.key isEqualToString:FIBEROPTIC_KEY]){
				 [self.fiberopticBBCheckBox setSelected:[((BooleanFormElement*)element).value boolValue]];
			 }
		 }
	 }
}

-(void)validateSection:(FormSection*)section
{
	 NSAssert([section getElementForKey:CURVED_KEY]!= nil, @"Curved is nil");
	 NSAssert([section getElementForKey:CURVED_NUMBER_KEY]!= nil, @"CurvedNumber is nil");
	 NSAssert([section getElementForKey:STRAIGHT_KEY]!= nil, @"Straight is nil");
	 NSAssert([section getElementForKey:STRAIGHT_NUMBER_KEY]!= nil, @"StraightNumber is nil");
	 NSAssert([section getElementForKey:VIDEO_LARYNGOSCOPY_KEY]!= nil, @"VideoLaryngoscopy is nil");
	 NSAssert([section getElementForKey:NA_ETT_IN_PLACE_KEY]!= nil, @"NaEttInPlace is nil");
	 NSAssert([section getElementForKey:STYLET_KEY]!= nil, @"Stylet is nil");
	 NSAssert([section getElementForKey:ATRAUMATIC_KEY]!= nil, @"Atraumatic is nil");
	 NSAssert([section getElementForKey:DIFFICULT_KEY]!= nil, @"Difficult is nil");
	 NSAssert([section getElementForKey:DIFFICULT_REASON_KEY]!= nil, @"DifficultReason is nil");
	 NSAssert([section getElementForKey:BLIND_KEY]!= nil, @"Blind is nil");
	 NSAssert([section getElementForKey:AWAKE_KEY]!= nil, @"Awake is nil");
	 NSAssert([section getElementForKey:FIBEROPTIC_KEY]!= nil, @"Fiberoptic is nil");
	 
}

- (IBAction)accept:(id)sender {
	 if ( !self.section ){
		 self.section = (FormSection*)[BBUtil newCoreDataObjectForEntityName:@"FormSection"];
		 self.section.title = INTUBATION_SECTION_TITLE;
	 }
	 
	 BooleanFormElement *curved = (BooleanFormElement*)[_section getElementForKey:CURVED_KEY];
	 if (!curved) {
		 curved = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 curved.key = CURVED_KEY;
		 [_section addElementsObject:curved];
	 }

	 curved.value = [NSNumber numberWithBool:self.curvedBBCheckBox.isSelected];
	 
	 TextElement *curvedNumber = (TextElement*)[_section getElementForKey:CURVED_NUMBER_KEY];
	 if (!curvedNumber) {
		 curvedNumber = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 curvedNumber.key = CURVED_NUMBER_KEY;
		 [_section addElementsObject:curvedNumber];
	 }

	 curvedNumber.value = self.curvedNumberUITextField.text;
	 
	 BooleanFormElement *straight = (BooleanFormElement*)[_section getElementForKey:STRAIGHT_KEY];
	 if (!straight) {
		 straight = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 straight.key = STRAIGHT_KEY;
		 [_section addElementsObject:straight];
	 }

	 straight.value = [NSNumber numberWithBool:self.straightBBCheckBox.isSelected];
	 
	 TextElement *straightNumber = (TextElement*)[_section getElementForKey:STRAIGHT_NUMBER_KEY];
	 if (!straightNumber) {
		 straightNumber = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 straightNumber.key = STRAIGHT_NUMBER_KEY;
		 [_section addElementsObject:straightNumber];
	 }

	 straightNumber.value = self.straightNumberUITextField.text;
	 
	 BooleanFormElement *videoLaryngoscopy = (BooleanFormElement*)[_section getElementForKey:VIDEO_LARYNGOSCOPY_KEY];
	 if (!videoLaryngoscopy) {
		 videoLaryngoscopy = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 videoLaryngoscopy.key = VIDEO_LARYNGOSCOPY_KEY;
		 [_section addElementsObject:videoLaryngoscopy];
	 }

	 videoLaryngoscopy.value = [NSNumber numberWithBool:self.videoLaryngoscopyBBCheckBox.isSelected];
	 
	 BooleanFormElement *naEttInPlace = (BooleanFormElement*)[_section getElementForKey:NA_ETT_IN_PLACE_KEY];
	 if (!naEttInPlace) {
		 naEttInPlace = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 naEttInPlace.key = NA_ETT_IN_PLACE_KEY;
		 [_section addElementsObject:naEttInPlace];
	 }

	 naEttInPlace.value = [NSNumber numberWithBool:self.naEttInPlaceBBCheckBox.isSelected];
	 
	 BooleanFormElement *stylet = (BooleanFormElement*)[_section getElementForKey:STYLET_KEY];
	 if (!stylet) {
		 stylet = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 stylet.key = STYLET_KEY;
		 [_section addElementsObject:stylet];
	 }

	 stylet.value = [NSNumber numberWithBool:self.styletBBCheckBox.isSelected];
	 
	 BooleanFormElement *atraumatic = (BooleanFormElement*)[_section getElementForKey:ATRAUMATIC_KEY];
	 if (!atraumatic) {
		 atraumatic = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 atraumatic.key = ATRAUMATIC_KEY;
		 [_section addElementsObject:atraumatic];
	 }

	 atraumatic.value = [NSNumber numberWithBool:self.atraumaticBBCheckBox.isSelected];
	 
	 BooleanFormElement *difficult = (BooleanFormElement*)[_section getElementForKey:DIFFICULT_KEY];
	 if (!difficult) {
		 difficult = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 difficult.key = DIFFICULT_KEY;
		 [_section addElementsObject:difficult];
	 }

	 difficult.value = [NSNumber numberWithBool:self.difficultBBCheckBox.isSelected];
	 
	 TextElement *difficultReason = (TextElement*)[_section getElementForKey:DIFFICULT_REASON_KEY];
	 if (!difficultReason) {
		 difficultReason = (TextElement*)[BBUtil newCoreDataObjectForEntityName:@"TextElement"];
		 difficultReason.key = DIFFICULT_REASON_KEY;
		 [_section addElementsObject:difficultReason];
	 }

	 difficultReason.value = self.difficultReasonUITextField.text;
	 
	 BooleanFormElement *blind = (BooleanFormElement*)[_section getElementForKey:BLIND_KEY];
	 if (!blind) {
		 blind = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 blind.key = BLIND_KEY;
		 [_section addElementsObject:blind];
	 }

	 blind.value = [NSNumber numberWithBool:self.blindBBCheckBox.isSelected];
	 
	 BooleanFormElement *awake = (BooleanFormElement*)[_section getElementForKey:AWAKE_KEY];
	 if (!awake) {
		 awake = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 awake.key = AWAKE_KEY;
		 [_section addElementsObject:awake];
	 }

	 awake.value = [NSNumber numberWithBool:self.awakeBBCheckBox.isSelected];
	 
	 BooleanFormElement *fiberoptic = (BooleanFormElement*)[_section getElementForKey:FIBEROPTIC_KEY];
	 if (!fiberoptic) {
		 fiberoptic = (BooleanFormElement*)[BBUtil newCoreDataObjectForEntityName:@"BooleanFormElement"];
		 fiberoptic.key = FIBEROPTIC_KEY;
		 [_section addElementsObject:fiberoptic];
	 }

	 fiberoptic.value = [NSNumber numberWithBool:self.fiberopticBBCheckBox.isSelected];
	 
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
	 return INTUBATION_SECTION_TITLE;
}
@end