

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
	 if ([section.title isEqualToString:@"AllergiesReactionsSectionKey"]){
		 return [BBPdfSectionBuilder drawAllergiesReactionsSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"AnesthesiaTypeSectionKey"]){
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
	 } else if ([section.title isEqualToString:@"InvasiveLinesSectionKey"]){
		 return [BBPdfSectionBuilder drawInvasiveLinesSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"MedicationsSupplementsSectionKey"]){
		 return [BBPdfSectionBuilder drawMedicationsSupplementsSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"MonitorinAndEquipmentSectionKey"]){
		 return [BBPdfSectionBuilder drawMonitorinAndEquipmentSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PastSurgicalProceduresSectionKey"]){
		 return [BBPdfSectionBuilder drawPastSurgicalProceduresSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PersonnelSectionKey"]){
		 return [BBPdfSectionBuilder drawPersonnelSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PhysicalExamSectionKey"]){
		 return [BBPdfSectionBuilder drawPhysicalExamSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PositionSectionKey"]){
		 return [BBPdfSectionBuilder drawPositionSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PostAnesthesiaEvalSectionKey"]){
		 return [BBPdfSectionBuilder drawPostAnesthesiaEvalSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PostOpDiagnosisSectionKey"]){
		 return [BBPdfSectionBuilder drawPostOpDiagnosisSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PostProcedureGeneralSectionKey"]){
		 return [BBPdfSectionBuilder drawPostProcedureGeneralSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PreOpActionsSectionKey"]){
		 return [BBPdfSectionBuilder drawPreOpActionsSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"PremedsGivenSectionKey"]){
		 return [BBPdfSectionBuilder drawPremedsGivenSection:section atLocation:sectionOrigin];
	 } else if ([section.title isEqualToString:@"SpinalAnesthesiaSectionKey"]){
		 return [BBPdfSectionBuilder drawSpinalAnesthesiaSection:section atLocation:sectionOrigin];
	 } else {
		 [NSException raise:@"UnhandledSection" format:@"section title = '%@'",section.title];
	 }
	 return CGSizeZero;
}

+(CGSize) drawAllergiesReactionsSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Allergies & Reactions" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NoKnownAllergiesKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"No Known Allergies" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Allergies" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"AllergiesReactionsKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawAnesthesiaTypeSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Anesthesia Type" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 0, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group4
	 int group4MaxWidth = 0;
	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(group4MaxWidth + 0, cursor.y -group4CursorStart.y);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 8;
	 previousElementSize = [BBPdfGenerator drawText:@"Other Anesthesia Types" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherAnesthesiaTypeKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawBetaBlockerSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"If Pt on Beta-Blocker" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //start of draw group2
	 int group2MaxWidth = 0;
	 CGPoint group2CursorStart = cursor;

	 cursor.x += 10;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(group2MaxWidth + 10, cursor.y -group2CursorStart.y);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawDiagnosticStudiesSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Diagnostic Studies" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group3
	 int group3MaxHeight = 0;

	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"H/H" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"HHKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"PLT" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"PLTKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"K" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"KPotassiumKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group3MaxHeight){
		 group3MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(cursor.x - group3CursorStart.x, group3MaxHeight);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group4
	 int group4MaxHeight = 0;

	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"PT/INR/PTT:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"PTINRPTTKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Preg test:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group5
	 int group5MaxHeight = 0;

	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Glucose:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"GlucoseKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"at" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"GlucoseTimeKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"(time)" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group6
	 int group6MaxHeight = 0;

	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"EKG:" atLocation:cursor isBold:YES];
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Not normal:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"EkgOtherKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group7
	 int group7MaxHeight = 0;

	 CGPoint group7CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group7Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"CXR:" atLocation:cursor isBold:YES];
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Not normal:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"CxrOtherKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(cursor.x - group7CursorStart.x, group7MaxHeight);
	 cursor = group7CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Other:" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherDataKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawEmergenceSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Emergence" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawEndotrachealTubeSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Emergence" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 //start of draw group4
	 int group4MaxHeight = 0;

	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"EndoTrachealTubeSizeKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //start of draw group5
	 int group5MaxHeight = 0;

	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Secured At" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"SecuredAtCmKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"cm" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 0, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group6
	 int group6MaxWidth = 0;
	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 //start of draw group7
	 int group7MaxHeight = 0;

	 CGPoint group7CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(cursor.x - group7CursorStart.x, group7MaxHeight);
	 cursor = group7CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 0 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 //start of draw group8
	 int group8MaxHeight = 0;

	 CGPoint group8CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group8Indentation = 0;
	 group8Indentation = 0;
	 cursor.x += group8Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Size" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"DoubleLumenSizeKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(cursor.x - group8CursorStart.x, group8MaxHeight);
	 cursor = group8CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 0 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(group6MaxWidth + 0, cursor.y -group6CursorStart.y);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawIVAntibioticNameSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"IV Antibiotics" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"IV Antibiotics given:" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawInductionAndDeviceSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxHeight = 0;

	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 group1Indentation = 0;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxWidth = 0;
	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Induction" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 0 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 0;
	 }

	 group2Indentation = 15;
	 cursor.x += group2Indentation;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(group2MaxWidth + 15, cursor.y -group2CursorStart.y);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group1MaxHeight){
		 group1MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Device" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 group3Indentation = 15;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"OralAirwayKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Oral Airway" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NasalAirwayKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Nasal Airway" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"MaskKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Mask" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"LMAKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"LMA" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Size:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"SizeKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 15, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group1MaxHeight){
		 group1MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(cursor.x - group1CursorStart.x, group1MaxHeight);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawIntubationSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Intubation" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Blade" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //start of draw group4
	 int group4MaxHeight = 0;

	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"#" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"CurvedNumberKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //start of draw group5
	 int group5MaxHeight = 0;

	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"#" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"StraightNumberKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group5MaxHeight){
		 group5MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(cursor.x - group5CursorStart.x, group5MaxHeight);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 0, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group6
	 int group6MaxWidth = 0;
	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(group6MaxWidth + 0, cursor.y -group6CursorStart.y);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group7
	 int group7MaxWidth = 0;
	 CGPoint group7CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group7Indentation = 0;
	 group7Indentation = 0;
	 cursor.x += group7Indentation;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 8 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 8 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 8;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(group7MaxWidth + 0, cursor.y -group7CursorStart.y);
	 cursor = group7CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group8
	 int group8MaxWidth = 0;
	 CGPoint group8CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group8Indentation = 0;
	 group8Indentation = 0;
	 cursor.x += group8Indentation;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group8Indentation + 8 > group8MaxWidth){
		 group8MaxWidth = previousElementSize.width + group8Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group8Indentation + 8 > group8MaxWidth){
		 group8MaxWidth = previousElementSize.width + group8Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group8Indentation + 8 > group8MaxWidth){
		 group8MaxWidth = previousElementSize.width + group8Indentation + 8;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(group8MaxWidth + 0, cursor.y -group8CursorStart.y);
	 cursor = group8CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 8;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group9
	 int group9MaxHeight = 0;

	 CGPoint group9CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group9Indentation = 0;
	 group9Indentation = 0;
	 cursor.x += group9Indentation;
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
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group9MaxHeight){
		 group9MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"DifficultReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group9MaxHeight){
		 group9MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group9
	 previousElementSize = CGSizeMake(cursor.x - group9CursorStart.x, group9MaxHeight);
	 cursor = group9CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawInvasiveLinesSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Invasive Lines" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ALineKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"A-Line" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NasoGastricTubeKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Nasogastric Tube" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"OroGastricTubeKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Pa Catheter" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 0, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group4
	 int group4MaxWidth = 0;
	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CentralVenousCatheterKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Central venous catheter" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PaCatheterKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Pa Catheter" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(group4MaxWidth + 0, cursor.y -group4CursorStart.y);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 8;
	 previousElementSize = [BBPdfGenerator drawText:@"IV's Size & Site" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"IvsSizeAndSiteKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawMedicationsSupplementsSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Meds/Supplements(*If taken the day of proc.)" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BetaBlockerKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Beta-Blocker" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Medications" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 cursor.x += 10;
	 for (MedicationFormElement *e in ((ElementListFormElement*)[section getElementForKey:@"MedsSupplementsKey"]).elements) {
		 previousElementSize = [BBPdfGenerator drawText:e.name atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 
		 previousElementSize = [BBPdfGenerator drawText:e.dose atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 
		 previousElementSize = [BBPdfGenerator drawText:e.doseUnit atLocation:cursor];
		 cursor.x += previousElementSize.width + 8;
		 previousElementSize.width = cursor.x - elemCursorStart.x;
		 cursor.x = elemCursorStart.x + 0 + 10;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawMonitorinAndEquipmentSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Patient Safety:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"EquipmentCheckedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Equipment Checked" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AudibleAlarmsOnKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Audible alarms on" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 8;//margin top
	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Monitoring And Equipment" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 group3Indentation = 15;
	 cursor.x += group3Indentation;
	 //start of draw group4
	 int group4MaxHeight = 0;

	 CGPoint group4CursorStart = cursor;

	 cursor.x += 8;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 //start of draw group5
	 int group5MaxWidth = 0;
	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PrecordialStethKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Precordial Steth Checked" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"EsophagealStethKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Esophageal Steth" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"TEEKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"TEE" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IntentionalHypothermiaKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Intentional Hypothermia" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(group5MaxWidth + 0, cursor.y -group5CursorStart.y);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group6
	 int group6MaxWidth = 0;
	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NerveStimulatorKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Nerve Stimulator" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CellSaverKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Cell Saver" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"FluidWarmerKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Fluid Warmer" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(group6MaxWidth + 0, cursor.y -group6CursorStart.y);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 15, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group7
	 int group7MaxHeight = 0;

	 CGPoint group7CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 8;//margin top
	 int group7Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"IntraOp Forced Air Warming Device:" atLocation:cursor isBold:YES];
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 8 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 8;
	 }

	 group7Indentation = 0;
	 cursor.x += group7Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IntraOpForcedAirUpperKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Upper" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"IntraOpForcedAirLowerKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Lower" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(cursor.x - group7CursorStart.x, group7MaxHeight);
	 cursor = group7CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group8
	 int group8MaxHeight = 0;

	 CGPoint group8CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 8;//margin top
	 int group8Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"NIBP:" atLocation:cursor isBold:YES];
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 8 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 8;
	 }

	 group8Indentation = 0;
	 cursor.x += group8Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"every" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"NibpEveryMinKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"min" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(cursor.x - group8CursorStart.x, group8MaxHeight);
	 cursor = group8CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group9
	 int group9MaxHeight = 0;

	 CGPoint group9CursorStart = cursor;

	 cursor.x += 8;//margin left
	 cursor.y += 0;//margin top
	 int group9Indentation = 0;
	 group9Indentation = 0;
	 cursor.x += group9Indentation;
	 //start of draw group10
	 int group10MaxWidth = 0;
	 CGPoint group10CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group10Indentation = 0;
	 group10Indentation = 0;
	 cursor.x += group10Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NibpRightKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Right" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 8 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NibpLeftKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Left" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 8 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 8;
	 }

	 //end of draw group10
	 previousElementSize = CGSizeMake(group10MaxWidth + 0, cursor.y -group10CursorStart.y);
	 cursor = group10CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group9MaxHeight){
		 group9MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group11
	 int group11MaxWidth = 0;
	 CGPoint group11CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group11Indentation = 0;
	 group11Indentation = 0;
	 cursor.x += group11Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NibpArmKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Arm" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group11Indentation + 8 > group11MaxWidth){
		 group11MaxWidth = previousElementSize.width + group11Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"NibpLegKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Leg" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group11Indentation + 8 > group11MaxWidth){
		 group11MaxWidth = previousElementSize.width + group11Indentation + 8;
	 }

	 //end of draw group11
	 previousElementSize = CGSizeMake(group11MaxWidth + 0, cursor.y -group11CursorStart.y);
	 cursor = group11CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group9MaxHeight){
		 group9MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group9
	 previousElementSize = CGSizeMake(cursor.x - group9CursorStart.x, group9MaxHeight);
	 cursor = group9CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"other" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"MonitoringEquipmentOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPastSurgicalProceduresSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxHeight = 0;

	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 group1Indentation = 0;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxWidth = 0;
	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Past Surgical Procedures" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 0 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 0;
	 }

	 group2Indentation = 15;
	 cursor.x += group2Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"PastSurgicalProceduresKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
	 }

	 }

	 previousElementSize.width = group2MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group2Indentation + 8 > group2MaxWidth){
		 group2MaxWidth = previousElementSize.width + group2Indentation + 8;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(group2MaxWidth + 15, cursor.y -group2CursorStart.y);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group1MaxHeight){
		 group1MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Hx Anesthesia Problems:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 group3Indentation = 15;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HxAnesthesiaProblemsNoKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"None" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HxAnesthesiaProblemsYesPatientKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Yes-Patient" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HxAnesthesiaProblemsYesFamilyKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Yes-Family" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 15, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group1MaxHeight){
		 group1MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(cursor.x - group1CursorStart.x, group1MaxHeight);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPersonnelSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Personnel" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Responsible MD/DO at Emergence: " atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"ResponsibleMdKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 8;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 8;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Surgeon" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"SurgeonKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 }

	 previousElementSize.width = group3MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 0, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group4
	 int group4MaxWidth = 0;
	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Anesthesiologist" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"AnesthesiologistKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 }

	 previousElementSize.width = group4MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(group4MaxWidth + 0, cursor.y -group4CursorStart.y);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group5
	 int group5MaxWidth = 0;
	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"CRNA/AA" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"CrnaAaaKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 }

	 previousElementSize.width = group5MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(group5MaxWidth + 0, cursor.y -group5CursorStart.y);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPhysicalExamSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Physical Examination" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Heart" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 group3Indentation = 15;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HeartRegularKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Heart Regular" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //start of draw group4
	 int group4MaxHeight = 0;

	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HeartOtherKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Other" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"HeartOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 15, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group5
	 int group5MaxWidth = 0;
	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Lungs" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 0 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 0;
	 }

	 group5Indentation = 15;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"LungsClearKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Lungs Clear" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 //start of draw group6
	 int group6MaxHeight = 0;

	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"LungsOtherKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Other" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"LungsOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 0 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 0;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(group5MaxWidth + 15, cursor.y -group5CursorStart.y);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPositionSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Position" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Eyes:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 4 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 4;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 8;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"TapedShutKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Taped shut" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ShieldKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Shield" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AxillaryRollKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Axillary roll" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 0, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group4
	 int group4MaxWidth = 0;
	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"LubricatedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Lubricated" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"HeadNeckNeutralKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Head / Neck neutral" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PressurePointsProtectedKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Pressure points protected" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(group4MaxWidth + 0, cursor.y -group4CursorStart.y);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 8;
	 previousElementSize = [BBPdfGenerator drawText:@"Extremities:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 4 + 8;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 4;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //start of draw group5
	 int group5MaxWidth = 0;
	 CGPoint group5CursorStart = cursor;

	 cursor.x += 8;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ArmsElbowsOnPaddedArmBoardKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Arm(s) & elbow(s) on padded armboard\n at less than 90 deg. with palm:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 20;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ArmsElbowsOnPaddedArmBoardUpKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Up" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 20;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ArmsElbowsOnPaddedArmBoardDownKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Down" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(group5MaxWidth + 8, cursor.y -group5CursorStart.y);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ArmsTuckedNeutralPositionKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Arm(s) tucked neutral position" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPostAnesthesiaEvalSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Post Anesthesia Eval" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Mental Status" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 group3Indentation = 15;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ArousableKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Arousable" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //start of draw group4
	 int group4MaxHeight = 0;

	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"MentalStatusOtherKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"MentalStatusOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 15, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group5
	 int group5MaxWidth = 0;
	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Cardiac/Resp/Airway Status:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 0 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 0;
	 }

	 group5Indentation = 15;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StableKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Stable" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 //start of draw group6
	 int group6MaxHeight = 0;

	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CardiacRespAirwayStatusOtherKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"CardiacRespAirwayStatusOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 0 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 0;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(group5MaxWidth + 15, cursor.y -group5CursorStart.y);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group7
	 int group7MaxWidth = 0;
	 CGPoint group7CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group7Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Complications" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 0 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 0;
	 }

	 group7Indentation = 15;
	 cursor.x += group7Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ComplicationsNoneKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"None" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 8 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 8;
	 }

	 //start of draw group8
	 int group8MaxHeight = 0;

	 CGPoint group8CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group8Indentation = 0;
	 group8Indentation = 0;
	 cursor.x += group8Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ComplicationsOtherKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"ComplicationsOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(cursor.x - group8CursorStart.x, group8MaxHeight);
	 cursor = group8CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 0 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 0;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(group7MaxWidth + 15, cursor.y -group7CursorStart.y);
	 cursor = group7CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group9
	 int group9MaxWidth = 0;
	 CGPoint group9CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group9Indentation = 0;
	 group9Indentation = 0;
	 cursor.x += group9Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"RR:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"RespiratoryRateKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group9Indentation + 8 > group9MaxWidth){
		 group9MaxWidth = previousElementSize.width + group9Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"HR:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"HeartRateKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group9Indentation + 8 > group9MaxWidth){
		 group9MaxWidth = previousElementSize.width + group9Indentation + 8;
	 }

	 //start of draw group10
	 int group10MaxHeight = 0;

	 CGPoint group10CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group10Indentation = 0;
	 group10Indentation = 0;
	 cursor.x += group10Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"BP:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"BpSystolicKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group10MaxHeight){
		 group10MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"/" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"BpDiastolicKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group10MaxHeight){
		 group10MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group10
	 previousElementSize = CGSizeMake(cursor.x - group10CursorStart.x, group10MaxHeight);
	 cursor = group10CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group9Indentation + 0 > group9MaxWidth){
		 group9MaxWidth = previousElementSize.width + group9Indentation + 0;
	 }

	 //end of draw group9
	 previousElementSize = CGSizeMake(group9MaxWidth + 0, cursor.y -group9CursorStart.y);
	 cursor = group9CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group11
	 int group11MaxWidth = 0;
	 CGPoint group11CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group11Indentation = 0;
	 group11Indentation = 0;
	 cursor.x += group11Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Temp:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"TemperatureKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group11Indentation + 8 > group11MaxWidth){
		 group11MaxWidth = previousElementSize.width + group11Indentation + 8;
	 }

	 //start of draw group12
	 int group12MaxHeight = 0;

	 CGPoint group12CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group12Indentation = 0;
	 group12Indentation = 0;
	 cursor.x += group12Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"SpO2:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"SpO2Key"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group12MaxHeight){
		 group12MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"%" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group12MaxHeight){
		 group12MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group12
	 previousElementSize = CGSizeMake(cursor.x - group12CursorStart.x, group12MaxHeight);
	 cursor = group12CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group11Indentation + 0 > group11MaxWidth){
		 group11MaxWidth = previousElementSize.width + group11Indentation + 0;
	 }

	 //end of draw group11
	 previousElementSize = CGSizeMake(group11MaxWidth + 0, cursor.y -group11CursorStart.y);
	 cursor = group11CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPostOpDiagnosisSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Post-Op Diagnosis" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"IN (mL)" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 group3Indentation = 15;
	 cursor.x += group3Indentation;
	 //start of draw group4
	 int group4MaxHeight = 0;

	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 //start of draw group5
	 int group5MaxWidth = 0;
	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Crystalloid:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Albumin:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Hetastarch:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(group5MaxWidth + 0, cursor.y -group5CursorStart.y);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group6
	 int group6MaxWidth = 0;
	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"CrystalloidKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"AlbuminKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"HetastarchKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group6Indentation + 8 > group6MaxWidth){
		 group6MaxWidth = previousElementSize.width + group6Indentation + 8;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(group6MaxWidth + 0, cursor.y -group6CursorStart.y);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group7
	 int group7MaxWidth = 0;
	 CGPoint group7CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 14;//margin top
	 int group7Indentation = 0;
	 group7Indentation = 0;
	 cursor.x += group7Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"PRBCs:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 8 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Cell Saver:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 8 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 8;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(group7MaxWidth + 0, cursor.y -group7CursorStart.y);
	 cursor = group7CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group8
	 int group8MaxWidth = 0;
	 CGPoint group8CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 14;//margin top
	 int group8Indentation = 0;
	 group8Indentation = 0;
	 cursor.x += group8Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"PrbcsKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group8Indentation + 8 > group8MaxWidth){
		 group8MaxWidth = previousElementSize.width + group8Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"CellSaverKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group8Indentation + 8 > group8MaxWidth){
		 group8MaxWidth = previousElementSize.width + group8Indentation + 8;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(group8MaxWidth + 0, cursor.y -group8CursorStart.y);
	 cursor = group8CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group9
	 int group9MaxWidth = 0;
	 CGPoint group9CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group9Indentation = 0;
	 group9Indentation = 0;
	 cursor.x += group9Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"FFP: " atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group9Indentation + 8 > group9MaxWidth){
		 group9MaxWidth = previousElementSize.width + group9Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"PLTs:" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group9Indentation + 8 > group9MaxWidth){
		 group9MaxWidth = previousElementSize.width + group9Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Cryo" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group9Indentation + 8 > group9MaxWidth){
		 group9MaxWidth = previousElementSize.width + group9Indentation + 8;
	 }

	 //end of draw group9
	 previousElementSize = CGSizeMake(group9MaxWidth + 0, cursor.y -group9CursorStart.y);
	 cursor = group9CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group10
	 int group10MaxWidth = 0;
	 CGPoint group10CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group10Indentation = 0;
	 group10Indentation = 0;
	 cursor.x += group10Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"FfpKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 8 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"PltsKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 8 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"CryoKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 8 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 8;
	 }

	 //end of draw group10
	 previousElementSize = CGSizeMake(group10MaxWidth + 0, cursor.y -group10CursorStart.y);
	 cursor = group10CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 15, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group11
	 int group11MaxWidth = 0;
	 CGPoint group11CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group11Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"OUT (mL)" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group11Indentation + 0 > group11MaxWidth){
		 group11MaxWidth = previousElementSize.width + group11Indentation + 0;
	 }

	 group11Indentation = 15;
	 cursor.x += group11Indentation;
	 //start of draw group12
	 int group12MaxHeight = 0;

	 CGPoint group12CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group12Indentation = 0;
	 group12Indentation = 0;
	 cursor.x += group12Indentation;
	 //start of draw group13
	 int group13MaxWidth = 0;
	 CGPoint group13CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group13Indentation = 0;
	 group13Indentation = 0;
	 cursor.x += group13Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"EBL: " atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group13Indentation + 8 > group13MaxWidth){
		 group13MaxWidth = previousElementSize.width + group13Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Urine: " atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group13Indentation + 8 > group13MaxWidth){
		 group13MaxWidth = previousElementSize.width + group13Indentation + 8;
	 }

	 //end of draw group13
	 previousElementSize = CGSizeMake(group13MaxWidth + 0, cursor.y -group13CursorStart.y);
	 cursor = group13CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group12MaxHeight){
		 group12MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group14
	 int group14MaxWidth = 0;
	 CGPoint group14CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group14Indentation = 0;
	 group14Indentation = 0;
	 cursor.x += group14Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"EblKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group14Indentation + 8 > group14MaxWidth){
		 group14MaxWidth = previousElementSize.width + group14Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"UrineKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group14Indentation + 8 > group14MaxWidth){
		 group14MaxWidth = previousElementSize.width + group14Indentation + 8;
	 }

	 //end of draw group14
	 previousElementSize = CGSizeMake(group14MaxWidth + 0, cursor.y -group14CursorStart.y);
	 cursor = group14CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group12MaxHeight){
		 group12MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group12
	 previousElementSize = CGSizeMake(cursor.x - group12CursorStart.x, group12MaxHeight);
	 cursor = group12CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group11Indentation + 0 > group11MaxWidth){
		 group11MaxWidth = previousElementSize.width + group11Indentation + 0;
	 }

	 //end of draw group11
	 previousElementSize = CGSizeMake(group11MaxWidth + 15, cursor.y -group11CursorStart.y);
	 cursor = group11CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPostProcedureGeneralSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Post-Procedure General Condition" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 group3Indentation = 0;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StableKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Stable" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"DentitionIntactKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Dentition Intact" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //start of draw group4
	 int group4MaxHeight = 0;

	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 group4Indentation = 0;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"OtherBoolKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 0;
	 
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 8;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"OtherTextKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group4MaxHeight){
		 group4MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(cursor.x - group4CursorStart.x, group4MaxHeight);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 0, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group5
	 int group5MaxWidth = 0;
	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 group5Indentation = 0;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"RR:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"RrKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"HR:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"HrKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 //start of draw group6
	 int group6MaxHeight = 0;

	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"BP:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"BpKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"/" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"Bp2Key"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 0 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 0;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(group5MaxWidth + 0, cursor.y -group5CursorStart.y);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group7
	 int group7MaxWidth = 0;
	 CGPoint group7CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group7Indentation = 0;
	 group7Indentation = 0;
	 cursor.x += group7Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Temp:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"TempKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 8 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 8;
	 }

	 //start of draw group8
	 int group8MaxHeight = 0;

	 CGPoint group8CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group8Indentation = 0;
	 group8Indentation = 0;
	 cursor.x += group8Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"SpO2:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"SpO2Key"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"%" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group8MaxHeight){
		 group8MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(cursor.x - group8CursorStart.x, group8MaxHeight);
	 cursor = group8CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group7Indentation + 0 > group7MaxWidth){
		 group7MaxWidth = previousElementSize.width + group7Indentation + 0;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(group7MaxWidth + 0, cursor.y -group7CursorStart.y);
	 cursor = group7CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPreOpActionsSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Anesthesia PreOp time used to:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Other Actions" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 cursor.x += 10;
	 for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherActionsKey"]).value) {
		 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawPremedsGivenSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Premeds given by RN in holding area:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Other premeds given:" atLocation:cursor];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
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
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 }

	 previousElementSize.width = group1MaxWidth;
	 previousElementSize.height = cursor.y - elemCursorStart.y;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 8 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 8;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}

+(CGSize) drawSpinalAnesthesiaSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
	 CGSize previousElementSize;
	 CGPoint cursor = sectionOrigin;
	 CGPoint elemCursorStart = sectionOrigin;
	 NSString *text;
	 //start of draw group1
	 int group1MaxWidth = 0;
	 CGPoint group1CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group1Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Spinal Anesthesia:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 group1Indentation = 15;
	 cursor.x += group1Indentation;
	 //start of draw group2
	 int group2MaxHeight = 0;

	 CGPoint group2CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group2Indentation = 0;
	 group2Indentation = 0;
	 cursor.x += group2Indentation;
	 //start of draw group3
	 int group3MaxWidth = 0;
	 CGPoint group3CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group3Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"CSF:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 0 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 0;
	 }

	 group3Indentation = 15;
	 cursor.x += group3Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CsfClearKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Clear" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CsfCloudyKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Cloudy" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CsfBloodyKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Bloody" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group3Indentation + 8 > group3MaxWidth){
		 group3MaxWidth = previousElementSize.width + group3Indentation + 8;
	 }

	 //end of draw group3
	 previousElementSize = CGSizeMake(group3MaxWidth + 15, cursor.y -group3CursorStart.y);
	 cursor = group3CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group4
	 int group4MaxWidth = 0;
	 CGPoint group4CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group4Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Position:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 0 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 0;
	 }

	 group4Indentation = 15;
	 cursor.x += group4Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PositionSitKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Sit" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PositionRtLatKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Rt Lat" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PositionLtLatKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Lt Lat" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group4Indentation + 8 > group4MaxWidth){
		 group4MaxWidth = previousElementSize.width + group4Indentation + 8;
	 }

	 //end of draw group4
	 previousElementSize = CGSizeMake(group4MaxWidth + 15, cursor.y -group4CursorStart.y);
	 cursor = group4CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group5
	 int group5MaxWidth = 0;
	 CGPoint group5CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group5Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Aseptic Technique:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 0 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 0;
	 }

	 group5Indentation = 15;
	 cursor.x += group5Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AsepticBetadineKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Betadine" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AsepticAlcoholKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Alcohol" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"AsepticDuraPrepKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"DuraPrep" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group5Indentation + 8 > group5MaxWidth){
		 group5MaxWidth = previousElementSize.width + group5Indentation + 8;
	 }

	 //end of draw group5
	 previousElementSize = CGSizeMake(group5MaxWidth + 15, cursor.y -group5CursorStart.y);
	 cursor = group5CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group2MaxHeight){
		 group2MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group2
	 previousElementSize = CGSizeMake(cursor.x - group2CursorStart.x, group2MaxHeight);
	 cursor = group2CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 8;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group6
	 int group6MaxHeight = 0;

	 CGPoint group6CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group6Indentation = 0;
	 group6Indentation = 0;
	 cursor.x += group6Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Interspace:" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"InterspaceKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 8;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"LocalInflitrationKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Local Inflitration" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group6MaxHeight){
		 group6MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group6
	 previousElementSize = CGSizeMake(cursor.x - group6CursorStart.x, group6MaxHeight);
	 cursor = group6CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //start of draw group7
	 int group7MaxHeight = 0;

	 CGPoint group7CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group7Indentation = 0;
	 group7Indentation = 0;
	 cursor.x += group7Indentation;
	 //start of draw group8
	 int group8MaxWidth = 0;
	 CGPoint group8CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group8Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Paresthesia:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group8Indentation + 0 > group8MaxWidth){
		 group8MaxWidth = previousElementSize.width + group8Indentation + 0;
	 }

	 group8Indentation = 15;
	 cursor.x += group8Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ParesthesiaNoneKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"None" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group8Indentation + 8 > group8MaxWidth){
		 group8MaxWidth = previousElementSize.width + group8Indentation + 8;
	 }

	 //start of draw group9
	 int group9MaxHeight = 0;

	 CGPoint group9CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group9Indentation = 0;
	 group9Indentation = 0;
	 cursor.x += group9Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"ParesthesiaOtherKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 0;
	 
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group9MaxHeight){
		 group9MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 8;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"ParesthesiaOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group9MaxHeight){
		 group9MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group9
	 previousElementSize = CGSizeMake(cursor.x - group9CursorStart.x, group9MaxHeight);
	 cursor = group9CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group8Indentation + 0 > group8MaxWidth){
		 group8MaxWidth = previousElementSize.width + group8Indentation + 0;
	 }

	 //end of draw group8
	 previousElementSize = CGSizeMake(group8MaxWidth + 15, cursor.y -group8CursorStart.y);
	 cursor = group8CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group10
	 int group10MaxWidth = 0;
	 CGPoint group10CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group10Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Spi Needle:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 0 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 0;
	 }

	 group10Indentation = 15;
	 cursor.x += group10Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"grams" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"SpiNeedleGramsKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 8 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 8;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"PencilPointKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Pencil Point" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 8 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 8;
	 }

	 //start of draw group11
	 int group11MaxHeight = 0;

	 CGPoint group11CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group11Indentation = 0;
	 group11Indentation = 0;
	 cursor.x += group11Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"SpiNeedleOtherKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 0;
	 
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group11MaxHeight){
		 group11MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 8;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"SpiNeedleOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group11MaxHeight){
		 group11MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group11
	 previousElementSize = CGSizeMake(cursor.x - group11CursorStart.x, group11MaxHeight);
	 cursor = group11CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 0 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Nr. of attempts" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"NrAttemptsKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group10Indentation + 8 > group10MaxWidth){
		 group10MaxWidth = previousElementSize.width + group10Indentation + 8;
	 }

	 //end of draw group10
	 previousElementSize = CGSizeMake(group10MaxWidth + 15, cursor.y -group10CursorStart.y);
	 cursor = group10CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
	 }

	 //start of draw group12
	 int group12MaxWidth = 0;
	 CGPoint group12CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group12Indentation = 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Med:" atLocation:cursor isBold:YES];
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group12Indentation + 0 > group12MaxWidth){
		 group12MaxWidth = previousElementSize.width + group12Indentation + 0;
	 }

	 group12Indentation = 15;
	 cursor.x += group12Indentation;
	 //start of draw group13
	 int group13MaxHeight = 0;

	 CGPoint group13CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group13Indentation = 0;
	 group13Indentation = 0;
	 cursor.x += group13Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"BupivacaineKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize = [BBPdfGenerator drawText:@"Bupivacaine 0.75%" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group13MaxHeight){
		 group13MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"BupivacaineMlKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group13MaxHeight){
		 group13MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"mL" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group13MaxHeight){
		 group13MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group13
	 previousElementSize = CGSizeMake(cursor.x - group13CursorStart.x, group13MaxHeight);
	 cursor = group13CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group12Indentation + 0 > group12MaxWidth){
		 group12MaxWidth = previousElementSize.width + group12Indentation + 0;
	 }

	 //start of draw group14
	 int group14MaxHeight = 0;

	 CGPoint group14CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group14Indentation = 0;
	 group14Indentation = 0;
	 cursor.x += group14Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"MedOtherKey"]).value boolValue] atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group14MaxHeight){
		 group14MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 text = ((TextElement*)[section getElementForKey:@"MedOtherReasonKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group14MaxHeight){
		 group14MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group14
	 previousElementSize = CGSizeMake(cursor.x - group14CursorStart.x, group14MaxHeight);
	 cursor = group14CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group12Indentation + 0 > group12MaxWidth){
		 group12MaxWidth = previousElementSize.width + group12Indentation + 0;
	 }

	 //start of draw group15
	 int group15MaxHeight = 0;

	 CGPoint group15CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group15Indentation = 0;
	 group15Indentation = 0;
	 cursor.x += group15Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Fentanyl" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"FentanylKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group15MaxHeight){
		 group15MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"mcg" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group15MaxHeight){
		 group15MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group15
	 previousElementSize = CGSizeMake(cursor.x - group15CursorStart.x, group15MaxHeight);
	 cursor = group15CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group12Indentation + 0 > group12MaxWidth){
		 group12MaxWidth = previousElementSize.width + group12Indentation + 0;
	 }

	 //start of draw group16
	 int group16MaxHeight = 0;

	 CGPoint group16CursorStart = cursor;

	 cursor.x += 0;//margin left
	 cursor.y += 0;//margin top
	 int group16Indentation = 0;
	 group16Indentation = 0;
	 cursor.x += group16Indentation;
	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"Duramorph" atLocation:cursor];
	 cursor.x += previousElementSize.width + 8;
	 
	 text = ((TextElement*)[section getElementForKey:@"DuramorphKey"]).value; 
	 if (text == nil || [text isEqualToString:@""]) {
		 text = @"\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0\u00a0";
	 } else {
		 text = [NSString stringWithFormat:@"\u00a0\u00a0\u00a0%@\u00a0\u00a0\u00a0", text];
	 } 
	 previousElementSize = [BBPdfGenerator drawText:text atLocation:cursor isUnderlined:YES];
	 cursor.x += previousElementSize.width + 8;
	 previousElementSize.width = cursor.x - elemCursorStart.x;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group16MaxHeight){
		 group16MaxHeight = previousElementSize.height + 0;
	 }

	 elemCursorStart = cursor;
	 cursor.x += 0;
	 cursor.y += 0;
	 previousElementSize = [BBPdfGenerator drawText:@"mcg" atLocation:cursor];
	 previousElementSize.width += 8 + 0;
	 previousElementSize.height += 0 + 0;
	 cursor = elemCursorStart;
	 cursor.x += previousElementSize.width + 8;
	 if ( previousElementSize.height + 0 > group16MaxHeight){
		 group16MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group16
	 previousElementSize = CGSizeMake(cursor.x - group16CursorStart.x, group16MaxHeight);
	 cursor = group16CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group12Indentation + 0 > group12MaxWidth){
		 group12MaxWidth = previousElementSize.width + group12Indentation + 0;
	 }

	 //end of draw group12
	 previousElementSize = CGSizeMake(group12MaxWidth + 15, cursor.y -group12CursorStart.y);
	 cursor = group12CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.x += previousElementSize.width + 0;
	 if ( previousElementSize.height + 0 > group7MaxHeight){
		 group7MaxHeight = previousElementSize.height + 0;
	 }

	 //end of draw group7
	 previousElementSize = CGSizeMake(cursor.x - group7CursorStart.x, group7MaxHeight);
	 cursor = group7CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 cursor.y += previousElementSize.height + 0;
	 if ( previousElementSize.width + group1Indentation + 0 > group1MaxWidth){
		 group1MaxWidth = previousElementSize.width + group1Indentation + 0;
	 }

	 //end of draw group1
	 previousElementSize = CGSizeMake(group1MaxWidth + 15, cursor.y -group1CursorStart.y);
	 cursor = group1CursorStart;

	 previousElementSize.width += 0;
	 previousElementSize.height += 0;
	 return previousElementSize;
}
@end




