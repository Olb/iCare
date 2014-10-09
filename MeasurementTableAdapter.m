//
//  MeasurementTableAdapter.m
//  iCare
//
//  Created by Bogdan Marinescu on 10/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "MeasurementTableAdapter.h"
#import "IntraOp.h"
#import "Measurement.h"
#import "DoseView.h"
#import "GridConstants.h"


@interface MeasurementTableAdapter ()

@property NSMutableArray *measurementsArray;
@property NSString *type;

@end

@implementation MeasurementTableAdapter

-(id)initWithType:(NSString*)type
{
    if (self = [super init]) {
        _measurementsArray = [[NSMutableArray alloc] init];
        _type  = type;
    }
    return self;
}

-(void)loadData
{
    [self.measurementsArray removeAllObjects];
    for (Measurement *measurement in _intraOp.measurements) {
        if ([measurement.type isEqualToString:_type]) {
            BOOL alreadyAdded = false;
            for (NSMutableSet *set in _measurementsArray) {
                for (Measurement *m in set) {
                    if ([measurement.name isEqualToString:m.name] ) {
                        [set addObject:measurement];
                        alreadyAdded = true;
                    }
                    break;
                }
            }
            if (!alreadyAdded){
                NSMutableSet *measurementSet = [[NSMutableSet alloc] init];
                [measurementSet addObject:measurement];
                [_measurementsArray addObject:measurementSet];
            }
        }
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [self loadData];
    return self.measurementsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Measurement Cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Measurement Cell"];
        cell.bounds = CGRectMake(cell.bounds.origin.x, cell.bounds.origin.y, cell.bounds.size.width, 22.0);
    }
    Measurement *measurement = (Measurement*)[(NSSet*)[self.measurementsArray objectAtIndex:indexPath.row] anyObject];
    if (measurement.unit){
        cell.textLabel.text = [NSString stringWithFormat:@"%@ (%@)", measurement.name, measurement.unit];
    } else {
        cell.textLabel.text = measurement.name;
    }
    cell.textLabel.font = [UIFont systemFontOfSize:14.0f];
    [cell.contentView.subviews makeObjectsPerformSelector: @selector(removeFromSuperview)];
    
    for (Measurement *measurement in [self.measurementsArray objectAtIndex:indexPath.row]) {
        [cell.contentView addSubview:[self.controller viewForMeasurement:measurement forCell:cell]];
    }
    
    UIView* bg = [[UIView alloc] initWithFrame:CGRectMake(0, 0, FIRST_COLUMN_X_COORD, cell.frame.size.height)];
    bg.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:bg];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


@end
