//
//  FormElementTableCellFactory.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/22/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "FormElementTableCellFactory.h"
#import "AntibioticFormElement.h"
#import "BBUtil.h"
#import "MedicationFormElement.h"

@implementation FormElementTableCellFactory


+(UITableViewCell*) getCellForElement:(FormElement*)element reuseCell:(UITableViewCell*)cell{
    
    if ([element isKindOfClass:[AntibioticFormElement class]]){
        AntibioticFormElement* e = (AntibioticFormElement*)element;
        if (!cell){
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"AntibioticElementCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:1];
        UILabel *doseLabel = (UILabel*)[cell.contentView viewWithTag:2];
        UILabel *doseUnitLabel = (UILabel*)[cell.contentView viewWithTag:3];
        UILabel *startTimeLabel = (UILabel*)[cell.contentView viewWithTag:4];
        nameLabel.text = e.name;
        doseLabel.text = e.dose;
        doseUnitLabel.text = e.doseUnit;
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"HH:mm"];
        
        startTimeLabel.text = [formatter stringFromDate:e.startTime];
    } else if([element isKindOfClass:[MedicationFormElement class]]) {
        MedicationFormElement* e = (MedicationFormElement*)element;
        if (!cell){
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MedicationElementCell" owner:self options:nil];
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = [topLevelObjects objectAtIndex:0];
        }
        UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:1];
        UILabel *doseLabel = (UILabel*)[cell.contentView viewWithTag:2];
        UILabel *doseUnitLabel = (UILabel*)[cell.contentView viewWithTag:3];
        nameLabel.text = e.name;
        doseLabel.text = e.dose;
        doseUnitLabel.text = e.doseUnit;
    }
    else {
        [NSException raise:@"Unhandled Form Element" format:@"Unhandled form element type: '%@'", [element class]];
    }
    
    return cell;
}

+(AntibioticFormElement*)getElementForAntibioticCell:(UITableViewCell*)cell withElement:(AntibioticFormElement*)element
{
    if (element == nil) {
        element = (AntibioticFormElement*)[BBUtil newCoreDataObjectForEntityName:@"AntibioticFormElement"];
    }
    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:1];
    UILabel *doseLabel = (UILabel*)[cell.contentView viewWithTag:2];
    UILabel *doseUnitLabel = (UILabel*)[cell.contentView viewWithTag:3];
    UILabel *startTimeLabel = (UILabel*)[cell.contentView viewWithTag:4];
    element.name = nameLabel.text;
    element.dose = doseLabel.text;
    element.doseUnit = doseUnitLabel.text;
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"HH:mm"];
    NSDate *date = [formatter dateFromString:startTimeLabel.text];
    element.startTime = date;
    
    return element;
}

+(MedicationFormElement*)getElementForMedicationCell:(UITableViewCell*)cell withElement:(MedicationFormElement*)element
{
    if (element == nil) {
        element = (MedicationFormElement*)[BBUtil newCoreDataObjectForEntityName:@"MedicationFormElement"];
    }
    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:1];
    UILabel *doseLabel = (UILabel*)[cell.contentView viewWithTag:2];
    UILabel *doseUnitLabel = (UILabel*)[cell.contentView viewWithTag:3];
    element.name = nameLabel.text;
    element.dose = doseLabel.text;
    element.doseUnit = doseUnitLabel.text;
 
    return element;
}


@end
