//
//  BBAutoCompleteTextFieldDelegate.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/8/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBAutoCompleteTextFieldDelegate.h"


@interface BBAutoCompleteTextFieldDelegate ()
@property NSArray *data;
@property NSMutableArray *filteredObjects;
@property UITableView *autocompleteTableView;
@end

@implementation BBAutoCompleteTextFieldDelegate

- (id)initWithData:(NSArray*)array
{
    self = [super init];
    if (self) {
        _data = array;
        _autocompleteTableView = [[UITableView alloc] init];
        _autocompleteTableView.delegate = self;
        _autocompleteTableView.dataSource = self;
        _autocompleteTableView.hidden = YES;
        _autocompleteTableView.layer.borderWidth = 2;
        _autocompleteTableView.layer.borderColor = [[UIColor lightGrayColor] CGColor];
        _filteredObjects = [[NSMutableArray alloc] initWithArray:_data];
    }
    return self;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *substring = [NSString stringWithString:textField.text];
    substring = [substring
                 stringByReplacingCharactersInRange:range withString:string];
    [self searchAutocompleteEntriesWithSubstring:substring];
    return YES;
}

- (void)searchAutocompleteEntriesWithSubstring:(NSString *)substring {

    [self.filteredObjects removeAllObjects];
    if ( [substring length] == 0 ){
        [self.filteredObjects addObjectsFromArray:_data];
        return;
    }
    for(NSString *curString in _data) {
        NSRange substringRange = [curString rangeOfString:substring options:NSCaseInsensitiveSearch];
        if (substringRange.length > 0) {
            [self.filteredObjects addObject:curString];
        }
    }
    [_autocompleteTableView reloadData];
    
}

-(void) textFieldDidBeginEditing:(UITextField *)textField
{
    _autocompleteTableView.hidden = NO;
}

-(void) textFieldDidEndEditing:(UITextField *)textField
{
    _autocompleteTableView.hidden = YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40.0f;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.filteredObjects count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"AutoCompleteTableViewCell"];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"AutoCompleteTableViewCell"];
    }
    cell.textLabel.text = [self.filteredObjects objectAtIndex:indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
//    
//    CGFloat labelStartX = cell.contentView.frame
//    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(<#CGFloat x#>, <#CGFloat y#>, <#CGFloat width#>, <#CGFloat height#>)]
    
    return cell;
}

-(void) setTableViewFrame:(CGRect)rect
{
    [[self.autoCompleteTextField superview] addSubview:_autocompleteTableView];

    [_autocompleteTableView setFrame:rect];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.autoCompleteTextField.text = [_filteredObjects objectAtIndex:indexPath.row];
    [self.autoCompleteTextField resignFirstResponder];
}

@end
