//
//  BPBGenericTableAdapter.m
//  iCare2
//
//  Created by billy bray on 9/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "OperationsTableAdapter.h"
#import "Operation.h"
#import "BBUtil.h"

@interface OperationsTableAdapter ()
@property (strong,nonatomic) NSArray *operationArray;
@end

@implementation OperationsTableAdapter

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    _operationArray = [self.patient.operations allObjects];
    return [self.patient.operations count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"OperationsCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"OperationsCell"];
    }
    Operation *o = [_operationArray objectAtIndex:indexPath.row];
    
    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:10];
    [nameLabel setText:o.name];
    
    UILabel *dateLabel = (UILabel*)[cell.contentView viewWithTag:11];
    [dateLabel setText:[BBUtil formatDate:o.preOpDate]];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    // 1. Dequeue the custom header cell
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"OperationHeaderCell"];
    
    UILabel *nameLabel = (UILabel*)[cell.contentView viewWithTag:12];
    nameLabel.font = [UIFont fontWithName:@"AvenirNext-Regular" size:14.0];
    [nameLabel setText:@"Operation"];
    
    cell.backgroundColor = [UIColor colorWithRed:193.0/255.0 green:233.0/255.0 blue:199.0/255.0 alpha:1.0];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Operation *op = [_operationArray objectAtIndex:indexPath.row];
        [_patient removeOperationsObject: op];
        
        NSManagedObjectContext *context = [_patient managedObjectContext];
        [context deleteObject:op];
        
        NSError *err;
        if ( ! [context save:&err] ) {
            [NSException raise:@"DatabaseError" format:@"Context failed to save: %@", [err description]];
        }
        
        [tableView reloadData];
        if ([self.delegate respondsToSelector:@selector(operationDeleted:)]) {
            [self.delegate operationDeleted:op];
        }
    }
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ( [self.delegate respondsToSelector:@selector(operationSelected:fromPatient:)] ){
        [self.delegate operationSelected:[_operationArray objectAtIndex:indexPath.row] fromPatient:_patient];
    }
}

@end
