//
//  FormElementTableCellFactory.h
//  iCare2
//
//  Created by Bogdan Marinescu on 9/22/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FormElement.h"
#import "AntibioticFormElement.h"
#import "MedicationFormElement.h"

@interface FormElementTableCellFactory : NSObject

+(UITableViewCell*) getCellForElement:(FormElement*)element reuseCell:(UITableViewCell*)cell;
+(AntibioticFormElement*)getElementForAntibioticCell:(UITableViewCell*)cell withElement:(AntibioticFormElement*)element;
+(MedicationFormElement*)getElementForMedicationCell:(UITableViewCell*)cell withElement:(MedicationFormElement*)element;
@end
