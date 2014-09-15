//
//  BBStringArrayTableAdapter.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/11/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "StringArrayTableAdapter.h"

@implementation StringArrayTableAdapter

- (id) init {
    if (self = [super init]){
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.items count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"StringArrayTableCell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"StringArrayTableCell"];
    }
    
    cell.textLabel.text = [self.items objectAtIndex:indexPath.row];
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSString *deletedString = [self.items objectAtIndex:indexPath.row];
        [self.items removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
        if ([self.delegate respondsToSelector:@selector(itemDeleted:atIndexPathRow:)]) {
            [self.delegate itemDeleted:deletedString  atIndexPathRow:indexPath.row];
        }
    }
}

@end
