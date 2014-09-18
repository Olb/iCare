

#import "BBPdfSectionBuilder.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "TextElement.h"
#import "Form.h"
#import "Operation.h"
#import "Patient.h"
#import "BBPdfGenerator.h"
@implementation BBPdfSectionBuilder : NSObject

+(void) drawSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
    NSLog(@"Drawing Section: %@", section.title);
	 if ([section.title isEqualToString:@"AnesthesiaTypeSectionKey"]){
		 [BBPdfSectionBuilder drawAnesthesiaTypeSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"BetaBlockerSectionKey"]){
		 [BBPdfSectionBuilder drawBetaBlockerSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"DiagnosticStudiesSectionKey"]){
		 [BBPdfSectionBuilder drawDiagnosticStudiesSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"EmergenceSectionKey"]){
		 [BBPdfSectionBuilder drawEmergenceSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"EndotrachealTubeSectionKey"]){
		 [BBPdfSectionBuilder drawEndotrachealTubeSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"InductionAndDeviceSectionKey"]){
		 [BBPdfSectionBuilder drawInductionAndDeviceSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"IntubationSectionKey"]){
		 [BBPdfSectionBuilder drawIntubationSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PreOpActionsSectionKey"]){
		 [BBPdfSectionBuilder drawPreOpActionsSection:section atLocation:sectionOrigin];
	 } else {
		 [NSException raise:@"UnhandledSection" format:@"section title = '%@'",section.title];
	 }
}

+(void) drawAnesthesiaTypeSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 //start of draw group1
	 CGPoint group1CursorStart = cursor;
	 int group1MaxWidth = 0;
	 int group1Indentation = 15;
	 //start of draw group2
	 CGPoint group2CursorStart = cursor;
	 int group2MaxHeight = 0;

	 int group2Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"GeneralKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"General" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"MACKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"MAC" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group3
	 CGPoint group3CursorStart = cursor;
	 int group3MaxHeight = 0;

	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IVRegionalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"IV Regional" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group3Indentation > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + group3Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AxillaryBlockKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Axillary Block" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group3Indentation > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + group3Indentation;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(cursor.x - group3CursorStart.x, group3MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group4
	 CGPoint group4CursorStart = cursor;
	 int group4MaxHeight = 0;

	 int group4Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"SpinalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Spinal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"InterscaleneBlockKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Interscalene Block" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"EpiduralKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Epidural" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NerveBlockForPostopPainKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Nerve block by Anesthesia for postop pain" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"Other Anesthesia Types" atLocation:cursor];
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherAnesthesiaTypeKey"]).value) {
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 }

	 //end of draw group1
	 
	 cursor = group1CursorStart;

	 
}

+(void) drawBetaBlockerSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 //start of draw group1
	 CGPoint group1CursorStart = cursor;
	 int group1MaxWidth = 0;
	 int group1Indentation = 15;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BetaBlockTakenPastDayKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Taken in past 24 hrs" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"GivenInOrKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Given in O.R." atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ContraIndicationKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"ContraIndication:" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group2
	 CGPoint group2CursorStart = cursor;
	 int group2MaxWidth = 0;
	 int group2Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HeartRateLessThanFiftyKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Heart rate less than 50" atLocation:cursor];
	 cursor.x = group2CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group2Indentation > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HypotensionKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Hypotension" atLocation:cursor];
	 cursor.x = group2CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group2Indentation > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation;
	 }

	 //end of draw group2
	 
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //end of draw group1
	 
	 cursor = group1CursorStart;

	 
}

+(void) drawDiagnosticStudiesSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 //start of draw group1
	 CGPoint group1CursorStart = cursor;
	 int group1MaxWidth = 0;
	 int group1Indentation = 15;
	 //start of draw group2
	 CGPoint group2CursorStart = cursor;
	 int group2MaxHeight = 0;

	 int group2Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"LabsNAKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Labs N/A" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"MedicalEvalReviewedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Medical Eval reviewed" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group3
	 CGPoint group3CursorStart = cursor;
	 int group3MaxHeight = 0;

	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"H/H" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group3Indentation > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + group3Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"PLT" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group3Indentation > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + group3Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"K" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group3Indentation > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + group3Indentation;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(cursor.x - group3CursorStart.x, group3MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group4
	 CGPoint group4CursorStart = cursor;
	 int group4MaxHeight = 0;

	 int group4Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"PT/INR/PTT:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"Preg test:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PregTestNegativeKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Neg" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PregTestPositiveKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Pos" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group5
	 CGPoint group5CursorStart = cursor;
	 int group5MaxHeight = 0;

	 int group5Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Glucose:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group5Indentation > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + group5Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"at" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group5Indentation > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + group5Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"(time)" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group5Indentation > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + group5Indentation;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group6
	 CGPoint group6CursorStart = cursor;
	 int group6MaxHeight = 0;

	 int group6Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"EkgNormalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Normal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group6Indentation > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + group6Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"Not normal:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group6Indentation > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + group6Indentation;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group7
	 CGPoint group7CursorStart = cursor;
	 int group7MaxHeight = 0;

	 int group7Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CxrNormalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Normal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group7Indentation > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + group7Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"Not normal:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group7Indentation > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + group7Indentation;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(cursor.x - group7CursorStart.x, group7MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"Other:" atLocation:cursor];
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherDataKey"]).value) {
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 }

	 //end of draw group1
	 
	 cursor = group1CursorStart;

	 
}

+(void) drawEmergenceSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 //start of draw group1
	 CGPoint group1CursorStart = cursor;
	 int group1MaxWidth = 0;
	 int group1Indentation = 15;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AdequateKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Adequate NIF, TV, SaO2, head lift" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IntubatedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Intubated" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DirectToIcuKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Direct To ICU" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"SuctionedExtubatedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Suctioned/Extubated" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"O2ForTransportKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"O2 for transport" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //end of draw group1
	 
	 cursor = group1CursorStart;

	 
}

+(void) drawEndotrachealTubeSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 //start of draw group1
	 CGPoint group1CursorStart = cursor;
	 int group1MaxWidth = 0;
	 int group1Indentation = 15;
	 //start of draw group2
	 CGPoint group2CursorStart = cursor;
	 int group2MaxHeight = 0;

	 int group2Indentation = 0;
	 //start of draw group3
	 CGPoint group3CursorStart = cursor;
	 int group3MaxWidth = 0;
	 int group3Indentation = 0;
	 //start of draw group4
	 CGPoint group4CursorStart = cursor;
	 int group4MaxHeight = 0;

	 int group4Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Size" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"OralKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Oral" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group3Indentation > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ETCO2IncreaseKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"ETCO2 Increase" atLocation:cursor];
	 cursor.x = group3CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group3Indentation > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation;
	 }

	 //start of draw group5
	 CGPoint group5CursorStart = cursor;
	 int group5MaxHeight = 0;

	 int group5Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Secured At" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group5Indentation > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + group5Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"cm" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group5Indentation > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + group5Indentation;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group3Indentation > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DoubleLumenEttKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Double Lumen ETT" atLocation:cursor];
	 cursor.x = group3CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group3Indentation > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BronchBlockerKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Bronch Blocker" atLocation:cursor];
	 cursor.x = group3CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group3Indentation > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation;
	 }

	 //end of draw group3
	 
	 cursor = group1CursorStart;

	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 //start of draw group6
	 CGPoint group6CursorStart = cursor;
	 int group6MaxWidth = 0;
	 int group6Indentation = 0;
	 //start of draw group7
	 CGPoint group7CursorStart = cursor;
	 int group7MaxHeight = 0;

	 int group7Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NasalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Nasal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group7Indentation > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + group7Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"TrachKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Trach" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group7Indentation > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + group7Indentation;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(cursor.x - group7CursorStart.x, group7MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group6Indentation > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BsbeKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"BSBE" atLocation:cursor];
	 cursor.x = group6CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group6Indentation > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CuftUpToSealKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Cuff up to seal" atLocation:cursor];
	 cursor.x = group6CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group6Indentation > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation;
	 }

	 //start of draw group8
	 CGPoint group8CursorStart = cursor;
	 int group8MaxHeight = 0;

	 int group8Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Size" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group8Indentation > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + group8Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DoubleLumenLeftKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Lt" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group8Indentation > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + group8Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DoubleLumenRightKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Rt" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group8Indentation > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + group8Indentation;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(cursor.x - group8CursorStart.x, group8MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group6Indentation > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IsolationCheckKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Isolation Check" atLocation:cursor];
	 cursor.x = group6CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group6Indentation > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation;
	 }

	 //end of draw group6
	 
	 cursor = group1CursorStart;

	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //end of draw group1
	 
	 cursor = group1CursorStart;

	 
}

+(void) drawInductionAndDeviceSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 //start of draw group1
	 CGPoint group1CursorStart = cursor;
	 int group1MaxWidth = 0;
	 int group1Indentation = 15;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IvKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"IV" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ImKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"IM" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"InhalationKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Inhalation" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PreO2Key"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Pre-O2" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"RapidSequenceKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Rapid sequence" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //end of draw group1
	 
	 cursor = group1CursorStart;

	 
}

+(void) drawIntubationSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 //start of draw group1
	 CGPoint group1CursorStart = cursor;
	 int group1MaxWidth = 0;
	 int group1Indentation = 15;
	 //start of draw group2
	 CGPoint group2CursorStart = cursor;
	 int group2MaxHeight = 0;

	 int group2Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CurvedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Curved" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"#" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StraightKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Straight" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"#" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group2Indentation > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + group2Indentation;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group3
	 CGPoint group3CursorStart = cursor;
	 int group3MaxHeight = 0;

	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"VideoLaryngoscopyKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Video Laryngoscopy" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group3Indentation > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + group3Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NaEttInPlaceKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"N/A: ETT in place" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group3Indentation > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + group3Indentation;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(cursor.x - group3CursorStart.x, group3MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group4
	 CGPoint group4CursorStart = cursor;
	 int group4MaxHeight = 0;

	 int group4Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StyletKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Stylet" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AtraumaticKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Atraumatic" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group4Indentation > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + group4Indentation;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group5
	 CGPoint group5CursorStart = cursor;
	 int group5MaxHeight = 0;

	 int group5Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DifficultKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Difficult" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group5Indentation > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + group5Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group5Indentation > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + group5Indentation;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //start of draw group6
	 CGPoint group6CursorStart = cursor;
	 int group6MaxHeight = 0;

	 int group6Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BlindKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Blind" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group6Indentation > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + group6Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AwakeKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Awake" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group6Indentation > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + group6Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"FiberopticKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Fiberoptic" atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 if ( previousElementSize.height + group6Indentation > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + group6Indentation;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group1CursorStart;

	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 //end of draw group1
	 
	 cursor = group1CursorStart;

	 
}

+(void) drawPreOpActionsSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 //start of draw group1
	 CGPoint group1CursorStart = cursor;
	 int group1MaxWidth = 0;
	 int group1Indentation = 15;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CheckConsentsKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Check consents and review chart/plan with Pt" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StartIvKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 10;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Start IV" atLocation:cursor];
	 cursor.x = group1CursorStart.x;
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 previousElementSize = [BBPdfGenerator drawText:@"Other Actions" atLocation:cursor];
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherActionsKey"]).value) {
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 20;
	 if ( previousElementSize.width + group1Indentation > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation;
	 }

	 }

	 //end of draw group1
	 
	 cursor = group1CursorStart;

	 
}
@end




