//
//  BBPlannedOperationTableAdapter.m
//  iCare2
//
//  Created by Bogdan Marinescu on 8/30/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBPatientFormTableAdapter.h"

@implementation BBPatientFormTableAdapter

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
            cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsEvalCell"];
            break;
        case 1:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsIntraOpCell"];
            break;
        case 2:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsAnesthesiaRecordCell"];
            break;
        case 3:
            cell = [tableView dequeueReusableCellWithIdentifier:@"PatientFormsPostOpCell"];
            break;
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
