//
//  BBPdfSectionBuilder.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/17/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBPdfSectionBuilder.h"
#import "BBPdfGenerator.h"
#import "Form.h"
#import "Operation.h"
#import "Patient.h"
#import "FormSection.h"
#import "FormGroup.h"
#import "FormSection.h"
#import "BooleanFormElement.h"
#import "StringListElement.h"

@implementation BBPdfSectionBuilder

+(void) drawSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
    if ([section.title isEqualToString:@"PreOpActionsSectionKey"]){
        [BBPdfSectionBuilder drawPreOpSection:section atLocation:sectionOrigin];
    } else if ([section.title isEqualToString:@"PreOpActionsSectionKey"]){
    
    } else {
        [NSException raise:@"UnhandledSection" format:@"section title = '%@'",section.title];
    }
}


+(void) drawPreasdOpSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
    CGSize previousElementSize = CGSizeMake(0, 0);
    CGPoint elementOrigin = sectionOrigin;
    
    previousElementSize = [BBPdfGenerator drawText:@"Anesthesia PreOp time used to" atLocation:elementOrigin];
    
    elementOrigin.x = sectionOrigin.x + 10;
    elementOrigin.y += previousElementSize.height + 20;
    previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"CheckConsentsKey"]).value boolValue] atLocation:elementOrigin];
    
    elementOrigin.x += previousElementSize.width + 10;
    previousElementSize = [BBPdfGenerator drawText:@"Check consents and review chart/plan with Pt" atLocation:elementOrigin];
    
    
    elementOrigin.x = sectionOrigin.x + 10;
    elementOrigin.y += previousElementSize.height + 20;
    previousElementSize = [BBPdfGenerator drawCheckBoxChecked:[((BooleanFormElement*)[section getElementForKey:@"StartIvKey"]).value boolValue] atLocation:elementOrigin];
    
    elementOrigin.x += previousElementSize.width + 10;
    previousElementSize = [BBPdfGenerator drawText:@"Start IV" atLocation:elementOrigin];
    
    
    elementOrigin.x = sectionOrigin.x + 10;
    elementOrigin.y += previousElementSize.height + 20;
    previousElementSize = [BBPdfGenerator drawText:@"Other Actions" atLocation:elementOrigin];
    
    for (NSString *text in ((StringListElement*)[section getElementForKey:@"OtherActions"]).value) {
        elementOrigin.x = sectionOrigin.x + 10;
        elementOrigin.y += previousElementSize.height + 20;
        previousElementSize = [BBPdfGenerator drawText:text atLocation:elementOrigin];
    }
}

+(void) drawPreOpSection:(FormSection*)section atLocation:(CGPoint)sectionOrigin
{
    //init
    CGSize previousElementSize = CGSizeMake(0, 0);
    CGPoint cursor = sectionOrigin;
    
    //start drawing group1
    CGPoint group1CursorStart = cursor;
    int group1MaxHeight = 0;
    int group1Indentation = 0;
    
    previousElementSize = [BBPdfGenerator drawText:@"label1" atLocation:cursor];
    cursor.x += previousElementSize.width + 10;
    if ( previousElementSize.height + group1Indentation > group1MaxHeight){
        group1MaxHeight = previousElementSize.height + group1Indentation;
    }
    
    //start drawing group2
    CGPoint group2CursorStart = cursor;
    int group2MaxWidth = 0;
    int group2Indentation = 15;
    
    previousElementSize = [BBPdfGenerator drawText:@"group2" atLocation:cursor];
    cursor.y += previousElementSize.height + 20;
    if ( previousElementSize.width > group2MaxWidth){
        group2MaxWidth = previousElementSize.width + group2Indentation;
    }
    cursor.x += group2Indentation;
    
    previousElementSize = [BBPdfGenerator drawText:@"label2" atLocation:cursor];
    cursor.y += previousElementSize.height + 20;
    if ( previousElementSize.width + group2Indentation> group2MaxWidth){
        group2MaxWidth = previousElementSize.width + group2Indentation;
    }
    
    previousElementSize = [BBPdfGenerator drawText:@"label3" atLocation:cursor];
    cursor.y += previousElementSize.height + 20;
    if ( previousElementSize.width + group2Indentation> group2MaxWidth){
        group2MaxWidth = previousElementSize.width + group2Indentation;
    }
    
    //end of draw group2
    previousElementSize = CGSizeMake(group2MaxWidth, cursor.y - group2CursorStart.y);
    cursor = group2CursorStart;
    
    cursor.x += previousElementSize.width + 10;
    if ( previousElementSize.height + group1Indentation > group1MaxHeight){
        group1MaxHeight = previousElementSize.height + group1Indentation;
    }
    
    previousElementSize = [BBPdfGenerator drawText:@"label4" atLocation:cursor];
    cursor.x += previousElementSize.width + 10;
    if ( previousElementSize.height + group1Indentation > group1MaxHeight){
        group1MaxHeight = previousElementSize.height + group1Indentation;
    }
    
    //end of draw group1
    previousElementSize = CGSizeMake(cursor.x - group1CursorStart.x, group1MaxHeight);
    cursor = group1CursorStart;
    
    cursor.x += previousElementSize.width + 10;
    if ( previousElementSize.height + group1Indentation > group1MaxHeight){
        group1MaxHeight = previousElementSize.height + group1Indentation;
    }
    
    //init cursor
    
    //start of group1 daraw
    //remember cursor location
    
    //draw name3
    //move cursor to the right
    //check for maxHeght
    
        //start of group2 draw
        //remember cursor location
    
        //draw group label
        //move cursor down
        //check for max width
    
        //draw name1
        //move cursor down
        //check for max width
    
        //draw name2
        //move cursor down
        //check for max width
    
        //end of draw group2
        //rest cursor to group start
    //move cursor to the right by group width
    //check for max height
    
    //draw name4
    //move cursor right
    
    //end of draw group1
    //rest cursor to group start
    //move cursor to the right by group width
}

/*
 <Group1 h>
     <Element name="name1" lablel="label1" />
     <Group2 label="group2" v>
         <Element name="name2" lablel="label2" />
         <Element name="name3" lablel="label3" />
     </Group>
     <Element name="name4" lablel="label4" />
</Group>
 */

@end
