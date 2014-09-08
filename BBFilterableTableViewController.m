//
//  BBFilterableTableViewController.m
//  iCare2
//
//  Created by Bogdan Marinescu on 9/4/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBFilterableTableViewController.h"
#import "BBPopoverCell.h"
#import "BBData.h"

@interface BBFilterableTableViewController () <UITextFieldDelegate> {
    NSMutableArray *pastProcedures;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveButton;
@property (weak, nonatomic) IBOutlet UITableView *procedureTableView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property NSArray *proceduresDataSet;
@end

@implementation BBProceduresTableViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.data = [BBData procedures];
    pastProcedures = [NSMutableArray arrayWithArray:self.proceduresDataSet];
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
    NSInteger result = 1;
    return result;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger result = [pastProcedures count];
    
    return  ;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    BBPopoverCell *cell = nil;
    cell = [tableView dequeueReusableCellWithIdentifier:@"PopupCell"];
    if (cell == nil) {
        cell = [[BBPopoverCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"PopupCell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *cellLabel = (UILabel *)[cell.contentView viewWithTag:1];
    cellLabel.text = [pastProcedures objectAtIndex:indexPath.row];
    BBCheckBox *checkBox = (BBCheckBox *)[cell.contentView viewWithTag:2];
    [checkBox addTarget:self action:@selector(checkedBox:) forControlEvents:UIControlEventTouchUpInside];
    if ([pastProcedures containsObject:[pastProcedures objectAtIndex:indexPath.row]]) {
        checkBox.selected = TRUE;
    } else {
        checkBox.selected = FALSE;
    }
    
    return cell;
    
}

-(void)checkedBox:(id)sender {
    BBCheckBox *sendingBox = (BBCheckBox*)sender;
    CGPoint buttonPosition = [sender convertPoint:CGPointZero toView:self.procedureTableView];
    NSIndexPath *indexPath = [self.procedureTableView indexPathForRowAtPoint:buttonPosition];
    if (!sendingBox.selected && [pastProcedures containsObject:[pastProcedures objectAtIndex:indexPath.row]]) {
        [pastProcedures removeObject:[self.proceduresDataSet objectAtIndex:indexPath.row]];
        return;
    }
    [pastProcedures addObject:[pastProcedures objectAtIndex:indexPath.row]];
    
}
- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)save:(id)sender {
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
    [pastProcedures removeAllObjects];
    for(NSString *curString in self.proceduresDataSet) {
        NSRange substringRange = [curString rangeOfString:substring options:NSCaseInsensitiveSearch];
        if (substringRange.length > 0) {
            [pastProcedures addObject:curString];
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