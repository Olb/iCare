//
//  BBDatePickerViewController.m
//  iCare
//
//  Created by Billy Bray on 2/7/14.
//  Copyright (c) 2014 Billy Bray. All rights reserved.
//

#import "BBDatePickerViewController.h"

@interface BBDatePickerViewController ()

@end

@implementation BBDatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.preferredContentSize = CGSizeMake(300.0f, 200.0f);
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 300, 34)];
    UIBarButtonItem *okButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStyleBordered target:self action:@selector(saveDate)];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButton)];
    UIBarButtonItem* space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem: UIBarButtonSystemItemFlexibleSpace
                                                                           target: nil
                                                                           action: nil];
    
    NSMutableArray *toolBarItems = [NSMutableArray array];
    [toolBarItems addObject:cancelButton];
    [toolBarItems addObject:space];
    [toolBarItems addObject: okButton];
    toolBar.items = toolBarItems;
    
    [self.navigationItem setLeftBarButtonItem:cancelButton animated:NO];
    [self.navigationItem setRightBarButtonItem:okButton animated:NO];
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.frame = CGRectMake(0, 20, 300, 200);
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    [self.view addSubview:toolBar];
    [self.view addSubview:self.datePicker];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.datePicker.date = [NSDate date];
}

UILabel *timeToSaveLabel;
-(void)setLabel:(UILabel*)label {
    timeToSaveLabel = label;
}

-(void)saveDate {
    self.date = [self.datePicker date];
    [self.delegate didSaveDateValues:self.date];
    [self.datePopoverController dismissPopoverAnimated:YES];

}

-(void)cancelButton {
    [self.datePopoverController dismissPopoverAnimated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
