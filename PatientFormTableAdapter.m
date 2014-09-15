//
//  BBPlannedOperationTableAdapter.m
//  iCare2
//
//  Created by Bogdan Marinescu on 8/30/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "PatientFormTableAdapter.h"

@implementation PatientFormTableAdapter

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger result = 0;
    
    result = 4;
    
    return result;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    switch (indexPath.row) {
        case 0:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsEvalCell"];
            UILabel *title = (UILabel*)[cell.contentView viewWithTag:2];
            title.text = @"PreOp Anesthesia Eval";
            break;
        }
        case 1:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsIntraOpCell"];
            UILabel *title = (UILabel*)[cell.contentView viewWithTag:2];
            title.text = @"IntraOp";
            break;
        }
        case 2:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsAnesthesiaRecordCell"];
            UILabel *title = (UILabel*)[cell.contentView viewWithTag:2];
            title.text = @"Anesthesia Record";
            break;
        }
        case 3:
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsPostOpCell"];
            UILabel *title = (UILabel*)[cell.contentView viewWithTag:2];
            title.text = @"PostOp";
            break;
        }
        default:
            break;
    }
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
