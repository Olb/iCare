

#import "BBPdfSectionBuilder.h"
#import "FormSection.h"
#import "FormElement.h"
#import "FormGroup.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"
#import "AntibioticFormElement.h"
#import "MedicationFormElement.h"
#import "ElementListFormElement.h"
#import "TextElement.h"
#import "Form.h"
#import "Operation.h"
#import "Patient.h"
#import "BBPdfGenerator.h"
#import "BBUtil.h"
@implementation BBPdfSectionBuilder : NSObject
NSDateFormatter* dateFormatter;

+(CGSize) drawSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{ 
	 if (!dateFormatter) {
		  dateFormatter = [[NSDateFormatter alloc] init];
	 }
	 if ([section.title isEqualToString:@"AnesthesiaTypeSectionKey"]){
		 return [BBPdfSectionBuilder drawAnesthesiaTypeSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"BetaBlockerSectionKey"]){
		 return [BBPdfSectionBuilder drawBetaBlockerSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"DiagnosticStudiesSectionKey"]){
		 return [BBPdfSectionBuilder drawDiagnosticStudiesSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"EmergenceSectionKey"]){
		 return [BBPdfSectionBuilder drawEmergenceSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"EndotrachealTubeSectionKey"]){
		 return [BBPdfSectionBuilder drawEndotrachealTubeSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"IVAntibioticNameSectionKey"]){
		 return [BBPdfSectionBuilder drawIVAntibioticNameSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"InductionAndDeviceSectionKey"]){
		 return [BBPdfSectionBuilder drawInductionAndDeviceSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"IntubationSectionKey"]){
		 return [BBPdfSectionBuilder drawIntubationSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PreOpActionsSectionKey"]){
		 return [BBPdfSectionBuilder drawPreOpActionsSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PremedsGivenSectionKey"]){
		 return [BBPdfSectionBuilder drawPremedsGivenSection:section atLocation:sectionOrigin];
	 } else {
		 [NSException raise:@"UnhandledSection" format:@"section title = '%@'",section.title];
	 }
	 return CGSizeZero;
}

+(CGSize) drawAnesthesiaTypeSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Anesthesia Type" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group2CursorStart = cursor;

	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"GeneralKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"General" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"MACKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"MAC" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group3
	 int group3MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group3CursorStart = cursor;

	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IVRegionalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"IV Regional" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AxillaryBlockKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Axillary Block" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(cursor.x - group3CursorStart.x, group3MaxHeight);
	 cursor = group3CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group4
	 int group4MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group4CursorStart = cursor;

	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"SpinalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Spinal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"InterscaleneBlockKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Interscalene Block" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"EpiduralKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Epidural" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NerveBlockForPostopPainKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Nerve block by Anesthesia for postop pain" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Other Anesthesia Types" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherAnesthesiaTypeKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 31, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawBetaBlockerSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 24;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"If Pt on Beta-Blocker" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BetaBlockTakenPastDayKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Taken in past 24 hrs" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"GivenInOrKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Given in O.R." atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ContraIndicationKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"ContraIndication:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group2
	 int group2MaxWidth = 0;
	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 CGPoint group2CursorStart = cursor;

	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 cursor.x += 10;//margin left
	 cursor.y += 0;//margin top
	 CGPoint group3CursorStart = cursor;

	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HypotensionKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Hypotension" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HeartRateLessThanFiftyKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Heart rate less than 50" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 18, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 10;
	 previousElementSize.height += 0 + 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 0 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(group2MaxWidth + 0, cursor.y -group2CursorStart.y);
	 cursor = group2CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 0 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 47, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 24;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawDiagnosticStudiesSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Diagnostic Studies" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group2CursorStart = cursor;

	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"LabsNAKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Labs N/A" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"MedicalEvalReviewedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Medical Eval reviewed" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group3
	 int group3MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group3CursorStart = cursor;

	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"H/H" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"HHKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"PLT" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"PLTKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"K" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"KPotassiumKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(cursor.x - group3CursorStart.x, group3MaxHeight);
	 cursor = group3CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group4
	 int group4MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group4CursorStart = cursor;

	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"PT/INR/PTT:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"PTINRPTTKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Preg test:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PregTestNegativeKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Neg" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PregTestPositiveKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Pos" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group5
	 int group5MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group5CursorStart = cursor;

	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Glucose:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"GlucoseKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"at" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"GlucoseTimeKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"(time)" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group5CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group6
	 int group6MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group6CursorStart = cursor;

	 int group6Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"EKG:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 16 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 16;
	 }

	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"EkgNormalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Normal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Not normal:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"EkgOtherKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group6CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group7
	 int group7MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group7CursorStart = cursor;

	 int group7Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"CXR:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 16 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 16;
	 }

	 group7Indentation = 0;
	 cursor.x += group7Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CxrNormalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Normal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Not normal:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"CxrOtherKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(cursor.x - group7CursorStart.x, group7MaxHeight);
	 cursor = group7CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Other:" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherDataKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 31, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawEmergenceSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Emergence" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AdequateKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Adequate NIF, TV, SaO2, head lift" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IntubatedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Intubated" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DirectToIcuKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Direct To ICU" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"SuctionedExtubatedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Suctioned/Extubated" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"O2ForTransportKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"O2 for transport" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 31, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawEndotrachealTubeSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Emergence" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group2CursorStart = cursor;

	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group3CursorStart = cursor;

	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 //start of draw group4
	 int group4MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group4CursorStart = cursor;

	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Size" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"EndoTrachealTubeSizeKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"OralKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Oral" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group3Indentation + 16 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 16;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ETCO2IncreaseKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"ETCO2 Increase" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //start of draw group5
	 int group5MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group5CursorStart = cursor;

	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Secured At" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"SecuredAtCmKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"cm" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group5CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group3Indentation + 16 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 16;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DoubleLumenEttKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Double Lumen ETT" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BronchBlockerKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Bronch Blocker" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 16, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 16 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 16;
	 }

	 //start of draw group6
	 int group6MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group6CursorStart = cursor;

	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 //start of draw group7
	 int group7MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group7CursorStart = cursor;

	 int group7Indentation = 0;
	 group7Indentation = 0;
	 cursor.x += group7Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NasalKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Nasal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"TrachKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Trach" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(cursor.x - group7CursorStart.x, group7MaxHeight);
	 cursor = group7CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group6Indentation + 16 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 16;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BsbeKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"BSBE" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 0 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CuftUpToSealKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Cuff up to seal" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 0 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 0;
	 }

	 //start of draw group8
	 int group8MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group8CursorStart = cursor;

	 int group8Indentation = 0;
	 group8Indentation = 0;
	 cursor.x += group8Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Size" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"DoubleLumenSizeKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DoubleLumenLeftKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Lt" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DoubleLumenRightKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Rt" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(cursor.x - group8CursorStart.x, group8MaxHeight);
	 cursor = group8CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group6Indentation + 16 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 16;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IsolationCheckKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Isolation Check" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 0 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 0;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(group6MaxWidth + 16, cursor.y -group6CursorStart.y);
	 cursor = group6CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 16 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 16;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 31, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawIVAntibioticNameSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 group1Indentation = 0;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NotIndicatedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Not indicated based on Pt history and/or procedure" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IntentionallyGivenKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Intentionally given after incision" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"IV Antibiotics given:" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 cursor.x += 10;
	 for (AntibioticFormElement *e in ((ElementListFormElement*)[section getElementForKey:@"IvAntibioticKey"]).elements) {
		 previousElementSize = [BBPdfGenerator drawText:e.name atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 
		 previousElementSize = [BBPdfGenerator drawText:e.dose atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 
		 previousElementSize = [BBPdfGenerator drawText:e.doseUnit atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 
		 [dateFormatter setDateFormat:@"HH:mm"];
		 previousElementSize = [BBPdfGenerator drawText:[dateFormatter stringFromDate:e.startTime] atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 previousElementSize.width = cursor.x - elemCursorStart.x;
		 cursor.x = elemCursorStart.x + 0 + 10;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 16, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawInductionAndDeviceSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Induction" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IvKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"IV" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ImKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"IM" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"InhalationKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Inhalation" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PreO2Key"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Pre-O2" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"RapidSequenceKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Rapid sequence" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 31, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawIntubationSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Induction" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group2CursorStart = cursor;

	 int group2Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Blade" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 16 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 16;
	 }

	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CurvedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Curved" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"#" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"CurvedNumberKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StraightKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Straight" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"#" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"StraightNumberKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group3
	 int group3MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group3CursorStart = cursor;

	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"VideoLaryngoscopyKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Video Laryngoscopy" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NaEttInPlaceKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"N/A: ETT in place" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(cursor.x - group3CursorStart.x, group3MaxHeight);
	 cursor = group3CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group4
	 int group4MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group4CursorStart = cursor;

	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StyletKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Stylet" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AtraumaticKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Atraumatic" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group5
	 int group5MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group5CursorStart = cursor;

	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DifficultKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Difficult" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((TextElement*)[section getElementForKey:@"DifficultReasonKey"]).value atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group5CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //start of draw group6
	 int group6MaxHeight = 0;

	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group6CursorStart = cursor;

	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BlindKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Blind" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AwakeKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Awake" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"FiberopticKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Fiberoptic" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 8 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 8;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group6CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 31, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawPreOpActionsSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Anesthesia PreOp time used to:" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CheckConsentsKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Check consents and review chart/plan with Pt" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StartIvKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Start IV" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Other Actions" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherActionsKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 31, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}

+(CGSize) drawPremedsGivenSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 cursor.x += 8;//margin left
	 cursor.y += 8;//margin top
	 CGPoint group1CursorStart = cursor;

	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Anesthesia Type" atLocation:cursor];
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 16 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 16;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((MedicationFormElement*)[section getElementForKey:@"MidazolamKey"]).selected boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Midazolam" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((MedicationFormElement*)[section getElementForKey:@"MidazolamKey"]).dose atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((MedicationFormElement*)[section getElementForKey:@"MidazolamKey"]).doseUnit atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((MedicationFormElement*)[section getElementForKey:@"OndansetronKey"]).selected boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Ondansetron" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((MedicationFormElement*)[section getElementForKey:@"OndansetronKey"]).dose atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:((MedicationFormElement*)[section getElementForKey:@"OndansetronKey"]).doseUnit atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Other premeds given:" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 cursor.x += 10;
	 for (MedicationFormElement *e in ((ElementListFormElement*)[section getElementForKey:@"PremedsGivenKey"]).elements) {
		 previousElementSize = [BBPdfGenerator drawText:e.name atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 
		 previousElementSize = [BBPdfGenerator drawText:e.dose atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 
		 previousElementSize = [BBPdfGenerator drawText:e.doseUnit atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 previousElementSize.width = cursor.x - elemCursorStart.x;
		 cursor.x = elemCursorStart.x + 0 + 10;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:0.0 green:1.0 blue:0.0];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 31, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 [BBUtil drawRect:CGRectMake(cursor.x,cursor.y,previousElementSize.width,previousElementSize.height) withRed:1.0 green:0.0 blue:0.0];
	 previousElementSize.width += 8 + 8;
	 previousElementSize.height += 8 + 8;
	 return previousElementSize;
}
@end




