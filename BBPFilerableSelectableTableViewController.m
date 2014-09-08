//
//  BBTableViewPopoverController.m
//  iCare
//
//  Created by Billy Bray on 2/7/14.
//  Copyright (c) 2014 Billy Bray. All rights reserved.
//

#import "BBPFilerableSelectableTableViewController.h"
#import "BBPopoverCell.h"
#import "BBData.h"

@interface BBPFilerableSelectableTableViewController () <UITextFieldDelegate> {

}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITableView *procedureTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property NSArray *proceduresDataSet;
@property NSMutableArray *filteredObjects;
@property NSMutableArray *selectedObjects;
@end

@implementation BBPFilerableSelectableTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.proceduresDataSet = [BBData procedures];
    self.filteredObjects = [[NSMutableArray alloc] initWithArray:self.proceduresDataSet];
    self.selectedObjects = [[NSMutableArray alloc] init];
    
    [self.navigationItem setLeftBarButtonItem:self.cancelButton animated:NO];
    [self.navigationItem setRightBarButtonItem:self.saveButton animated:NO];
    
    [self.procedureTableView registerNib:[UINib nibWithNibName:@"PopoverTableCell"
                                                      bundle:[NSBundle mainBundle]]
                forCellReuseIdentifier:@"PopupCell"];

    [self.procedureTableView setAllowsSelectionDuringEditing:YES];
    [self.procedureTableView setAllowsMultipleSelectionDuringEditing:YES];

}

-(void)viewWillAppear:(BOOL)animated {
    
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat result = 40.0;
    
    return result;
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return  [self.filteredObjects count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BBPopoverCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"PopupCell"];
    if (cell == nil) {
        cell = [[BBPopoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PopupCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *cellLabel = (UILabel *)[cell.contentView viewWithTag:1];
    cellLabel.text = [self.filteredObjects objectAtIndex:indexPath.row];
    BBCheckBox *checkBox = (BBCheckBox *)[cell.contentView viewWithTag:2];
    
    [checkBox addTarget:self action:@selector(checkedBox:) forControlEvents:UIControlEventTouchUpInside];
    if ([self.selectedObjects containsObject:[self.filteredObjects objectAtIndex:indexPath.row]]) {
        checkBox.selected = TRUE;
    } else {
        checkBox.selected = FALSE;
    }
    
    return cell;
    
}

-(void)checkedBox:(id)sender
{
    BBCheckBox *sendingBox = (BBCheckBox*)sender;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.procedureTableView];
    NSIndexPath *indexPath = [self.procedureTableView indexPathForRowAtPoint:buttonPosition];
    if (!sendingBox.selected) {
        [self.selectedObjects removeObject:[self.filteredObjects objectAtIndex:indexPath.row]];
    } else {
        [self.selectedObjects addObject:[self.filteredObjects objectAtIndex:indexPath.row]];
    }
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
    [self.delegate didSaveValues:self.selectedObjects];
    [self dismissViewControllerAnimated:YES completion:nil];
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
    
    // Put anything that starts with this substring into the autocompleteUrls array
    // The items in this array is what will show up in the table view
    [self.filteredObjects removeAllObjects];
    if ( [substring length] == 0 ){
        [self.filteredObjects addObjectsFromArray:self.proceduresDataSet];
        return;
    }
    for(NSString *curString in self.proceduresDataSet) {
        NSRange substringRange = [curString rangeOfString:substring options:NSCaseInsensitiveSearch];
        if (substringRange.length > 0) {
            [self.filteredObjects addObject:curString];
        }
    }
    [self.procedureTableView reloadData];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
