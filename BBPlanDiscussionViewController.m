//
//  BBPlanDiscussionViewController.m
//  iCare2
//
//  Created by billy bray on 8/26/14.
//  Copyright (c) 2014 Spartan Systems Inc. All rights reserved.
//

#import "BBPlanDiscussionViewController.h"

@interface BBPlanDiscussionViewController ()

@end

@implementation BBPlanDiscussionViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
