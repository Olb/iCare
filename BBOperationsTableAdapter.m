//
//  BPBGenericTableAdapter.m
//  iCare2
//
//  Created by billy bray on 9/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBOperationsTableAdapter.h"
#import "Operation.h"

@implementation BBOperationsTableAdapter

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [self.patient.operation count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *operationArray = [self.patient.operation allObjects];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OperationsCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OperationsCell"];
    }
    Operation *o = [operationArray objectAtIndex:indexPath.row];
    
    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:10];
    [nameLabel setText:o.name];
    
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"yyyy/MM/dd"];
    
    
    UILabel *dateLabel = (UILabel*)[cell.contentView viewWithTag:11];
    [dateLabel setText:[NSString stringWithFormat:@"PreOp Date: %@", [format stringFromDate:o.preOpDate]]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

@end
